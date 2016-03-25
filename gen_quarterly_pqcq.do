// gen quarterly data
use fmli_cqpq_clear, clear

// Some sample selection
// keep age 
keep if AGE_REF>=25 & AGE_REF<=75
gen UID=int(NEWID/10)
merge n:1 UID surveyYear using ir_clear
drop _merge
replace vrtile=3 if vrtile==.
// sample distribution
tab vrtile

collapse (mean)totexp, by(quarter)
rename totexp TOTC
tsset quarter, q
foreach v in TOTC {
	sax12 `v'`i', satype(single) noview
	sax12im `v'`i', ext(d11)
	replace `v'`i'=`v'`i'_d11
	drop `v'`i'_d11
}
save totexp_allc,replace

collapse (mean)totexp, by(quarter vrtile)
rename totexp TOTC
reshape wide TOTC, i(quarter) j(vrtile)
tsset quarter, q
foreach v in TOTC {
	forval i=1/3{
		sax12 `v'`i', satype(single) noview
		sax12im `v'`i', ext(d11)
		replace `v'`i'=`v'`i'_d11
		drop `v'`i'_d11
	}
}
save totexp_qc,replace
