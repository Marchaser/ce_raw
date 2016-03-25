// check vehicle data reasonable
use v_clear, clear
bysort NEWID VEHICYB VEHPURMO VEHPURYR: keep if _n==1

gen UID=int(NEWID/10)
collapse (count)QINTRSTZ,by(UID)

collapse (count)UID, by(vrtile REF_YR REF_MO)
sort REF_YR REF_MO vrtile
bysort REF_YR REF_MO: egen totalObs = total(UID)
gen tileperc = UID/totalObs

sort vrtile REF_YR REF_MO


// Why time series who have auto loans behave differently
use exp_clear2, clear
keep if ir~=.
collapse (mean)NONDURA SERVICE DURA OTHERC [pw=FINLWT21], by(month)
tsset month, m
gen totexp=NONDURA+SERVICE+DURA
gen totexpex=totexp+OTHERC

//
use exp_clear, clear
gen month=ym(REF_YR,REF_MO)
merge n:1 NEWID using fmli_clear,keepusing(AGE_REF CUTENURE FAM_SIZE FINCATAX FINLWT21 surveyYear)
keep if _merge==3
drop _merge
merge n:n NEWID using v_clear
keep if QINTRSTZ~=.
collapse (mean)NONDURA SERVICE DURA OTHERC [pw=FINLWT21], by(month)
tsset month, m
gen totexp=NONDURA+SERVICE+DURA
gen totexpex=totexp+OTHERC
tsline totexpex

//
use exp_clear, clear
gen month=ym(REF_YR,REF_MO)
merge n:1 NEWID using fmli_clear,keepusing(AGE_REF CUTENURE FAM_SIZE FINCATAX FINLWT21 surveyYear)
keep if _merge==3
drop _merge
merge n:n NEWID using v_clear
collapse (mean)NONDURA SERVICE DURA OTHERC [pw=FINLWT21], by(month)
tsset month, m
gen totexp=NONDURA+SERVICE+DURA
gen totexpex=totexp+OTHERC
tsline totexpex
