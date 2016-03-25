// clean  1980-1983
use inc8083, clear
sort NEWID
bysort NEWID REF_YR REF_MO: keep if _n==1
gen INC=REGULAR_INC_PLUS-REGULAR_INC_MINUS-TAXES
keep NEWID REF_YR REF_MO INC
save inc8083clear, replace
