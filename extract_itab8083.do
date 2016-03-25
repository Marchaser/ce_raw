// 
cd ${SRC}

// extract_mtbi for 1980-1983
forval year=1980/1983{
forval quarter=1/5{
	cap use inc\inc`year'q`quarter', clear
	if _rc==0 {
		destring REF_MO REF_YR, force replace
		replace REF_YR=REF_YR+1900 if REF_YR<1900
	
		#delimit ;
		gen REGULAR_INC_PLUS=inlist(UCC,900000,900010,900020,900040,900050,
			900060,900070,900080,900090,900100,900110,
			900120,900130,900140,900150,910000,910020,910030,910040);
			
		gen REGULAR_INC_MINUS=inlist(UCC,800720,800801,800802,800810,800820,800830,800840,800850,800860,
			800910,800920,800931,800932,800940);
		
		gen TAXES=inlist(UCC,950000,950001,950010,950011,950021,950022,950023);
			
		foreach v in REGULAR_INC_PLUS REGULAR_INC_MINUS TAXES{;
			replace `v' = `v'*COST;
		};

		collapse (sum) REGULAR_INC_PLUS REGULAR_INC_MINUS TAXES, by(NEWID REF_MO REF_YR);

		#delimit cr
		
		save incc\inc`year'q`quarter'c,replace
	}
}
}

clear
forval year=1980/1983{
forval quarter=1/5{
	cap append using incc\inc`year'q`quarter'c
}
}

save inc8083, replace
