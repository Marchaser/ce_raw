// monthly regression
use totexp_qc, clear

merge 1:1 quarter using totexp_allc
drop _merge

merge n:1 quarter using rrWieland_q
drop _merge

merge n:1 quarter using ffmonth_q
drop _merge

merge n:1 quarter using fredData
drop _merge

tsset quarter,q

drop if year(dofq(quarter))>2007

rename resid_full resid

gen totexp1 = TOTC1
gen totexp2 = TOTC2
gen totexp3 = TOTC3

gen totexp=totexp1+totexp2
foreach v in rgdp rgdppc cpi_u totexp1 totexp2 totexp3 totexp{
	gen l`v'=log(`v')
}
gen infla=d.lcpi_u

gen totexp1q = totexp1
gen totexp2q = totexp2
gen totexp3q = totexp3

set scheme s1mono
tsline totexp1q totexp2q totexp3q if totexp1q~=., lstyle(p1 p4) legend(label(1 "Less risky") label(2 "More risky") label(3 "Others")) ///
xtitle("Quarter") ///
ytitle("1984 $") ///
title("Quarterly Expenditure")
graph export exp_by_risk.pdf, replace


tsfilter hp lrgdp_res=lrgdp, smooth(10000)
gen dlrgdp = d.lrgdp
tssmooth ma z=dlrgdp,window(3 1 3)
sum z
replace z = (z-r(mean))/r(sd)
gen F=exp(-1.5*z)/(1+exp(-1.5*z))
gen G=1-F


gen tt=quarter

