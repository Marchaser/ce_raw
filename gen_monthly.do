// Moothly 
use ec\ec_all, clear
gen UID = int(NEWID/10)
gen month=ym(REF_YR,REF_MO)
merge n:1 UID surveyYear using ir_clear
drop _merge
merge n:1 NEWID surveyYear using fmli_clear
drop _merge
keep if BLS_URBN==1
keep if AGE_REF>=25 & AGE_REF<=75
gen NONDURA = FOOD + ALCBEV + APPAR + READ + TOBACC + MISC
gen DURA = HOUSEQ + OTHLOD + VEHICL + TVRDIO + OTHEQP
gen SERVICE = RENDWE + UTIL + HOUSOP + OTHVEH + GASMO + PUBTRA + HEALTH + FEEADM + PERSCA + EDUCA
gen TOTEXP = NONDURA + DURA + SERVICE

collapse (mean)NONDURA DURA SERVICE TOTEXP FOOD ALCBEV APPAR READ TOBACC MISC HOUSEQ OTHLOD VEHICL TVRDIO OTHEQP RENDWE UTIL HOUSOP OTHVEH GASMO PUBTRA HEALTH FEEADM PERSCA EDUCA [pw=FINLWT21], by(month vrtile)
save ec_m, replace

/********** quarterly all *************/
use ec\ec_all, clear
gen UID = int(NEWID/10)
gen month=ym(REF_YR,REF_MO)
merge n:1 UID surveyYear using ir_clear
drop _merge
merge n:1 NEWID surveyYear using fmli_clear
drop _merge
keep if BLS_URBN==1
keep if AGE_REF>=25 & AGE_REF<=75
gen NONDURA = FOOD + ALCBEV + APPAR + READ + TOBACC + MISC
gen DURA = HOUSEQ + OTHLOD + VEHICL + TVRDIO + OTHEQP
gen SERVICE = RENDWE + UTIL + HOUSOP + OTHVEH + GASMO + PUBTRA + HEALTH + FEEADM + PERSCA + EDUCA
gen TOTEXP = NONDURA + DURA + SERVICE
collapse (mean)NONDURA DURA SERVICE TOTEXP FOOD ALCBEV APPAR READ TOBACC MISC HOUSEQ OTHLOD VEHICL TVRDIO OTHEQP RENDWE UTIL HOUSOP OTHVEH GASMO PUBTRA HEALTH FEEADM PERSCA EDUCA [pw=FINLWT21], by(month)
drop if year(dofm(month))<1984
drop if year(dofm(month))>2007
gen quarter = qofd(dofm(month))
collapse (sum) NONDURA DURA SERVICE TOTEXP, by(quarter)
tsset quarter,q
foreach v in NONDURA SERVICE DURA TOTEXP {
	sax12 `v'`i', satype(single) noview
	sax12im `v'`i', ext(d11)
	replace `v'`i'=`v'`i'_d11
	drop `v'`i'_d11
}
save totexp_allc,replace

/*********** quarterly ****************/
use ec_m, clear
replace vrtile = 3 if vrtile==.
drop if year(dofm(month))<1984
drop if year(dofm(month))>2007
gen quarter = qofd(dofm(month))
collapse (sum) NONDURA DURA SERVICE TOTEXP, by(quarter vrtile)
reshape wide NONDURA SERVICE DURA TOTEXP, i(quarter) j(vrtile)
tsset quarter,q
foreach v in NONDURA SERVICE DURA TOTEXP {
	forval i=1/3{
		sax12 `v'`i', satype(single) noview
		sax12im `v'`i', ext(d11)
		replace `v'`i'=`v'`i'_d11
		drop `v'`i'_d11
	}
}
save totexp_qc,replace
twoway(tsline TOTEXP1)(tsline TOTEXP2)(tsline TOTEXP3)


/************* monthly **********************/
use ec_m, clear
replace vrtile = 3 if vrtile==.
keep NONDURA DURA SERVICE TOTEXP month vrtile
reshape wide NONDURA SERVICE DURA TOTEXP, i(month) j(vrtile)

tsset month,m
drop if year(dofm(month))<1984
drop if year(dofm(month))>2007
foreach v in NONDURA SERVICE DURA TOTEXP {
	forval i=1/3{
		sax12 `v'`i', satype(single) noview
		sax12im `v'`i', ext(d11)
		replace `v'`i'=`v'`i'_d11
		drop `v'`i'_d11
	}
}
save totexp_mc,replace
twoway(tsline TOTEXP1)(tsline TOTEXP2)(tsline TOTEXP3)
