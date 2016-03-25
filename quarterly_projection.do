// monthly local projection
cd ${SRC}
use totexp_qc, clear

merge 1:1 quarter using totexp_allc
drop _merge

merge n:1 quarter using rrWieland_q
drop _merge

merge n:1 quarter using ffmonth_q
drop _merge

merge n:1 quarter using macro_quarterly
drop _merge

tsset quarter,q
drop if year(dofq(quarter))>2007

rename resid_full resid

foreach v in PCE TOTC1 TOTC2 TOTC3 TOTC {
	gen r`v'=`v'/CPIAUCSL
}

foreach v in INDPRO rTOTC1 rTOTC2 rTOTC3 rTOTC rPCE TOTC1 TOTC2 TOTC3 TOTC PCE CPIAUCSL PPIACO{
	gen l`v'=log(`v')
}

gen tt=quarter-quarter[1]

/*
forval lag=1/16{
	quiet reg lTOTC2 resid L(1/`lag').lTOTC2 L(1/`lag').resid L(1/`lag').FEDFUNDS L(1/`lag').lCPIAUCSL L(1/`lag').UNRATE
	quiet estat ic
	matrix icResult = r(S)
	local BIC=icResult[1,6]
	display `BIC'
}
*/

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lrTOTC2 resid L(1/2).lrTOTC2 L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lTOTC2_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lrTOTC1 resid L(1/2).lrTOTC1 L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lTOTC1_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lTOTC resid L(1/2).lTOTC L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lTOTC_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lrPCE resid L(1/2).lrPCE L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO if lTOTC1~=.
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lrPCE_projection.csv if res0~=., replace comma


/************ SVAR ************************/
var resid FEDFUNDS lrTOTC1 lCPIAUCSL UNRATE lPPIACO, lags(1/2)
irf create lrTOTC1, set(lrTOTC1) step(20) replace
irf table oirf, impulse(resid) irf(lrTOTC1) response(lrTOTC1 FEDFUNDS)
irf graph oirf, impulse(resid) irf(lrTOTC1) response(lrTOTC1)

var resid FEDFUNDS lrTOTC2 lCPIAUCSL UNRATE lPPIACO, lags(1/2)
irf create lrTOTC2, set(lrTOTC2) step(20) replace
irf table oirf, impulse(resid) irf(lrTOTC2) response(lrTOTC2 FEDFUNDS)
irf graph oirf, impulse(resid) irf(lrTOTC2) response(lrTOTC2)

var FEDFUNDS lrPCE lCPIAUCSL UNRATE lPPIACO resid, lags(1/2)
irf create lrPCE, set(lrPCE) step(20) replace
irf table oirf, impulse(resid) irf(lrPCE) response(lrPCE FEDFUNDS)
irf graph oirf, impulse(resid) irf(lrPCE) response(lrPCE)

var FEDFUNDS lrTOTC lCPIAUCSL UNRATE lPPIACO resid, lags(1/2)
irf create lrTOTC, set(lrTOTC) step(20) replace
irf table oirf, impulse(resid) irf(lrTOTC) response(lrTOTC FEDFUNDS)
irf graph oirf, impulse(resid) irf(lrTOTC) response(lrTOTC)

var resid FEDFUNDS lTOTC lCPIAUCSL UNRATE lPPIACO, lags(1/2)
irf create lTOTC, set(lTOTC) step(20) replace
irf table oirf, impulse(resid) irf(lTOTC) response(lTOTC FEDFUNDS)
irf graph oirf, impulse(resid) irf(lTOTC) response(lTOTC)
