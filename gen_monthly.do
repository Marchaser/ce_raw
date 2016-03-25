// Moonthly 
use totexp_m, clear
collapse (sum)NONDURA SERVICE DURA TOTC, by(month vrtile)
reshape wide NONDURA SERVICE DURA TOTC, i(month) j(vrtile)
tsset month,m
drop if year(dofm(month))<1984
drop if year(dofm(month))>2007
foreach v in NONDURA SERVICE DURA TOTC {
	forval i=1/3{
		sax12 `v'`i', satype(single) noview
		sax12im `v'`i', ext(d11)
		replace `v'`i'=`v'`i'_d11
		drop `v'`i'_d11
	}
}
save totexp_mc,replace
twoway(tsline TOTC1)(tsline TOTC2)(tsline TOTC3)
