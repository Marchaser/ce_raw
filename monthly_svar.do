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

foreach v in indpro TOTC1 TOTC2 TOTC3{
	gen l`v'=log(`v')
}

forval lag=1/4{
	quiet var lTOTC2 resid_full FEDFUNDS lindpro, lags(1/`lag')
	quiet estat ic
	matrix icResult = r(S)
	local BIC=icResult[1,6]
	display `BIC'
}

replace FEDFUNDS = FEDFUNDS/100

gen tt=month-month[1]
gen tt2 = tt^2

var resid_full FEDFUNDS lTOTC1, lags(1/2)
irf create lTOTC1, set(lTOTC1) step(20) replace
irf table oirf, impulse(resid_full) irf(lTOTC1) response(lTOTC1 FEDFUNDS)
irf graph oirf, impulse(resid_full) irf(lTOTC1) response(lTOTC1 FEDFUNDS)

var resid_full FEDFUNDS lTOTC2, lags(1/2)
irf create lTOTC2, set(lTOTC2) step(20) replace
irf table oirf, impulse(resid_full) irf(lTOTC2) response(lTOTC2 FEDFUNDS)
irf graph oirf, impulse(resid_full) irf(lTOTC2) response(lTOTC2 FEDFUNDS)
