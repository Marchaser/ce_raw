// Merge with household information
use exp_clear, clear
merge n:1 NEWID using fmli_clear,keepusing(AGE_REF CUTENURE FAM_SIZE FINCATAX FINLWT21 surveyYear)
keep if _merge==3
drop _merge

// Some sample selection
// keep age 
keep if AGE_REF>=25 & AGE_REF<=75
// keep if FOOD is positive 
drop if FOOD<=0
gen UID=int(NEWID/10)

merge n:1 UID using ir_clear
drop _merge
replace vrtile=3 if vrtile==.
// sample distribution
tab vrtile
save exp_clear2, replace

// Deflate
use exp_clear2, clear
// Collapse by month
#delimit ;
collapse (mean)FOOD ALCBEV MRTINTP MRPINS RENDWE OTHLOD UTIL
		HOUSOP HOUSEQ APPAR CARTKN CARTKU OTHVEH GASMO VEHFIN MAINRP VEHINS
		VRNTLO PUBTRA HEALTH FEEADM TVRDIO OTHEQP
		PERSCA READ EDUCA TOBACC MISC INSUR PENSION [pw=FINLWT21], by(REF_YR REF_MO vrtile);
#delimit cr
// deflated using categorized cpi
// merge with cpi
merge n:1 REF_YR REF_MO using cpi_clear
keep if _merge==3
drop _merge
foreach var in FOOD {
	replace `var' = `var' / cpi_food
}

foreach var in GASMO {
	replace `var' = `var' / cpi_energy_comm
}

foreach var in UTIL {
	replace `var' = `var' / cpi_energy_service
}

foreach var in APPAR {
	replace `var' = `var' / cpi_apparel
}

foreach var in CARTKN {
	replace `var' = `var' / cpi_newcars
}

foreach var in ALCBEV {
	replace `var' = `var' / cpi_alcbev
}

foreach var in TOBACC {
	replace `var' = `var' / cpi_tabacco
}

foreach var in MRTINTP MRPINS RENDWE OTHLOD HOUSOP HOUSEQ {
	replace `var' = `var' / cpi_shelter
}

foreach var in HEALTH PERSCA {
	replace `var' = `var' / cpi_health_service
}

foreach var in OTHVEH VEHFIN MAINRP VEHINS VRNTLO {
	replace `var' = `var' / cpi_transport
}

foreach var in FEEADM TVRDIO OTHEQP READ EDUCA MISC INSUR PENSION {
	replace `var' = `var' / cpi_others
}

gen NONDURA=FOOD+ALCBEV+APPAR+GASMO+READ+TOBACC
gen SERVICE=MRPINS+UTIL+HOUSOP+MAINRP+VRNTLO+PUBTRA+FEEADM+OTHEQP+PERSCA+HEALTH+EDUCA+MISC
gen DURA=HOUSEQ+CARTKN+CARTKU+OTHVEH+VEHFIN+VEHINS+TVRDIO+MRTINTP+RENDWE+OTHLOD
gen TOTC = NONDURA+SERVICE+DURA

gen month=ym(REF_YR,REF_MO)
save totexp_m,replace

gen quarter=qofd(dofm(month))

/*************************/
// aggregate by quarter
collapse (sum)NONDURA SERVICE DURA TOTC, by(quarter vrtile)

reshape wide NONDURA SERVICE DURA TOTC, i(quarter) j(vrtile)
save totexp_q,replace

use totexp_q, clear
tsset quarter,q
foreach v in NONDURA SERVICE DURA TOTC {
	forval i=1/3{
		sax12 `v'`i', satype(single) noview
		sax12im `v'`i', ext(d11)
		replace `v'`i'=`v'`i'_d11
		drop `v'`i'_d11
	}
}
save totexp_qc,replace

twoway(tsline TOTC1)(tsline TOTC2)(tsline TOTC3)
