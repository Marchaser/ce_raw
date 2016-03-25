// divide family by auto loan interest rates
cd ${SRC}
set matsize 10000
// load data
use v_clear, clear
keep if inlist(VEHICYB,100,110)
merge n:1 NEWID surveyYear using fmli_clear
drop _merge

gen loanyear = VEHPURYR if VEHPURYR>100
replace loanyear = VEHPURYR+1900 if VEHPURYR<100
gen loanmonth=ym(loanyear,VEHPURMO)
egen mg=group(loanmonth)

gen UID=int(NEWID/10)
// Identify vehicle by type, purchase year and month
bysort UID surveyYear VEHICYB VEHPURYR VEHPURMO: keep if _n==1

// interest rate on vehicle type, loan month, interview quarter, age of reference person
gen ir = QINTRSTZ
reg ir i.VEHICYB i.mg i.QYEAR i.AGE_REF i.CUTENURE FINCATAX
// i.VEHICYB i.mg i.QYEAR i.AGE_REF i.CUTENURE FINCATAX
predict ir_hat
gen ir_res = ir-ir_hat

/*
drop if ir_res==.
gen irXprinc=PRINCIPX*ir_res
collapse (sum)PRINCIPX irXprinc,by(NEWID)
gen ir = irXprinc/PRINCIPX
xtile vrtile=ir
save ir_clear, replace
*/

// average interest premium by households
gen irXprinc=PRINCIPX*ir_res
collapse (sum)PRINCIPX irXprinc,by(surveyYear UID)
gen ir = irXprinc/PRINCIPX
keep ir surveyYear UID
xtile vrtile=ir
// egen vrtile=xtile(ir), by(REF_YR REF_MO)
save ir_clear, replace
