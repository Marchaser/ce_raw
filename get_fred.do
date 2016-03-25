// get fred
clear
freduse A939RX0Q048SBEA CPIAUCSL GDPC1
rename A939RX0Q048SBEA rgdppc
rename CPIAUCSL cpi_u
rename GDPC1 rgdp
gen quarter = qofd(daten)
collapse rgdppc cpi_u rgdp, by(quarter)
save fredData, replace

clear 
freduse PCE INDPRO CPIAUCSL UNRATE PPIACO
/*
rename INDPRO indpro
rename CPIAUCSL cpi_u
rename UNRATE unemp
rename PPIACO
*/
gen month = mofd(daten)
keep month PCE INDPRO CPIAUCSL UNRATE PPIACO
save macro_monthly, replace

clear 
freduse PCE INDPRO CPIAUCSL UNRATE PPIACO
/*
rename INDPRO indpro
rename CPIAUCSL cpi_u
rename UNRATE unemp
rename PPIACO
*/
gen quarter = qofd(daten)
collapse (mean) PCE INDPRO CPIAUCSL UNRATE PPIACO, by(quarter)
keep quarter PCE INDPRO CPIAUCSL UNRATE PPIACO
save macro_quarterly, replace
