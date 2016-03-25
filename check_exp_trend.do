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
save fmli_cqpq_clear, replace

use fmli_cqpq_clear, clear
collapse totexp, by(quarter)
