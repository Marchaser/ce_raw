#d ;
cd ${SRC}\1985;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	148-152
	int	VEHICYB	22-24
	int	VEHPURMO	70-71
	int	VEHPURYR	73-74
	int	VFINSTAT	78-78
	long	DNPAYMTX	105-110
	int	FIN_INST	112-112
	long	PRINCIPX	114-119
	long	VEHQPMT	121-124
	long	PAYMENTX	132-135
	int	PMTPERD	137-137
	long	EXTRCHGX	141-146
	long	NETPURX	89-94
	int	EMPLEXP	96-96
	long	EMPLEXPX	98-103
using 08904-0023-Data.txt;
save ..\v1985q1, replace;

cd ${SRC}\1986;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	148-152
	int	VEHICYB	22-24
	int	VEHPURMO	70-71
	int	VEHPURYR	73-74
	int	VFINSTAT	78-78
	long	DNPAYMTX	105-110
	int	FIN_INST	112-112
	long	PRINCIPX	114-119
	long	VEHQPMT	121-124
	long	PAYMENTX	132-135
	int	PMTPERD	137-137
	long	EXTRCHGX	141-146
	long	NETPURX	89-94
	int	EMPLEXP	96-96
	long	EMPLEXPX	98-103
using 09113-0023-Data.txt;
save ..\v1986q1, replace;

cd ${SRC}\1987;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	148-152
	int	VEHICYB	22-24
	int	VEHPURMO	70-71
	int	VEHPURYR	73-74
	int	VFINSTAT	78-78
	long	DNPAYMTX	105-110
	int	FIN_INST	112-112
	long	PRINCIPX	114-119
	long	VEHQPMT	121-124
	long	PAYMENTX	132-135
	int	PMTPERD	137-137
	long	EXTRCHGX	141-146
	long	NETPURX	89-94
	int	EMPLEXP	96-96
	long	EMPLEXPX	98-103
using 09332-0023-Data.txt;
save ..\v1987q1, replace;

cd ${SRC}\1988;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	141-145
	int	VEHICYB	19-21
	int	VEHPURMO	71-72
	int	VEHPURYR	74-75
	int	VFINSTAT	77-77
	long	DNPAYMTX	100-105
	int	FIN_INST	107-107
	long	PRINCIPX	109-114
	long	VEHQPMT	116-119
	long	PAYMENTX	127-130
	int	PMTPERD	132-132
	long	EXTRCHGX	134-139
	long	NETPURX	86-91
	long	EMPLEXP	93-98
	long	EMPLEXPX	93-98
using 09842-0033-Data.txt;
save ..\v1988q1, replace;

cd ${SRC}\1989;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	141-145
	int	VEHICYB	19-21
	int	VEHPURMO	71-72
	int	VEHPURYR	74-75
	int	VFINSTAT	77-77
	long	DNPAYMTX	100-105
	int	FIN_INST	107-107
	long	PRINCIPX	109-114
	long	VEHQPMT	116-119
	long	PAYMENTX	127-130
	int	PMTPERD	132-132
	long	EXTRCHGX	134-139
	long	NETPURX	86-91
	long	EMPLEXP	93-98
	long	EMPLEXPX	93-98
using 09841-0033-Data.txt;
save ..\v1989q1, replace;

cd ${SRC}\1990;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	141-145
	int	VEHICYB	19-21
	int	VEHPURMO	71-72
	int	VEHPURYR	74-75
	int	VFINSTAT	77-77
	long	DNPAYMTX	100-105
	int	FIN_INST	107-107
	long	PRINCIPX	109-114
	long	VEHQPMT	116-119
	long	PAYMENTX	127-130
	int	PMTPERD	132-132
	long	EXTRCHGX	134-139
	long	NETPURX	86-91
	long	EMPLEXP	93-98
	long	EMPLEXPX	93-98
using 09817-0033-Data.txt;
save ..\v1990q1, replace;

cd ${SRC}\1991;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	141-145
	int	VEHICYB	19-21
	int	VEHPURMO	71-72
	int	VEHPURYR	74-75
	int	VFINSTAT	77-77
	long	DNPAYMTX	100-105
	int	FIN_INST	107-107
	long	PRINCIPX	109-114
	long	VEHQPMT	116-119
	long	PAYMENTX	127-130
	int	PMTPERD	132-132
	long	EXTRCHGX	134-139
	long	NETPURX	86-91
	long	EMPLEXP	93-98
	long	EMPLEXPX	93-98
using 06262-0037-Data.txt;
save ..\v1991q1, replace;

cd ${SRC}\1992;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	135-139
	int	VEHICYB	19-21
	int	VEHPURMO	65-66
	int	VEHPURYR	68-69
	int	VFINSTAT	71-71
	long	DNPAYMTX	94-99
	int	FIN_INST	101-101
	long	PRINCIPX	103-108
	long	VEHQPMT	110-113
	long	PAYMENTX	121-124
	int	PMTPERD	126-126
	long	EXTRCHGX	128-133
	long	NETPURX	80-85
	long	EMPLEXP	87-92
	long	EMPLEXPX	87-92
using 06440-0036-Data.txt;
save ..\v1992q1, replace;

cd ${SRC}\1993;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	135-139
	int	VEHICYB	19-21
	int	VEHPURMO	65-66
	int	VEHPURYR	68-69
	int	VFINSTAT	71-71
	long	DNPAYMTX	94-99
	int	FIN_INST	101-101
	long	PRINCIPX	103-108
	long	VEHQPMT	110-113
	long	PAYMENTX	121-124
	int	PMTPERD	126-126
	long	EXTRCHGX	128-133
	long	NETPURX	80-85
	long	EMPLEXP	87-92
	long	EMPLEXPX	87-92
using 06543-0034-Data.txt;
save ..\v1993q1, replace;

cd ${SRC}\1994;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	135-139
	int	VEHICYB	19-21
	int	VEHPURMO	65-66
	int	VEHPURYR	68-69
	int	VFINSTAT	71-71
	long	DNPAYMTX	94-99
	int	FIN_INST	101-101
	long	PRINCIPX	103-108
	long	VEHQPMT	110-113
	long	PAYMENTX	121-124
	int	PMTPERD	126-126
	long	EXTRCHGX	128-133
	long	NETPURX	80-85
	long	EMPLEXP	87-92
	long	EMPLEXPX	87-92
using 06710-0042-Data.txt;
save ..\v1994q1, replace;

cd ${SRC}\1995;
clear;
infix
	int	QYEAR	1-3
	long	NEWID	4-11
	double	QINTRSTZ	135-139
	int	VEHICYB	19-21
	int	VEHPURMO	65-66
	int	VEHPURYR	68-69
	int	VFINSTAT	71-71
	long	DNPAYMTX	94-99
	int	FIN_INST	101-101
	long	PRINCIPX	103-108
	long	VEHQPMT	110-113
	long	PAYMENTX	121-124
	int	PMTPERD	126-126
	long	EXTRCHGX	128-133
	long	NETPURX	80-85
	long	EMPLEXP	87-92
	long	EMPLEXPX	87-92
using 02264-0046-Data.txt;
save ..\v1995q1, replace;
