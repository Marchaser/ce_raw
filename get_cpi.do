// get cpi


/*
FOOD ALCBEV MRTINTP MRPINS RENDWE OTHLOD UTIL
		HOUSOP HOUSEQ APPAR CARTKN CARTKU OTHVEH GASMO VEHFIN MAINRP VEHINS
		VRNTLO PUBTRA HEALTH FEEADM TVRDIO OTHEQP
		
		
// FOOD
CPIUFDNS
// Energy
CPIENGNS
// Energy commodities
CUUR0000SACE
// Energy services
CUUR0000SEHF
// Apparel
CPIAPPNS
// New vehicles
CUUR0000SETA01
// Used cars and trucks
CUUR0000SETA02
// Medical care commodities
CUUR0000SAM1
// Alcoholic beverages
CUUR0000SAF116
// Tobacco and smoking products
CUUR0000SEGA
// Shelter
CUUR0000SAH1
// Medical care services
CUUR0000SAM2
// Transportation services
CUUR0000SAS4
// All Items Less Food and Energy
CPILFENS
*/

clear
freduse CPIUFDNS CPIENGNS CUUR0000SACE CUUR0000SEHF CPIAPPNS CUUR0000SETA01 CUUR0000SETA02 CUUR0000SAM1 CUUR0000SAF116 ///
	CUUR0000SEGA CUUR0000SAH1 CUUR0000SAM2 CUUR0000SAS4 CPILFENS
	
// split daten by year and month
gen REF_YR = year(daten)
gen REF_MO = month(daten)

// normalize using 1984M1 value
foreach var in CPIUFDNS CPIENGNS CUUR0000SACE CUUR0000SEHF CPIAPPNS CUUR0000SETA01 CUUR0000SETA02 CUUR0000SAM1 CUUR0000SAF116 ///
	CUUR0000SEGA CUUR0000SAH1 CUUR0000SAM2 CUUR0000SAS4 CPILFENS {
	sum `var' if REF_YR==1984 & REF_MO==1
	local value1981M1 = `r(mean)'
	replace `var' = `var'/`value1981M1'
}

// rename
rename CPIUFDNS cpi_food
rename CPIENGNS cpi_energy
rename CUUR0000SACE cpi_energy_comm
rename CUUR0000SEHF cpi_energy_service
rename CPIAPPNS cpi_apparel
rename CUUR0000SETA01 cpi_newcars
rename CUUR0000SETA02 cpi_usedcars
rename CUUR0000SAM1 cpi_health_comm
rename CUUR0000SAF116 cpi_alcbev
rename CUUR0000SEGA cpi_tabacco
rename CUUR0000SAH1 cpi_shelter
rename CUUR0000SAM2 cpi_health_service
rename CUUR0000SAS4 cpi_transport
rename CPILFENS cpi_others

save cpi_clear, replace
