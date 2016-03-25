// clean  1980-1983
use exp8083, clear
sort NEWID
bysort NEWID REF_YR REF_MO: keep if _n==1
drop if FOOD==0
gen TOTC = FOOD+NONDURA+SERVICE+DURA+OTHERC
keep NEWID REF_YR REF_MO FOOD NONDURA SERVICE DURA TOTC
save exp8083clear, replace
