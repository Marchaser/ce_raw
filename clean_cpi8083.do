// clear cpi
clear
freduse CPIAUCSL
rename CPIAUCSL cpi
gen year = year(daten)
gen month = month(daten)
// normalize 1980 1 data to 100
gen temp1=cpi if year==1980 & month==1
egen cpibase = max(temp1)
replace cpi=cpi/cpibase
keep if year>=1979 & year<=1984
replace cpi=cpi*100
keep year month cpi
rename year REF_YR
rename month REF_MO
save cpi8083, replace
