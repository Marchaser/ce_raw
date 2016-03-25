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

foreach v in PCE SERVICE2 DURA2 NONDURA2 TOTEXP1 TOTEXP2 TOTEXP3 TOTEXP {
	gen r`v'=`v'/CPIAUCSL
}

foreach v in INDPRO rSERVICE2 rDURA2 rNONDURA2 rTOTEXP1 rTOTEXP2 rTOTEXP3 rTOTEXP rPCE TOTEXP1 TOTEXP2 TOTEXP3 TOTEXP PCE CPIAUCSL PPIACO{
	gen l`v'=log(`v')
}

gen tt=quarter-quarter[1]

/*
forval lag=1/16{
	quiet reg lTOTEXP2 resid L(1/`lag').lTOTEXP2 L(1/`lag').resid L(1/`lag').FEDFUNDS L(1/`lag').lCPIAUCSL L(1/`lag').UNRATE
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
	reg f`t'.lrSERVICE2 resid L(1/2).lrSERVICE2 L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lSERVICE2_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lrDURA2 resid L(1/2).lrDURA2 L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lDURA2_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lrNONDURA2 resid L(1/2).lrNONDURA2 L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lNONDURA2_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lrTOTEXP2 resid L(1/2).lrTOTEXP2 L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lTOTEXP2_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lrTOTEXP1 resid L(1/2).lrTOTEXP1 L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lTOTEXP1_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lTOTEXP resid L(1/2).lTOTEXP L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lTOTEXP_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/20 {
	reg f`t'.lrPCE resid L(1/2).lrPCE L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).lPPIACO if lTOTEXP1~=.
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lrPCE_projection.csv if res0~=., replace comma


/************ SVAR ************************/
var resid FEDFUNDS lrTOTEXP1 lCPIAUCSL UNRATE lPPIACO, lags(1/2)
irf create lrTOTEXP1, set(lrTOTEXP1) step(20) replace
irf table oirf, impulse(resid) irf(lrTOTEXP1) response(lrTOTEXP1 FEDFUNDS)
irf graph oirf, impulse(resid) irf(lrTOTEXP1) response(lrTOTEXP1)

var resid FEDFUNDS lrTOTEXP2 lCPIAUCSL UNRATE lPPIACO, lags(1/2)
irf create lrTOTEXP2, set(lrTOTEXP2) step(20) replace
irf table oirf, impulse(resid) irf(lrTOTEXP2) response(lrTOTEXP2 FEDFUNDS)
irf graph oirf, impulse(resid) irf(lrTOTEXP2) response(lrTOTEXP2)

var resid FEDFUNDS lrPCE lCPIAUCSL UNRATE lPPIACO, lags(1/2)
irf create lrPCE, set(lrPCE) step(20) replace
irf table oirf, impulse(resid) irf(lrPCE) response(lrPCE FEDFUNDS)
irf graph oirf, impulse(resid) irf(lrPCE) response(lrPCE)

var resid FEDFUNDS lrTOTEXP lCPIAUCSL UNRATE lPPIACO, lags(1/2)
irf create lrTOTEXP, set(lrTOTEXP) step(20) replace
irf table oirf, impulse(resid) irf(lrTOTEXP) response(lrTOTEXP FEDFUNDS)
irf graph oirf, impulse(resid) irf(lrTOTEXP) response(lrTOTEXP)

var FEDFUNDS lrTOTEXP lCPIAUCSL UNRATE lPPIACO resid, lags(1/2)
irf create lrTOTEXP, set(lrTOTEXP) step(20) replace
irf table oirf, impulse(resid) irf(lrTOTEXP) response(lrTOTEXP FEDFUNDS)
irf graph oirf, impulse(resid) irf(lrTOTEXP) response(lrTOTEXP)


