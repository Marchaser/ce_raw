// monthly local projection
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

rename resid_full resid

foreach v in PCE {
	gen r`v'=PCE/CPIAUCSL
}

foreach v in INDPRO TOTC1 TOTC2 rPCE CPIAUCSL PPIACO{
	gen l`v'=log(`v')
}

gen tt=month-month[1]

forval lag=1/16{
	quiet reg lTOTC2 resid L(1/`lag').lTOTC2 L(1/`lag').resid L(1/`lag').FEDFUNDS L(1/`lag').lCPIAUCSL L(1/`lag').UNRATE
	quiet estat ic
	matrix icResult = r(S)
	local BIC=icResult[1,6]
	display `BIC'
}

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/48 {
	reg f`t'.lTOTC2 resid L(1/2).lTOTC2 L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).PPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lTOTC2_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/48 {
	reg f`t'.lTOTC1 resid L(1/2).lTOTC1 L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(0/2).PPIACO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lTOTC1_projection.csv if res0~=., replace comma

capture drop res0*
gen res0=.
gen res0se=.
forval t=0/48 {
	reg f`t'.lrPCE resid L(1/2).lrPCE L(1/2).resid L(1/2).FEDFUNDS L(1/2).lCPIAUCSL L(1/2).UNRATE L(1/2).PPIACO L(1/2).lINDPRO
	replace res0=_b[resi] if _n==`t'
	replace res0se=_se[resi] if _n==`t'
}
tsline res0 if res0~=.
outsheet res0 res0se using lrPCE_projection.csv if res0~=., replace comma
