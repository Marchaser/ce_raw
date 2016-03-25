cd ${SRC}
// 1996 to 2013
local yearList 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13
local nextYearList 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14
local numYear : word count `yearList'
forval iYear=1/`numYear' {
	local i=1
	local year `: word `iYear' of `yearList''
	local nextYear `: word `iYear' of `nextYearList''
	foreach subfile in `year'1x `year'2 `year'3 `year'4 `nextYear'1{
		use ${SRC}\bls9613\mtbi`subfile', clear
		rename *,upper
		destring UCC, replace
		
		#delimit ;
		gen FOOD=inlist(UCC,790410, 790430, 800700) | inrange(UCC,190901,190904) | inrange(UCC,790220,790230);

		gen ALCBEV=inlist(UCC,200900, 790420) | inrange(UCC,790310,790320);

		gen MRTINTP=inlist(UCC,220311, 220313, 220321, 880110);

		gen MRPINS=inlist(UCC,210901, 220111, 220121, 220901, 230112-230115, 230122, 230142, 230151 230901,
		240112, 240122, 240212-240213, 240222, 240312, 240322, 320612, 320622, 320632,
		340911, 990930) | inrange(UCC,230112,230115) | inrange(UCC,240212,240213);

		gen RENDWE=inlist(UCC,210110, 230121, 230141, 230150, 240111, 240121, 240211, 240221, 240311, 240321,
		320611, 320621, 320631, 350110, 790690, 800710, 990910-990920) | inrange(UCC,990910,990920);

		gen OTHLOD=inlist(UCC,210210, 210310, 210902, 220112, 220122, 220212, 220312, 220314, 220322, 220902,
		230123, 230152, 230902, 240113, 240123, 240214, 240223, 240313, 240323, 320613,
		320623, 320633, 340912, 880310, 990940);

		gen UTIL=inlist(UCC,250111-270214, 270411-270904) | inrange(UCC,250111,270214) | inrange(UCC,270411,270904);

		gen HOUSOP=inlist(UCC,330511, 340211-340530, 340620-340901, 340903, 340906-340908, 340914, 670310,
		690113-690114) | inrange(UCC,340211,340530) | inrange(UCC,340620,340901) | inrange(UCC,340906,340908)
		| inrange(UCC,690113,690114);

		gen HOUSEQ=inlist(UCC,230117-230118, 230131-230132, 280110-300412, 320110-320522, 320901-320904,
		340904, 430130, 690111-690112, 690210-690245);

		gen APPAR=inlist(UCC,360110-430120, 440110-440900) | inrange(UCC,360110,430120) | inrange(UCC,440110,440900);

		gen CARTKN=inlist(UCC,450110, 450210);

		gen CARTKU=inlist(UCC,460110, 460901);

		gen OTHVEH=inlist(UCC,450220, 460902);

		gen GASMO=inlist(UCC,470111-470212) | inrange(UCC,470111,470212);

		gen VEHFIN=inlist(UCC,510110-510902, 850300) | inrange(UCC,510110,510902);

		gen MAINRP=inlist(UCC,470220-490900) | inrange(UCC,470220,490900);

		gen VEHINS=inlist(UCC,500110);

		gen VRNTLO=inlist(UCC,450310, 450313-450314, 450410, 450413-450414, 520110-520550, 520902-520903,
		520905-520906, 620113) | inrange(UCC,450313,450314)
		| inrange(UCC,450413,450414) | inrange(UCC,520110,520550)
		| inrange(UCC,520902,520903) | inrange(UCC,520905,520906);

		gen PUBTRA=inlist(UCC,530110-530902) | inrange(UCC,530110,530902);

		gen HEALTH=inlist(UCC,540000-580902) | inrange(UCC,540000,580902);

		gen FEEADM=inlist(UCC,610900-620111, 620121-620310, 620903)
		| inrange(UCC,610900,620111) | inrange(UCC,620121,620310);

		gen TVRDIO=inlist(UCC,270310, 310110-310342, 340610, 340902, 340905, 610130, 620904, 620912)
		| inrange(UCC,310110,310342);

		gen OTHEQP=inlist(UCC,520901, 520904, 520907, 600110-600122, 600132, 600141, 600142, 600210-610120,
		610210-610320, 620330-620420, 620905-620909, 620919-620922)
		| inrange(UCC,600210,610120) | inrange(UCC,610210,610320)
		| inrange(UCC,620905,620909) | inrange(UCC,620919,620922);

		gen PERSCA=inlist(UCC,640130-650900)
		| inrange(UCC,640130,650900);

		gen READ=inlist(UCC,590111-590230, 660310)
		| inrange(UCC,590111,590230);

		gen EDUCA=inlist(UCC,660110-660210, 660900-670210, 670901-670902)
		| inrange(UCC,660110,660210) | inrange(UCC,660900,670210)
		| inrange(UCC,670901,670902);

		gen TOBACC=inlist(UCC,630110-630210)
		| inrange(UCC,630110,630210);

		gen MISC=inlist(UCC,620112, 680110-680902, 710110, 790600, 880210, 900001)
		| inrange(UCC,680110,680902);

		gen INSUR=inlist(UCC, 002120, 700110);

		gen PENSION=inlist(UCC,800910-800940)
		| inrange(UCC,800910,800940);

		foreach v in FOOD ALCBEV MRTINTP MRPINS RENDWE OTHLOD UTIL
		HOUSOP HOUSEQ APPAR CARTKN CARTKU OTHVEH GASMO VEHFIN MAINRP VEHINS
		VRNTLO PUBTRA HEALTH FEEADM TVRDIO OTHEQP
		PERSCA READ EDUCA TOBACC MISC INSUR PENSION{;
			replace `v' = `v'*COST;
		};

		collapse (sum) FOOD ALCBEV MRTINTP MRPINS RENDWE OTHLOD UTIL
		HOUSOP HOUSEQ APPAR CARTKN CARTKU OTHVEH GASMO VEHFIN MAINRP VEHINS
		VRNTLO PUBTRA HEALTH FEEADM TVRDIO OTHEQP
		PERSCA READ EDUCA TOBACC MISC INSUR PENSION, by(NEWID REF_MO REF_YR);

		#delimit cr
		drop if FOOD<=0
		gen NONDURA=FOOD+ALCBEV+APPAR+GASMO+READ+TOBACC
		gen SERVICE=MRPINS+UTIL+HOUSOP+MAINRP+VRNTLO+PUBTRA+FEEADM+OTHEQP+PERSCA
		gen DURA=HOUSEQ+CARTKN+CARTKU+OTHVEH+VEHFIN+VEHINS+TVRDIO
		gen OTHERC=MRTINTP+RENDWE+OTHLOD+HEALTH+EDUCA+MISC
		
		if `year'<90 {
			save e20`year'q`i'c, replace
		}
		else {
			save e19`year'q`i'c, replace
		}
		local i=`i'+1
	}
}


clear
forval year=1984/2013{
forval quarter=1/5{
	cap append using e`year'q`quarter'c
}
}
// split newid
gen UID = int(NEWID/10)
sort UID REF_YR REF_MO
order UID
destring REF_MO REF_YR, replace
replace REF_YR=REF_YR+1900 if REF_YR<1900
save exp_clear, replace
