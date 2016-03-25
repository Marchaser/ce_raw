/*** Automatic generated by extract_ucc_proc.xlsm ***/
/*** Author: Wenlan Luo, luowenlan@gmail.com ***/
/*** Year 2002 ***/
#d ;
gen RETPEN = 1 if 0  | inlist(UCC,800910,800920,800931,800932,800940);
replace RETPEN = 0 if RETPEN==.;
gen LIFINS = 1 if 0  | inlist(UCC,002120,700110);
replace LIFINS = 0 if LIFINS==.;
gen PERINS = 1 if 0  | LIFINS | RETPEN;
replace PERINS = 0 if PERINS==.;
gen CASHCO = 1 if 0  | inlist(UCC,800801,800810,800820,800830,800840,800850,800860,800111,800121,800804,800811,800821,800831,800841,800851,800861);
replace CASHCO = 0 if CASHCO==.;
gen MISC2 = 1 if 0  | inlist(UCC,710110,900001);
replace MISC2 = 0 if MISC2==.;
gen MISC1 = 1 if 0  | inlist(UCC,620112,620115,620926,680110,680140,680210,680220,680901,680902,790600,880210,900002);
replace MISC1 = 0 if MISC1==.;
gen MISC = 1 if 0  | MISC1 | MISC2;
replace MISC = 0 if MISC==.;
gen TOBACC = 1 if 0  | inlist(UCC,630110,630210);
replace TOBACC = 0 if TOBACC==.;
gen EDUCA = 1 if 0  | inlist(UCC,660110,660210,660900,670110,670210,670901,670902);
replace EDUCA = 0 if EDUCA==.;
gen READ = 1 if 0  | inlist(UCC,590111,590112,590211,590212,590220,590230,660310,590110,590210);
replace READ = 0 if READ==.;
gen PERSCA = 1 if 0  | inlist(UCC,640130,640420,650310,650900,650110,650210);
replace PERSCA = 0 if PERSCA==.;
gen OTHENT = 1 if 0  | inlist(UCC,520901,520904,520907,600110,600121,600122,600132,600141,600142,600210,600310,600410,600420,600430,600901,600902,610210,610230,620330,620905,620906,620908,620909,620919,620921,620922,620320);
replace OTHENT = 0 if OTHENT==.;
gen PETTOY = 1 if 0  | inlist(UCC,610110,610120,610320,620410,620420);
replace PETTOY = 0 if PETTOY==.;
gen OTHEQP = 1 if 0  | PETTOY | OTHENT;
replace OTHEQP = 0 if OTHEQP==.;
gen TVRDIO = 1 if 0  | inlist(UCC,270310,310110,310120,310130,310210,310220,310230,310311,310313,310320,310333,310334,310341,310342,340610,340902,340905,610130,620904,620912,310312);
replace TVRDIO = 0 if TVRDIO==.;
gen FEEADM = 1 if 0  | inlist(UCC,610900,620111,620121,620122,620211,620212,620221,620222,620310,620903);
replace FEEADM = 0 if FEEADM==.;
gen ENTERT = 1 if 0  | FEEADM | TVRDIO | OTHEQP;
replace ENTERT = 0 if ENTERT==.;
gen MEDSUP = 1 if 0  | inlist(UCC,550110,550320,550330,550340,570901,570903);
replace MEDSUP = 0 if MEDSUP==.;
gen PREDRG = 1 if 0  | inlist(UCC,540000);
replace PREDRG = 0 if PREDRG==.;
gen MEDSRV = 1 if 0  | inlist(UCC,560110,560210,560310,560330,560400,570110,570210,570220,570230,570240);
replace MEDSRV = 0 if MEDSRV==.;
gen HLTHIN = 1 if 0  | inlist(UCC,580110,580111,580112,580113,580114,580210,580310,580311,580312,580901,580902,580903,580904,580905,580906);
replace HLTHIN = 0 if HLTHIN==.;
gen HEALTH = 1 if 0  | HLTHIN | MEDSRV | PREDRG | MEDSUP;
replace HEALTH = 0 if HEALTH==.;
gen TRNOTH = 1 if 0  | inlist(UCC,530311,530412,530902);
replace TRNOTH = 0 if TRNOTH==.;
gen TRNTRP = 1 if 0  | inlist(UCC,530110,530210,530312,530411,530510,530901);
replace TRNTRP = 0 if TRNTRP==.;
gen PUBTRA = 1 if 0  | TRNTRP | TRNOTH;
replace PUBTRA = 0 if PUBTRA==.;
gen VRNTLO = 1 if 0  | inlist(UCC,450310,450313,450314,450410,450413,450414,520110,520111,520112,520310,520410,520511,520512,520521,520522,520531,520532,520542,520550,520902,520903,520905,520906,620113);
replace VRNTLO = 0 if VRNTLO==.;
gen VEHINS = 1 if 0  | inlist(UCC,500110);
replace VEHINS = 0 if VEHINS==.;
gen MAINRP = 1 if 0  | inlist(UCC,470220,480110,480213,480214,490110,490211,490212,490220,490221,490231,490232,490311,490312,490313,490314,490315,490318,490319,490411,490412,490413,490501,490502,490900);
replace MAINRP = 0 if MAINRP==.;
gen VEHFIN = 1 if 0  | inlist(UCC,510110,510901,510902,850300);
replace VEHFIN = 0 if VEHFIN==.;
gen GASMO = 1 if 0  | inlist(UCC,470111,470112,470113,470211,470212);
replace GASMO = 0 if GASMO==.;
gen OTHVEH = 1 if 0  | VEHFIN | MAINRP | VEHINS | VRNTLO;
replace OTHVEH = 0 if OTHVEH==.;
gen CARTKU = 1 if 0  | inlist(UCC,460110,460901);
replace CARTKU = 0 if CARTKU==.;
gen CARTKN = 1 if 0  | inlist(UCC,450110,450210);
replace CARTKN = 0 if CARTKN==.;
gen VEHICL = 1 if 0  | inlist(UCC,450110,450210,460110,460901,450220,460902);
replace VEHICL = 0 if VEHICL==.;
gen TRANS = 1 if 0  | CARTKN | CARTKU | OTHVEH | GASMO | VEHFIN | 
MAINRP | VEHINS | VRNTLO | PUBTRA;
replace TRANS = 0 if TRANS==.;
gen OTHAPL = 1 if 0  | inlist(UCC,420110,420120,430110,430120,440110,440120,440130,440140,440150,440210,440900);
replace OTHAPL = 0 if OTHAPL==.;
gen FOOTWR = 1 if 0  | inlist(UCC,400110,400210,400220,400310);
replace FOOTWR = 0 if FOOTWR==.;
gen CHLDRN = 1 if 0  | inlist(UCC,410110,410120,410130,410140,410901);
replace CHLDRN = 0 if CHLDRN==.;
gen GRLFIF = 1 if 0  | inlist(UCC,390110,390120,390210,390221,390222,390230,390310,390321,390322,390901,390902);
replace GRLFIF = 0 if GRLFIF==.;
gen WOMSIX = 1 if 0  | inlist(UCC,380110,380210,380311,380312,380313,380320,380331,380332,380340,380410,380420,380430,380510,380901,380902,380903);
replace WOMSIX = 0 if WOMSIX==.;
gen WOMGRL = 1 if 0  | WOMSIX | GRLFIF;
replace WOMGRL = 0 if WOMGRL==.;
gen BOYFIF = 1 if 0  | inlist(UCC,370110,370120,370130,370211,370212,370213,370220,370311,370312,370313,370901,370902,370903,370904);
replace BOYFIF = 0 if BOYFIF==.;
gen MENSIX = 1 if 0  | inlist(UCC,360110,360120,360210,360311,360312,360320,360330,360340,360350,360410,360511,360512,360901,360902);
replace MENSIX = 0 if MENSIX==.;
gen MENBOY = 1 if 0  | MENSIX | BOYFIF;
replace MENBOY = 0 if MENBOY==.;
gen APPAR = 1 if 0  | MENBOY | WOMGRL | CHLDRN | FOOTWR | OTHAPL;
replace APPAR = 0 if APPAR==.;
gen MISCEQ = 1 if 0  | inlist(UCC,320120,320130,320150,320210,320220,320231,320232,320410,320420,320901,320902,320903,320904,340904,430130,690111,690112,690210,690220,690230,690241,690242,690243,690244,690245);
replace MISCEQ = 0 if MISCEQ==.;
gen SMLAPP = 1 if 0  | inlist(UCC,320310,320320,320330,320340,320350,320360,320370,320521,320522);
replace SMLAPP = 0 if SMLAPP==.;
gen MAJAPP = 1 if 0  | inlist(UCC,230117,230118,300111,300112,300211,300212,300221,300222,300311,300312,300321,300322,300331,300332,300411,300412,320511,320512);
replace MAJAPP = 0 if MAJAPP==.;
gen FLRCVR = 1 if 0  | inlist(UCC,230133,230134,320111,320163,230131,230132,320110,320161,320162);
replace FLRCVR = 0 if FLRCVR==.;
gen FURNTR = 1 if 0  | inlist(UCC,290110,290120,290210,290310,290320,290410,290420,290430,290440);
replace FURNTR = 0 if FURNTR==.;
gen TEXTIL = 1 if 0  | inlist(UCC,280110,280120,280130,280210,280220,280230,280900);
replace TEXTIL = 0 if TEXTIL==.;
gen HOUSEQ = 1 if 0  | TEXTIL | FURNTR | FLRCVR | MAJAPP | SMLAPP | MISCEQ;
replace HOUSEQ = 0 if HOUSEQ==.;
gen OTHHEX = 1 if 0  | inlist(UCC,330511,340510,340620,340630,340901,340907,340908,690113,690114,990900,340915);
replace OTHHEX = 0 if OTHHEX==.;
gen BBYDAY = 1 if 0  | inlist(UCC,340211,340212,670310);
replace BBYDAY = 0 if BBYDAY==.;
gen DMSXCC = 1 if 0  | inlist(UCC,340310,340410,340420,340520,340530,340903,340906,340910,340914,340915);
replace DMSXCC = 0 if DMSXCC==.;
gen DOMSRV = 1 if 0  | DMSXCC | BBYDAY;
replace DOMSRV = 0 if DOMSRV==.;
gen HOUSOP = 1 if 0  | DOMSRV | OTHHEX;
replace HOUSOP = 0 if HOUSOP==.;
gen WATRPS = 1 if 0  | inlist(UCC,270211,270212,270213,270214,270411,270412,270413,270414,270901,270902,270903,270904);
replace WATRPS = 0 if WATRPS==.;
gen TELEPH = 1 if 0  | inlist(UCC,270101,270102,270103,270104);
replace TELEPH = 0 if TELEPH==.;
gen OTHFLS = 1 if 0  | inlist(UCC,250211,250212,250213,250214,250221,250222,250223,250224,250901,250902,250903,250904);
replace OTHFLS = 0 if OTHFLS==.;
gen FULOIL = 1 if 0  | inlist(UCC,250111,250112,250113,250114);
replace FULOIL = 0 if FULOIL==.;
gen ALLFUL = 1 if 0  | FULOIL | OTHFLS;
replace ALLFUL = 0 if ALLFUL==.;
gen ELCTRC = 1 if 0  | inlist(UCC,260111,260112,260113,260114);
replace ELCTRC = 0 if ELCTRC==.;
gen NTLGAS = 1 if 0  | inlist(UCC,260211,260212,260213,260214);
replace NTLGAS = 0 if NTLGAS==.;
gen UTIL = 1 if 0  | NTLGAS | ELCTRC | ALLFUL | TELEPH | WATRPS;
replace UTIL = 0 if UTIL==.;
gen OTHLOD = 1 if 0  | inlist(UCC,210210,210310,210902,220122,220212,220312,220314,220322,220902,230123,230152,230902,240113,240123,240214,240223,240313,240323,320613,320623,320633,340912,880310,990940,220112);
replace OTHLOD = 0 if OTHLOD==.;
gen RNTAPY = 1 if 0  | inlist(UCC,800710);
replace RNTAPY = 0 if RNTAPY==.;
gen RNTXRP = 1 if 0  | inlist(UCC,210110,230121,230141,230150,240111,240121,240211,240221,240311,240321,320611,320621,320631,350110,790690,990920,990910);
replace RNTXRP = 0 if RNTXRP==.;
gen RENDWE = 1 if 0  | RNTXRP | RNTAPY;
replace RENDWE = 0 if RENDWE==.;
gen MRPINS = 1 if 0  | inlist(UCC,210901,220121,220901,230112,230113,230114,230115,230122,230142,230151,230901,240112,240122,240212,240213,240222,240312,240322,320612,320622,320632,340911,990930,220111);
replace MRPINS = 0 if MRPINS==.;
gen PROPTX = 1 if 0  | inlist(UCC,220211);
replace PROPTX = 0 if PROPTX==.;
gen MRTINT = 1 if 0  | inlist(UCC,220311,220321,220313,880110);
replace MRTINT = 0 if MRTINT==.;
gen OWNDWE = 1 if 0  | MRTINT | PROPTX | MRPINS;
replace OWNDWE = 0 if OWNDWE==.;
gen SHELT = 1 if 0  | OWNDWE | RENDWE | OTHLOD;
replace SHELT = 0 if SHELT==.;
gen HOUS = 1 if 0  | SHELT | UTIL | HOUSOP | HOUSEQ;
replace HOUS = 0 if HOUS==.;
gen ALCBEV = 1 if 0  | inlist(UCC,200900,790310,790320,790420);
replace ALCBEV = 0 if ALCBEV==.;
gen FDMAP = 1 if 0  | inlist(UCC,800700);
replace FDMAP = 0 if FDMAP==.;
gen FDXMAP = 1 if 0  | inlist(UCC,190901,190902,190903,790410,790430);
replace FDXMAP = 0 if FDXMAP==.;
gen FDAWAY = 1 if 0  | FDXMAP | FDMAP;
replace FDAWAY = 0 if FDAWAY==.;
gen FDHOME = 1 if 0  | inlist(UCC,190904,790220,790230);
replace FDHOME = 0 if FDHOME==.;
gen FOOD = 1 if 0  | FDHOME | FDAWAY;
replace FOOD = 0 if FOOD==.;
gen TOTEXP = 1 if 0  | FOOD | ALCBEV | HOUS | APPAR | TRANS | HEALTH | 
ENTERT | PERSCA | READ | EDUCA | TOBACC | MISC | 
CASHCO | PERINS;
replace TOTEXP = 0 if TOTEXP==.;

