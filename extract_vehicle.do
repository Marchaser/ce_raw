// extract vehicle interest rate
/*
use ${SRC}\1984\08671-0023-Data,clear
drop if QINTRSTZ==0 | QINTRSTZ==.
collapse (min)QINTRSTZ, by(QYEAR NEWID)
*/
cd D:\data\ce_raw
do vehicle8595.do

// 1984 file in stata
use ${SRC}\1984\08671-0023-Data, replace
keep QYEAR NEWID QINTRSTZ VEHICYB	VEHPURMO	VEHPURYR	DNPAYMTX	PRINCIPX	VEHQPMT	PAYMENTX	NETPURX
destring QYEAR NEWID VEHICYB VEHPURMO VEHPURYR, force replace
gen surveyYear=1984
save v1984q1,replace

cd ${SRC}
forval year=1985/1995{
	use ${SRC}\v`year'q1, clear
	gen surveyYear=`year'
	save v`year'q1,replace
}

// 96-13 file in stata
cd ${SRC}
local yearList 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13
local numYear : word count `yearList'
forval iYear=1/`numYear' {
	local i=1
	local year `: word `iYear' of `yearList''
	use D:\data\cex\bls9613\ovb`year', clear
	rename *, upper
	keep QYEAR NEWID QINTRSTZ VEHICYB	VEHPURMO	VEHPURYR	DNPAYMTX	PRINCIPX	VEHQPMT	PAYMENTX	NETPURX
	destring QYEAR NEWID VEHICYB VEHPURMO VEHPURYR, force replace
	gen surveyYear=.
	replace surveyYear=20`year' if `year'<90
	replace surveyYear=19`year' if `year'>=90
	if `year'<90 {
		save v20`year'q1, replace
	}
	else {
		save v19`year'q1, replace
	}
}

cd ${SRC}
clear
forval year=1984/2013{
	append using ${SRC}\v`year'q1
}
save vmerged, replace
drop if QINTRSTZ==.
save v_clear, replace

/*
// federal funds monthly rate
freduse FEDFUNDS, clear
gen month = mofd(daten)
save ffmonth, replace

cd ${SRC}
// load data
use v_clear, clear
replace ir = ir*12
drop if ir>0.5
drop if ir<1e-4
keep if inlist(VEHICYB,100,110)
// match with the federal funds rate at the purchase month
gen year = VEHPURYR if VEHPURYR>100
replace year = VEHPURYR+1900 if VEHPURYR<100
gen month=ym(year,VEHPURMO)
merge n:1 month using ffmonth
replace QYEAR=QYEAR+19000 if QYEAR<19000
gen spread = ir*100-FEDFUNDS
gen spreadXprinc=PRINCIPX*spread
collapse (sum)PRINCIPX spreadXprinc, by(QYEAR NEWID)
gen spread=spreadXprinc/PRINCIPX
gen UID=int(NEWID/10)
collapse (mean)spread, by(UID)
save spread_clear, replace

cd ${SRC}
// load data
use v_clear, clear
replace ir = ir*12
drop if ir>0.5
drop if ir<1e-4
keep if inlist(VEHICYB,100,110)
// match with the federal funds rate at the purchase month
gen year = VEHPURYR if VEHPURYR>100
replace year = VEHPURYR+1900 if VEHPURYR<100
gen month=ym(year,VEHPURMO)
gen irXprinc=PRINCIPX*ir
collapse (sum)PRINCIPX irXprinc,by(QYEAR NEWID)
gen ir=irXprinc/PRINCIPX
gen UID=int(NEWID/10)
collapse (mean)ir, by(UID)
save ir_clear, replace
*/

// compute residual
cd ${SRC}
set matsize 10000
// load data
use v_clear, clear
keep if inlist(VEHICYB,100,110)
merge n:1 NEWID surveyYear using fmli_clear
drop _merge

drop if VEHQPMT>84 // missing number of payments
gen log_price=log(NETPURX)
gen downratio = DNPAYMTX/NETPURX

gen linc = log(FINCATAX)
gen lprinc = log(PRINCIPX)
gen year = VEHPURYR if VEHPURYR>100
replace year = VEHPURYR+1900 if VEHPURYR<100
gen month=ym(year,VEHPURMO)
egen mg=group(month)
replace QYEAR = QYEAR+19000 if QYEAR<10000
destring CUTENURE,replace
gen ir = QINTRSTZ
drop if ir==.

gen UID=int(NEWID/10)
bysort UID VEHICYB VEHPURYR VEHPURMO: keep if _n==1

reg ir log_price i.VEHICYB i.mg i.QYEAR i.FAM_SIZE i.AGE_REF FINCATAX i.CUTENURE
predict ir_hat
gen ir_res = ir-ir_hat
drop if ir_res==.

gen irXprinc=PRINCIPX*ir_res
collapse (sum)PRINCIPX irXprinc,by(UID surveyYear)
gen ir = irXprinc/PRINCIPX
keep ir UID surveyYear
xtile vrtile=ir
save ir_clear, replace
