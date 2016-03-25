// extract ce total expenditure data
global CODE D:\data\ce_raw
global SRC D:\data\cex

cd ${SRC}
// 1984 data in stata form
local i=1
foreach subfile in 0001 0005 0009 0013 0017{
	use ${SRC}\1984\08671-`subfile'-Data, clear
	destring QINTRVMO QINTRVYR INCOMEY1 INCOMEY2 CUTENURE, force replace
	
	gen surveyYear=1984
	
	keep NEWID FINLWT21 BLS_URBN AGE_REF CUTENURE FAM_SIZE FINCATAX QINTRVMO QINTRVYR INCOMEY1 INCOMEY2 TOTEXPPQ TOTEXPCQ surveyYear ///
	FOODPQ ALCBEVPQ HOUSPQ APPARPQ TRANSPQ HEALTHPQ ENTERTPQ PERSCAPQ READPQ EDUCAPQ TOBACCPQ MISCPQ ///
	FOODCQ ALCBEVCQ HOUSCQ APPARCQ TRANSCQ HEALTHCQ ENTERTCQ PERSCACQ READCQ EDUCACQ TOBACCCQ MISCCQ
	
	destring BLS_URBN, force replace
	
	/*
		FOOD ALCBEV APPAR GASMO TVRDIO OTHEQP READ TOBACC ///
		UTIL HOUSOP MAINRP VRNTLO PUBTRA FEEADM PERSCA ///
		HOUSEQ CARTKN CARTKU OTHVEH VEHFIN VEHINS ///
		MRTINTP RNTXRP RNTAPY HEALTH EDUCA MISC
		*/	
	save f1984q`i', replace
	local i = `i'+1
}


// 1985 data in ASCII form
do ${CODE}\generated_code85.do

// 1986-1995 data in ASCII form
do ${CODE}\generated_code8695.do
// something wrong with NEWID; only surveyYear+NEWID unique identifes a household; sigh!
cd ${SRC}
clear
// use f1984q1
forval year=1985/1995 {
	forval quarter=1/5 {
		cap use f`year'q`quarter', clear
		if _rc==0 {
			gen surveyYear=`year'
			save f`year'q`quarter', replace
		}
	}
}

// combine data
cd ${SRC}
clear
// use f1984q1
forval year=1984/1995 {
	forval quarter=1/5 {
		// capture merge 1:1 NEWID using f`year'q`quarter', update
		// cap drop _merge
		cap append using f`year'q`quarter'
	}
}
// keep a subset of variables
keep NEWID FINLWT21 AGE_REF BLS_URBN CUTENURE FAM_SIZE FINCATAX QINTRVMO QINTRVYR INCOMEY1 INCOMEY2 TOTEXPPQ TOTEXPCQ surveyYear ///
	FOODPQ ALCBEVPQ HOUSPQ APPARPQ TRANSPQ HEALTHPQ ENTERTPQ PERSCAPQ READPQ EDUCAPQ TOBACCPQ MISCPQ ///
	FOODCQ ALCBEVCQ HOUSCQ APPARCQ TRANSCQ HEALTHCQ ENTERTCQ PERSCACQ READCQ EDUCACQ TOBACCCQ MISCCQ
save fmli8495, replace

// 1996-2013 in stata form
local yearList 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13
local nextYearList 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14
local numYear : word count `yearList'
forval iYear=1/`numYear' {
	local i=1
	local year `: word `iYear' of `yearList''
	local nextYear `: word `iYear' of `nextYearList''
	foreach subfile in `year'1x `year'2 `year'3 `year'4 `nextYear'1{
		use ${SRC}\bls9613\fmli`subfile', clear
		/*
		capture confirm variable fnonfrmx
		if _rc {
			rename fnonfrmm fnonfrmx
		}
		capture confirm variable ffrmincx
		if _rc {
			rename ffrmincm ffrmincx
		}
		*/
		// keep newid finlwt21 qintrvmo qintrvyr incomey1 incomey2 totexppq totexpcq
		destring qintrvmo qintrvyr incomey1 incomey2, force replace
		rename *, upper
		destring CUTENURE BLS_URBN, force replace
		keep NEWID FINLWT21 AGE_REF BLS_URBN CUTEN_URE FAM_SIZE FINCAT* QINTRVMO QINTRVYR INCOMEY1 INCOMEY2 TOTEXPPQ TOTEXPCQ ///
		FOODPQ ALCBEVPQ HOUSPQ APPARPQ TRANSPQ HEALTHPQ ENTERTPQ PERSCAPQ READPQ EDUCAPQ TOBACCPQ MISCPQ ///
		FOODCQ ALCBEVCQ HOUSCQ APPARCQ TRANSCQ HEALTHCQ ENTERTCQ PERSCACQ READCQ EDUCACQ TOBACCCQ MISCCQ
		
		gen surveyYear = 20`year' if `year'<90
		replace surveyYear = 19`year' if `year'>=90
		capture rename FINCATXM FINCATAX
		
		if `year'<90 {
			save f20`year'q`i', replace
		}
		else {
			save f19`year'q`i', replace
		}
		local i=`i'+1
	}
}

use fmli8495, clear
forval year=1996/2013 {
	forval quarter=1/5 {
		append using f`year'q`quarter'
		// capture merge 1:1 NEWID using f`year'q`quarter', update
		// cap drop _merge
	}
}
// replace TOTEXPPQ=FOODPQ+ALCBEVPQ+HOUSPQ+APPARPQ+TRANSPQ+HEALTHPQ+ENTERTPQ+PERSCAPQ+READPQ+EDUCAPQ+TOBACCPQ+MISCPQ
// replace TOTEXPCQ=FOODCQ+ALCBEVCQ+HOUSCQ+APPARCQ+TRANSCQ+HEALTHCQ+ENTERTCQ+PERSCACQ+READCQ+EDUCACQ+TOBACCCQ+MISCCQ
save fmli, replace

