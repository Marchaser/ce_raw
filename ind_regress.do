



xtset UID month
forval lag=0/16 {
	replace month=month-`lag'
	merge n:1 month using rrWieland
	drop if _merge==2
	drop _merge
	rename resid_full resid_full`lag'
	rename resid_romer resid_romer`lag'
	replace month=month+`lag'
}
save exp_clear2, replace


gen cons=NONDURA+SERVICE
gen lcons=log(cons)
sort UID month
gen dcons = d.cons
gen dlcons=d.lcons

gen monthnum=month(dofm(month))
forval i=1/16{
rename resid_romer`i' romer`i'
}
forval i=1/16{
rename resid_full`i' full`i'
}
xtreg dlcons L(1/4).dlcons full* i.monthnum, fe
