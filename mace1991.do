// replicate mace(1991)

// merge expenditure and income data
use exp8083clear, clear
merge 1:1 NEWID REF_MO REF_YR using inc8083clear
drop _merge
sort NEWID REF_YR REF_MO

// split household and interview numbeer
gen hhid = floor(NEWID/10)
gen interviewid = NEWID-10*hhid

// keep observations that have the 2nd and 5th interviews
bysort hhid: egen has2ndInterview = total(interviewid==2)
bysort hhid: egen has5thInterview = total(interviewid==5)
keep if has2ndInterview~=0 & has5thInterview~=0

// keep the last month of the 2nd and 5th interview
keep if interviewid==2 | interviewid==5
sort hhid interviewid REF_YR REF_MO
bysort hhid interviewid: keep if _n==_N
reshape wide NEWID REF_MO REF_YR FOOD NONDURA SERVICE DURA TOTC INC, i(hhid) j(interviewid)

// compute delta consumption and income
/*
foreach var in TOTC FOOD NONDURA SERVICE DURA {
	gen DeltaLog`var' = log(`var'5/cpi5*100) - log(`var'2/cpi2*100)
	gen Delta`var' = `var'5/cpi5*100 - `var'2/cpi2*100
}
*/
foreach var in TOTC FOOD NONDURA SERVICE DURA INC {
	gen DeltaLog`var' = log(`var'5) - log(`var'2)
	gen Delta`var' = `var'5 - `var'2
}
save exp_delta, replace

use exp_delta, clear
// compute aggregate delta consumption
collapse Delta*, by(REF_MO2 REF_YR2)
rename Delta* AggDelta*
save agg_delta, replace

use exp_delta, replace
merge n:1 REF_MO2 REF_YR2 using agg_delta

// reg deltaCj deltaCa deltaYj
reg DeltaTOTC AggDeltaTOTC DeltaINC
test (AggDeltaTOTC=1) (DeltaINC=0)

reg DeltaLogTOTC AggDeltaLogTOTC DeltaLogINC
test (AggDeltaLogTOTC=1) (DeltaLogINC=0)

reg DeltaFOOD AggDeltaFOOD DeltaINC
test (AggDeltaFOOD=1) (DeltaINC=0)

reg DeltaLogFOOD AggDeltaLogFOOD DeltaLogINC
test  (AggDeltaLogFOOD=1) (DeltaLogINC=0)