cd ${SRC}
use fmli, clear
replace QINTRVYR = QINTRVYR+1900 if QINTRVYR<1000
bysort QINTRVYR QINTRVMO NEWID: keep if _n==1
save fmli_clear, replace

cd ${SRC}
// replicate each samples by three, generate reference month
use fmli, clear
bysort NEWID: keep if _n==1
save fmli_clear, replace

drop if TOTEXPPQ<0 | TOTEXPCQ<0 | (TOTEXPPQ+TOTEXPCQ<=0)
drop if FOODPQ<0 | FOODCQ<0 | (FOODPQ+FOODCQ<=0)

gen id=_n
gen year=cond(QINTRVYR<1000,QINTRVYR+1900,QINTRVYR)
gen month = ym(year,QINTRVMO)
gen refMonth1=month-1
gen refMonth2=month-2
gen refMonth3=month-3

gen refPQWeight1=1/3 if inlist(QINTRVMO,1,4,7,10)
gen refCQWeight1=0 if inlist(QINTRVMO,1,4,7,10)
gen refPQWeight2=1/3 if inlist(QINTRVMO,1,4,7,10)
gen refCQWeight2=0 if inlist(QINTRVMO,1,4,7,10)
gen refPQWeight3=1/3 if inlist(QINTRVMO,1,4,7,10)
gen refCQWeight3=0 if inlist(QINTRVMO,1,4,7,10)

replace refPQWeight1=0 if inlist(QINTRVMO,2,5,8,11)
replace refCQWeight1=1 if inlist(QINTRVMO,2,5,8,11)
replace refPQWeight2=1/2 if inlist(QINTRVMO,2,5,8,11)
replace refCQWeight2=0 if inlist(QINTRVMO,2,5,8,11)
replace refPQWeight3=1/2 if inlist(QINTRVMO,2,5,8,11)
replace refCQWeight3=0 if inlist(QINTRVMO,2,5,8,11)

replace refPQWeight1=0 if inlist(QINTRVMO,3,6,9,12)
replace refCQWeight1=1/2 if inlist(QINTRVMO,3,6,9,12)
replace refPQWeight2=0 if inlist(QINTRVMO,3,6,9,12)
replace refCQWeight2=1/2 if inlist(QINTRVMO,3,6,9,12)
replace refPQWeight3=1 if inlist(QINTRVMO,3,6,9,12)
replace refCQWeight3=0 if inlist(QINTRVMO,3,6,9,12)

reshape long refMonth refPQWeight refCQWeight, i(id) j(repli)
save fmli_cs, replace

/*
cd ${SRC}
use fmli, clear
// the idea is as follows: since the summary variable describes expenditure in the previous and current quarters
// based on calendars, but expenditure is surveyed for the most recent 3 months based on interview time.
// for example, for households surveyed in month 1, TOTEXPPQ will be referring expenditure in month 10 11 12 of the previous year
// for households surveyed in month 2, TOTEXPPQ will be referring expenditure in month 11 12 of previous year; and TOTEXPCQ will be referring month 1 of current year
// for households surveyed in month 3, TOTEXPPQ will be referring expenditure in month 12 of previous year; and TOTEXPCQ will be referring month 1 2 of current year
// Therefore, for households surveyed in month 2, TOTEXPPQ should be divided by 2/3 as an observation for the 4th quarter of previous year;
// but weight should be correspondingly multiplied by 2/3; TOTEXPCQ should be divided by 1/3 as an observation for the 1th quarter of current year;
// but weight should be correspondingly multiplied by 2/3.
// The followign implemets the above_described procedure
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
gen quarter = yq(year, quarter_num)

// map to last quarter
preserve
replace quarter = quarter-1
gen totexp = TOTEXPPQ/WeightPQ
save fmli_pq, replace
restore

gen totexp = TOTEXPCQ/WeightCQ if WeightCQ~=0
append using fmli_pq
save fmli_clear, replace
*/

/*
cd ${SRC}
use fmli_cs, clear
merge n:1 surveyYear NEWID using spread_clear
keep if _merge==3
gen totexp=TOTEXPPQ*refPQWeight + TOTEXPCQ*refCQWeight
/*
bro refMonth TOTEXPPQ TOTEXPCQ FOODPQ FOODCQ totexp refPQWeight refCQWeight QINTRVMO QINTRVYR if yofd(dofm(refMonth))>=1993 & yofd(dofm(refMonth))<=1995
collapse totexp, by(refMonth)
gen quarter=qofd(dofm(refMonth))
*/
// collapse to time series aggregates
collapse (mean) totexp [pw=FINLWT21], by(refMonth vrtile)
rename refMonth month
drop if vrtile==.
reshape wide totexp, i(month) j(vrtile)
tsset month, m
sax12 totexp1, satype(single) noview
sax12im totexp1, ext(d11)
sax12 totexp2, satype(single) noview
sax12im totexp2, ext(d11)
replace totexp1=totexp1_d11
replace totexp2=totexp2_d11
drop totexp1_d11 totexp2_d11
save totexp, replace
*/

