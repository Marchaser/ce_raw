// extract UCC
forval year=1984/2013{
clear
forval quarter=1/5{
	cap append using ${SRC}\e\e`year'q`quarter'
}
collapse (count)NEWID, by(UCC)
save u/u`year', replace
}

// categorize UCC using official classification
forval year=1984/2012{
	cap use u/u`year', clear
	if _rc==0 {
		do ${CODE}\ucc_code\uccClear`year'.do
		
		if `year'<1994 {
			gen NONDURA=1 if FOOD | ALCBEV | APPAR | READ | TOBACC | MISC
			replace NONDURA=0 if NONDURA==.

			gen DURA=1 if HOUSEQ | OTHLOD | VEHICL | TVRDIO | OTHEQP
			replace DURA=0 if DURA==.

			gen SERVICE=1 if RENDWE | UTIL | HOUSOP | OTHVEH | GASMO | PUBTRA | HEALTH | FEEADM | PERSCA | EDUCA
			replace SERVICE=0 if SERVICE==.
		}
		
		if `year'>=1994 {
			gen NONDURA=1 if FOOD | ALCBEV | APPAR | READ | TOBACC | MISC
			replace NONDURA=0 if NONDURA==.

			gen DURA=1 if HOUSEQ | OTHLOD | VEHICL | TVRDIO | OTHEQP
			replace DURA=0 if DURA==.

			gen SERVICE=1 if RENDWE | UTIL | HOUSOP | OTHVEH | GASMO | PUBTRA | HEALTH | FEEADM | PERSCA | EDUCA
			replace SERVICE=0 if SERVICE==.
		}
		
		gen TOTEXP2 = 1 if NONDURA | DURA | SERVICE
		replace TOTEXP2=0 if TOTEXP2==.
		
		gen surveyYear=`year'
		save ${SRC}/uc/uc`year', replace
	}
}

// aggregate household level consumption
forval year=1984/2012{
forval quarter=1/5{
	cap use ${SRC}\e\e`year'q`quarter', clear
	if _rc==0 {
		merge n:1 UCC using ${SRC}/uc/uc`year'
		keep if _merge==3
		drop _merge
		
		local vars "FOOD ALCBEV APPAR READ TOBACC MISC HOUSEQ OTHLOD VEHICL TVRDIO OTHEQP RENDWE UTIL HOUSOP OTHVEH GASMO PUBTRA HEALTH FEEADM PERSCA EDUCA"
		
		foreach ivar of var `vars' {
			replace `ivar' = COST * `ivar'
		}
		collapse (sum)`vars', by(NEWID REF_MO REF_YR)
		gen surveyYear = `year'
		save ec\ec`year'q`quarter', replace
	}
}
}

// stack all year quarter together
clear
forval year=1984/2012{
forval quarter=1/5{
	cap append using ${SRC}\ec\ec`year'q`quarter'
}
}
drop if FOOD==0
destring REF_MO REF_YR, force replace
replace REF_YR = REF_YR+1900 if REF_YR<1900
save ec\ec_all, replace

// trial for monthly aggregate
use ec\ec_all, clear
collapse (mean)FOOD ALCBEV APPAR READ TOBACC MISC HOUSEQ OTHLOD VEHICL TVRDIO OTHEQP RENDWE UTIL HOUSOP OTHVEH GASMO PUBTRA HEALTH FEEADM PERSCA EDUCA, by(REF_MO REF_YR)
gen daten=ym(REF_YR,REF_MO)
tsset daten, m
tsline HEALTH
tsline READ
tsline TOBACC
tsline FOOD
tsline APPAR
tsline VEHICL
tsline HOUSEQ
tsline TVRDIO
tsline OTHVEH
tsline GASMO
tsline PUBTRA
tsline RENDWE
tsline FEEADM