forval lag=1/16{
	quiet reg f.ltotexp resid L(1/`lag').ltotexp L(1/`lag').resid
	quiet estat ic
	matrix icResult = r(S)
	local BIC=icResult[1,6]
	display `BIC'
}

gen period=_n

capture drop res0*
cap drop res0se
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.ltotexp3 resid L(1/2).ltotexp3 L(1/2).resid period L(1/2).FEDFUNDS
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
replace res0=-25*res0
replace res0se=res0se*25
gen res0ub=res0+res0se
gen res0lb=res0-res0se
twoway ///
(rarea res0ub res0lb period if res0~=., color(gs14)) ///
(line res0 period if res0~=.), legend(off) xtitle(Quarters) ///
title("All households") ///
yscale(range(-1.5 2.5)) ylabel(-1(1)2.5) ///
ytitle("% in expenditure") ///
saving(resp_total, replace)
// graph export resp_total.pdf, replace

capture drop res0*
cap drop res0se
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.ltotexp2 resid L(1/2).ltotexp2 L(1/2).resid period L(1/2).FEDFUNDS
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
replace res0=-25*res0
replace res0se=res0se*25
gen res0ub=res0+res0se
gen res0lb=res0-res0se
twoway ///
(rarea res0ub res0lb period if res0~=., color(gs14)) ///
(line res0 period if res0~=.), legend(off) xtitle(Quarters) ///
title("More risky households") ///
yscale(range(-1.5 2.5)) ylabel(-1(1)2.5) ///
saving(resp_risky, replace)
/// graph export resp_risky.pdf, replace

capture drop res0*
cap drop res0se
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.ltotexp1 resid L(1/2).ltotexp1 L(1/2).resid period L(1/2).FEDFUNDS
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
replace res0=-25*res0
replace res0se=res0se*25
gen res0ub=res0+res0se
gen res0lb=res0-res0se
twoway ///
(rarea res0ub res0lb period if res0~=., color(gs14)) ///
(line res0 period if res0~=.), legend(off) xtitle(Quarters) ///
title("Less risky households") ///
yscale(range(-1.5 2.5)) ylabel(-1(1)2.5) ///
saving(resp_safe, replace)
/// graph export resp_safe.pdf, replace

gr combine resp_total.gph resp_risky.gph resp_safe.gph, rows(1) note(Response to 100 basis point rate cut. Shaded: one standard error CI. 1984Q1-2007Q4)
graph export resp_by_risk.pdf, replace



/*
capture drop res0
gen res0=.
forval t=0/20 {
	reg f`t'.ltotexp1 resid L(1/1).ltotexp1 L(1/1).resid
	replace res0=_b[resi] if _n==`t'
}
tsline res0 if res0~=.
*/


/*
capture drop res0
gen res0=.
forval t=0/20 {
	reg f`t'.ltotexp2 resid L(1/1).ltotexp2 L(1/1).resid
	replace res0=_b[resi] if _n==`t'
}
tsline res0 if res0~=.
*/

/***************** totexp_t ****************/
// state dependence
cap drop res0*
gen res0R=.
gen res0E=.
gen res0seR=.
gen res0seE=.
forval t=1/20 {
	reg f`t'.ltotexp2 F G c.F#c.resid c.G#c.resid c.F#c.L(1/1).ltotexp2 c.G#c.L(1/1).ltotexp2 ///
	c.F#c.L(1/1).resid c.G#c.L(1/1).resid c.F#c.L(1/1).infl c.G#c.L(1/1).infl, nocons
	replace res0R = _b[c.F#c.resid] if _n==`t'
	replace res0E = _b[c.G#c.resid] if _n==`t'
	replace res0seR = _se[c.F#c.resid] if _n==`t'
	replace res0seE = _se[c.F#c.resid] if _n==`t'
}
replace res0R=-25*res0R
replace res0seR=res0seR*25
gen res0ubR=res0R+res0seR
gen res0lbR=res0R-res0seR
twoway ///
(rarea res0ubR res0lbR period if res0R~=., color(gs14)) ///
(line res0R period if res0R~=.), legend(off) xtitle(Quarters) ///
yscale(range(-3 5)) ylabel(-2(2)5) ///
title("Recession") ///
ytitle("% in expenditure") ///
saving(resp_recession, replace)

capture drop res0*
cap drop res0se
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.ltotexp2 resid L(1/1).ltotexp2 L(1/1).resid L(1/1).infl
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
replace res0=-25*res0
replace res0se=res0se*25
gen res0ub=res0+res0se
gen res0lb=res0-res0se
twoway ///
(rarea res0ub res0lb period if res0~=., color(gs14)) ///
(line res0 period if res0~=.), legend(off) xtitle(Quarters) ///
title("Expansion=Recession") ///
yscale(range(-3 5)) ylabel(-2(2)5) ///
saving(resp_linear, replace)

cap drop res0*
gen res0R=.
gen res0E=.
gen res0seR=.
gen res0seE=.
forval t=1/20 {
	reg f`t'.ltotexp2 F G c.F#c.resid c.G#c.resid c.F#c.L(1/1).ltotexp2 c.G#c.L(1/1).ltotexp2 ///
	c.F#c.L(1/1).resid c.G#c.L(1/1).resid c.F#c.L(1/1).infl c.G#c.L(1/1).infl, nocons
	replace res0R = _b[c.F#c.resid] if _n==`t'
	replace res0E = _b[c.G#c.resid] if _n==`t'
	replace res0seR = _se[c.F#c.resid] if _n==`t'
	replace res0seE = _se[c.F#c.resid] if _n==`t'
}
replace res0E=-25*res0E
replace res0seE=res0seE*25
gen res0ubE=res0E+res0seE
gen res0lbE=res0E-res0seE
twoway ///
(rarea res0ubE res0lbE period if res0R~=., color(gs14)) ///
(line res0E period if res0E~=.), legend(off) xtitle(Quarters) ///
yscale(range(-3 5)) ylabel(-2(2)5) ///
title("Expansion") ///
ytitle("% in expenditure") ///
saving(resp_expansion, replace)
// graph export resp_total.pdf, replace


gr combine resp_linear.gph resp_expansion.gph resp_recession.gph, rows(1) note(Response to 100 basis point rate cut. Shaded: one standard error CI. 1984Q1-2007Q4)
graph export resp_by_state.pdf, replace
