// extract ce total expenditure data
cd D:\data\ce_raw
global SRC D:\home\franco\Documents\research\monetary_policy_inequality\data\cex_extracted\
// do generated_code.do




// 1984 data manually
cd ${SRC}\1984
local i=1
foreach subfile in 0001 0005 0009 0013 0017 {
	use 08671-`subfile'-data,clear
	keep NEWID FINLWT21 QINTRVMO QINTRVYR INCOMEY1 INCOMEY2 TOTEXPPQ TOTEXPCQ FNONFRMX FFRMINCX
	destring QINTRVMO QINTRVYR INCOMEY1 INCOMEY2, replace
	save ..\f1984q`i', replace
	local i=`i'+1
}

// 2011-2013 data manually
foreach year in 11 12 {
cd ${SRC}\20`year'
local i=1
local yearplus1 = `year'+1
foreach subfile in `year'1x `year'2 `year'3 `year'4 `yearplus1'1{
	use fmli`subfile', clear
	capture confirm variable fnonfrmx
	if _rc {
		rename fnonfrmm fnonfrmx
	}
	capture confirm variable ffrmincx
	if _rc {
		rename ffrmincm ffrmincx
	}
	keep newid finlwt21 qintrvmo qintrvyr incomey1 incomey2 totexppq totexpcq fnonfrmx ffrmincx
	destring qintrvmo, replace
	destring qintrvyr, replace
	destring incomey1, replace
	destring incomey2, replace
	rename *, upper
	save ..\f20`year'q`i', replace
	local i=`i'+1
}
}

// combine data
cd ${SRC}
clear

forval year=1984/2012 {
	forval quarter=1/5 {
		capture append using f`year'q`quarter'
	}
}
save master, replace

cd ${SRC}
use master, clear
// generaet refer year quarter
#d ;
gen quarter_num = cond(inrange(QINTRVMO, 1, 3), 1,
	cond(inrange(QINTRVMO, 4,6), 2,
	cond(inrange(QINTRVMO, 7,9), 3,
	cond(inrange(QINTRVMO, 10,12),4,.))));
#d ;
gen WeightPQ = cond(inlist(QINTRVMO, 1,4,7,10), 1,
	cond(inlist(QINTRVMO, 2,5,8,11), 2/3,
	cond(inlist(QINTRVMO, 3,6,9,12), 1/3, .)));
	
#d cr

gen WeightCQ = 1-WeightPQ
gen year=cond(QINTRVYR<1000,QINTRVYR+1900,QINTRVYR)

keep if inlist(QINTRVMO, 1, 4, 7, 10)
gen quarter = yq(year, quarter_num)
replace quarter = quarter-1

gen totexp = TOTEXPPQ

/*
// map to last quarter
preserve
replace quarter = quarter-1
replace FINLWT21 = FINLWT21*WeightPQ
gen totexp = TOTEXPPQ/WeightPQ
save master_pq, replace
restore

replace FINLWT21 = FINLWT21*WeightCQ
gen totexp = TOTEXPCQ/WeightCQ if WeightCQ~=0
append using master_pq
*/

gen is_entre = .
replace is_entre=1 if (INCOMEY1==5 | INCOMEY2==5) & ~(year==1984 & quarter_num==1)
replace is_entre=1 if (INCOMEY1==3 | INCOMEY2==3) & (year==1984 & quarter_num==1)
replace is_entre=0 if (INCOMEY1~=5 & INCOMEY2~=5) & ~(year==1984 & quarter_num==1)
replace is_entre=0 if (INCOMEY1~=3 & INCOMEY2~=3) & (year==1984 & quarter_num==1)
replace is_entre=. if INCOMEY1==. & INCOMEY2==.

/*
gen is_entre = cond(INCOMEY1==5, 1, cond(INCOMEY1~=5 & INCOMEY1~=.,0,.)) if ~(year==1984 & quarter_num==1)
replace is_entre = cond(INCOMEY1==3, 1, cond(INCOMEY1~=3 & INCOMEY1~=.,0,.)) if year==1984 & quarter_num==1
*/

/*
gen is_entre = cond(FNONFRMX~=0 | FFRMINCX~=0, 1, 0)
*/

drop if is_entre==.
collapse totexp [pw=FINLWT21], by (quarter is_entre)
xtset is_entre quarter, quarter
gen date = dofq(quarter)
gen year = year(date)
gen quarter_num = quarter(date)
drop if year<1984 | year>2013
tsline totexp if is_entre==0
tsline totexp if is_entre==1
keep year quarter_num totexp is_entre
reshape wide totexp, i(year quarter_num) j(is_entre)
rename quarter_num quarter
save exp_by_entre, replace
