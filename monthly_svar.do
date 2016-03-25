// monthly svar
cd ${SRC}
use totexp_mc, clear

merge n:1 month using rrWieland
drop _merge
drop date

merge n:1 month using ffmonth
drop _merge

merge n:1 month using macro_monthly
drop _merge

tsset month
drop if year(dofm(month))>2007

foreach v in INDPRO TOTEXP1 TOTEXP2 TOTEXP3{
	gen l`v'=log(`v')
}

forval lag=1/4{
	quiet var lTOTEXP2 resid_full FEDFUNDS lINDPRO, lags(1/`lag')
	quiet estat ic
	matrix icResult = r(S)
	local BIC=icResult[1,6]
	display `BIC'
}

replace FEDFUNDS = FEDFUNDS/100

gen tt=month-month[1]
gen tt2 = tt^2

var resid_full FEDFUNDS lTOTEXP1, lags(1/2)
irf create lTOTEXP1, set(lTOTEXP1) step(20) replace
irf table oirf, impulse(resid_full) irf(lTOTEXP1) response(lTOTEXP1 FEDFUNDS)
irf graph oirf, impulse(resid_full) irf(lTOTEXP1) response(lTOTEXP1 FEDFUNDS)

var resid_full FEDFUNDS lTOTEXP2, lags(1/2)
irf create lTOTEXP2, set(lTOTEXP2) step(20) replace
irf table oirf, impulse(resid_full) irf(lTOTEXP2) response(lTOTEXP2 FEDFUNDS)
irf graph oirf, impulse(resid_full) irf(lTOTEXP2) response(lTOTEXP2 FEDFUNDS)
