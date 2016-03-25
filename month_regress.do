// monthly regression
cd ${SRC}
use totexp_mc, clear

merge n:1 month using rrWieland
drop _merge
drop date

merge n:1 month using ffmonth
drop _merge

merge n:1 month using indpro
drop _merge


tsset month
drop if year(dofm(month))>2007

// state dependence
gen dindpro = d.indpro
tssmooth ma z=dindpro,window(9 1 9)
sum z
replace z = (z-r(mean))/r(sd)
gen F=exp(-1.5*z)/(1+exp(-1.5*z))
gen G=1-F


rename resid_full resid

gen totexp1=TOTC1
gen totexp2=TOTC2
gen totexp3=TOTC3

gen totexp=totexp1+totexp2+totexp3
foreach v in indpro totexp1 totexp2 totexp3{
	gen l`v'=log(`v')
}


gen tt=month-month[1]
gen tt2 = tt^2

capture drop res0
gen res0=.
forval t=0/70 {
	reg f`t'.ltotexp2 resid L(1/2).ltotexp2
	replace res0=_b[resi] if _n==`t'
}
tsline res0 if res0~=.

forval lag=1/16{
	quiet reg f1.ltotexp2 resid L(1/`lag').ltotexp2 L(1/`lag').resid tt
	quiet estat ic
	matrix icResult = r(S)
	local BIC=icResult[1,6]
	display `BIC'
}

capture drop res0
gen res0=.
forval t=0/72 {
	reg f`t'.ltotexp3 resid L(1/4).ltotexp3 L(1/4).resid
	replace res0=_b[resi] if _n==`t'
}
tsline res0 if res0~=.

capture drop res0
gen res0=.
forval t=0/72 {
	reg f`t'.ltotexp2 resid L(1/2).ltotexp2 L(1/2).resid L(1/2).FEDFUNDS
	replace res0=_b[resi] if _n==`t'
}
tsline res0 if res0~=.

capture drop res0
gen res0=.
forval t=0/72 {
	reg f`t'.ltotexp1 resid L(1/2).ltotexp1 L(1/2).resid L(1/2).FEDFUNDS
	replace res0=_b[resi] if _n==`t'
}
tsline res0 if res0~=.



capture drop res0
gen res0=.
forval t=0/70 {
	reg f`t'.ltotexp1 resid L(1/4).ltotexp1 L(1/4).FEDFUNDS L(1/4).resid tt
	replace res0=_b[resi] if _n==`t'
}
tsline res0 if res0~=.


cap drop res0*
gen res0R=.
gen res0E=.
forval t=1/60 {
	reg f`t'.ltotexp F G c.F#c.resid c.G#c.resid c.F#c.L(1/4).ltotexp c.G#c.L(1/4).ltotexp ///
		c.F#c.L(1/4).resid c.G#c.L(1/4).resid, nocons
	replace res0R = _b[c.F#c.resid] if _n==`t'
	replace res0E = _b[c.G#c.resid] if _n==`t'
}
twoway(tsline res0E if res0E~=.)(tsline res0R if res0R~=.)

cap drop res0*
gen res0R=.
gen res0E=.
forval t=1/25 {
	reg f`t'.ltotexp2 F G c.F#c.resid c.G#c.resid c.F#c.L(1/4).ltotexp2 c.G#c.L(1/4).ltotexp2 ///
		c.F#c.L(1/4).resid c.G#c.L(1/4).resid, nocons
	replace res0R = _b[c.F#c.resid] if _n==`t'
	replace res0E = _b[c.G#c.resid] if _n==`t'
}
twoway(tsline res0E if res0E~=.)(tsline res0R if res0R~=.)


/***************** totexp_t ****************/
// state dependence
cap drop res0*
gen res0R=.
gen res0E=.
forval t=1/25 {
	reg f`t'.ltotexp2 F G c.F#c.resid c.G#c.resid c.F#c.L(1/4).ltotexp2 c.G#c.L(1/4).ltotexp2 ///
		c.F#c.L(1/4).FEDFUNDS c.G#c.L(1/4).FEDFUNDS tt, nocons
	replace res0R = _b[c.F#c.resid] if _n==`t'
	replace res0E = _b[c.G#c.resid] if _n==`t'
}
twoway(tsline res0E if res0E~=.)(tsline res0R if res0R~=.)
