#d ;
cd ${SRC}\1984;
clear;
infix
	long	NEWID	1-8
	double	FINLWT21	606-616
	int	QINTRVMO	1007-1008
	int	QINTRVYR	1009-1010
	int	INCOMEY1	789-789
	int	INCOMEY2	791-791
	double	TOTEXPPQ	1231-1242
	double	TOTEXPCQ	1243-1254
	long	FNONFRMX	630-638
	long	FFRMINCX	329-337
	double	FOODPQ	1255-1266
	double	FOODCQ	1267-1278
	double	ALCBEVPQ	1279-1290
	double	ALCBEVCQ	1291-1302
	double	HOUSPQ	1303-1314
	double	HOUSCQ	1315-1326
	double	SHELTPQ	1327-1338
	double	SHELTCQ	1339-1350
	double	OWNDWEPQ	1351-1362
	double	OWNDWECQ	1363-1374
	double	RENDWEPQ	1375-1386
	double	RENDWECQ	1387-1398
	double	OTHLODPQ	1399-1410
	double	OTHLODCQ	1411-1422
	double	UTILPQ	1423-1434
	double	UTILCQ	1435-1446
	double	HOUSOPPQ	1447-1458
	double	HOUSOPCQ	1459-1470
	double	HOUSEQPQ	1471-1482
	double	HOUSEQCQ	1483-1494
	double	APPARPQ 	1495-1506
	double	APPARCQ 	1507-1518
	double	TRANSPQ 	1519-1530
	double	TRANSCQ 	1531-1542
	double	VEHICLPQ	1543-1554
	double	VEHICLCQ	1555-1566
	double	GASMOPQ 	1567-1578
	double	GASMOCQ 	1579-1590
	double	OTHVEHPQ	1591-1602
	double	OTHVEHCQ	1603-1614
	double	PUBTRAPQ	1615-1626
	double	PUBTRACQ	1627-1638
	double	HEALTHPQ	1639-1650
	double	HEALTHCQ	1651-1662
	double	ENTERTPQ	1663-1674
	double	ENTERTCQ	1675-1686
	double	PERSCAPQ	1687-1698
	double	PERSCACQ	1699-1710
	double	READPQ  	1711-1722
	double	READCQ  	1723-1734
	double	EDUCAPQ 	1735-1746
	double	EDUCACQ 	1747-1758
	double	TOBACCPQ	1759-1770
	double	TOBACCCQ	1771-1782
	double	MISCPQ  	1783-1794
	double	MISCCQ  	1795-1806
	double	CASHCOPQ	1807-1818
	double	CASHCOCQ	1819-1830
	double	PERINSPQ	1831-1842
	double	PERINSCQ	1843-1854
	double	LIFINSPQ	1855-1866
	double	LIFINSCQ	1867-1878
	double	RETPENPQ	1879-1890
	double	RETPENCQ	1891-1902
using 08671-0001-Data.txt;
save ..\f1984q1, replace;

cd ${SRC}\1984;
clear;
infix
	long	NEWID	1-8
	double	FINLWT21	606-616
	int	QINTRVMO	1007-1008
	int	QINTRVYR	1009-1010
	int	INCOMEY1	789-789
	int	INCOMEY2	791-791
	double	TOTEXPPQ	1231-1242
	double	TOTEXPCQ	1243-1254
	long	FNONFRMX	630-638
	long	FFRMINCX	329-337
	double	FOODPQ	1255-1266
	double	FOODCQ	1267-1278
	double	ALCBEVPQ	1279-1290
	double	ALCBEVCQ	1291-1302
	double	HOUSPQ	1303-1314
	double	HOUSCQ	1315-1326
	double	SHELTPQ	1327-1338
	double	SHELTCQ	1339-1350
	double	OWNDWEPQ	1351-1362
	double	OWNDWECQ	1363-1374
	double	RENDWEPQ	1375-1386
	double	RENDWECQ	1387-1398
	double	OTHLODPQ	1399-1410
	double	OTHLODCQ	1411-1422
	double	UTILPQ	1423-1434
	double	UTILCQ	1435-1446
	double	HOUSOPPQ	1447-1458
	double	HOUSOPCQ	1459-1470
	double	HOUSEQPQ	1471-1482
	double	HOUSEQCQ	1483-1494
	double	APPARPQ 	1495-1506
	double	APPARCQ 	1507-1518
	double	TRANSPQ 	1519-1530
	double	TRANSCQ 	1531-1542
	double	VEHICLPQ	1543-1554
	double	VEHICLCQ	1555-1566
	double	GASMOPQ 	1567-1578
	double	GASMOCQ 	1579-1590
	double	OTHVEHPQ	1591-1602
	double	OTHVEHCQ	1603-1614
	double	PUBTRAPQ	1615-1626
	double	PUBTRACQ	1627-1638
	double	HEALTHPQ	1639-1650
	double	HEALTHCQ	1651-1662
	double	ENTERTPQ	1663-1674
	double	ENTERTCQ	1675-1686
	double	PERSCAPQ	1687-1698
	double	PERSCACQ	1699-1710
	double	READPQ  	1711-1722
	double	READCQ  	1723-1734
	double	EDUCAPQ 	1735-1746
	double	EDUCACQ 	1747-1758
	double	TOBACCPQ	1759-1770
	double	TOBACCCQ	1771-1782
	double	MISCPQ  	1783-1794
	double	MISCCQ  	1795-1806
	double	CASHCOPQ	1807-1818
	double	CASHCOCQ	1819-1830
	double	PERINSPQ	1831-1842
	double	PERINSCQ	1843-1854
	double	LIFINSPQ	1855-1866
	double	LIFINSCQ	1867-1878
	double	RETPENPQ	1879-1890
	double	RETPENCQ	1891-1902
using 08671-0005-Data.txt;
save ..\f1984q2, replace;

cd ${SRC}\1984;
clear;
infix
	long	NEWID	1-8
	double	FINLWT21	606-616
	int	QINTRVMO	1007-1008
	int	QINTRVYR	1009-1010
	int	INCOMEY1	789-789
	int	INCOMEY2	791-791
	double	TOTEXPPQ	1231-1242
	double	TOTEXPCQ	1243-1254
	long	FNONFRMX	630-638
	long	FFRMINCX	329-337
	double	FOODPQ	1255-1266
	double	FOODCQ	1267-1278
	double	ALCBEVPQ	1279-1290
	double	ALCBEVCQ	1291-1302
	double	HOUSPQ	1303-1314
	double	HOUSCQ	1315-1326
	double	SHELTPQ	1327-1338
	double	SHELTCQ	1339-1350
	double	OWNDWEPQ	1351-1362
	double	OWNDWECQ	1363-1374
	double	RENDWEPQ	1375-1386
	double	RENDWECQ	1387-1398
	double	OTHLODPQ	1399-1410
	double	OTHLODCQ	1411-1422
	double	UTILPQ	1423-1434
	double	UTILCQ	1435-1446
	double	HOUSOPPQ	1447-1458
	double	HOUSOPCQ	1459-1470
	double	HOUSEQPQ	1471-1482
	double	HOUSEQCQ	1483-1494
	double	APPARPQ 	1495-1506
	double	APPARCQ 	1507-1518
	double	TRANSPQ 	1519-1530
	double	TRANSCQ 	1531-1542
	double	VEHICLPQ	1543-1554
	double	VEHICLCQ	1555-1566
	double	GASMOPQ 	1567-1578
	double	GASMOCQ 	1579-1590
	double	OTHVEHPQ	1591-1602
	double	OTHVEHCQ	1603-1614
	double	PUBTRAPQ	1615-1626
	double	PUBTRACQ	1627-1638
	double	HEALTHPQ	1639-1650
	double	HEALTHCQ	1651-1662
	double	ENTERTPQ	1663-1674
	double	ENTERTCQ	1675-1686
	double	PERSCAPQ	1687-1698
	double	PERSCACQ	1699-1710
	double	READPQ  	1711-1722
	double	READCQ  	1723-1734
	double	EDUCAPQ 	1735-1746
	double	EDUCACQ 	1747-1758
	double	TOBACCPQ	1759-1770
	double	TOBACCCQ	1771-1782
	double	MISCPQ  	1783-1794
	double	MISCCQ  	1795-1806
	double	CASHCOPQ	1807-1818
	double	CASHCOCQ	1819-1830
	double	PERINSPQ	1831-1842
	double	PERINSCQ	1843-1854
	double	LIFINSPQ	1855-1866
	double	LIFINSCQ	1867-1878
	double	RETPENPQ	1879-1890
	double	RETPENCQ	1891-1902
using 08671-0009-Data.txt;
save ..\f1984q3, replace;

cd ${SRC}\1984;
clear;
infix
	long	NEWID	1-8
	double	FINLWT21	606-616
	int	QINTRVMO	1007-1008
	int	QINTRVYR	1009-1010
	int	INCOMEY1	789-789
	int	INCOMEY2	791-791
	double	TOTEXPPQ	1231-1242
	double	TOTEXPCQ	1243-1254
	long	FNONFRMX	630-638
	long	FFRMINCX	329-337
	double	FOODPQ	1255-1266
	double	FOODCQ	1267-1278
	double	ALCBEVPQ	1279-1290
	double	ALCBEVCQ	1291-1302
	double	HOUSPQ	1303-1314
	double	HOUSCQ	1315-1326
	double	SHELTPQ	1327-1338
	double	SHELTCQ	1339-1350
	double	OWNDWEPQ	1351-1362
	double	OWNDWECQ	1363-1374
	double	RENDWEPQ	1375-1386
	double	RENDWECQ	1387-1398
	double	OTHLODPQ	1399-1410
	double	OTHLODCQ	1411-1422
	double	UTILPQ	1423-1434
	double	UTILCQ	1435-1446
	double	HOUSOPPQ	1447-1458
	double	HOUSOPCQ	1459-1470
	double	HOUSEQPQ	1471-1482
	double	HOUSEQCQ	1483-1494
	double	APPARPQ 	1495-1506
	double	APPARCQ 	1507-1518
	double	TRANSPQ 	1519-1530
	double	TRANSCQ 	1531-1542
	double	VEHICLPQ	1543-1554
	double	VEHICLCQ	1555-1566
	double	GASMOPQ 	1567-1578
	double	GASMOCQ 	1579-1590
	double	OTHVEHPQ	1591-1602
	double	OTHVEHCQ	1603-1614
	double	PUBTRAPQ	1615-1626
	double	PUBTRACQ	1627-1638
	double	HEALTHPQ	1639-1650
	double	HEALTHCQ	1651-1662
	double	ENTERTPQ	1663-1674
	double	ENTERTCQ	1675-1686
	double	PERSCAPQ	1687-1698
	double	PERSCACQ	1699-1710
	double	READPQ  	1711-1722
	double	READCQ  	1723-1734
	double	EDUCAPQ 	1735-1746
	double	EDUCACQ 	1747-1758
	double	TOBACCPQ	1759-1770
	double	TOBACCCQ	1771-1782
	double	MISCPQ  	1783-1794
	double	MISCCQ  	1795-1806
	double	CASHCOPQ	1807-1818
	double	CASHCOCQ	1819-1830
	double	PERINSPQ	1831-1842
	double	PERINSCQ	1843-1854
	double	LIFINSPQ	1855-1866
	double	LIFINSCQ	1867-1878
	double	RETPENPQ	1879-1890
	double	RETPENCQ	1891-1902
using 08671-0013-Data.txt;
save ..\f1984q4, replace;

cd ${SRC}\1984;
clear;
infix
	long	NEWID	1-8
	double	FINLWT21	606-616
	int	QINTRVMO	1007-1008
	int	QINTRVYR	1009-1010
	int	INCOMEY1	789-789
	int	INCOMEY2	791-791
	double	TOTEXPPQ	1231-1242
	double	TOTEXPCQ	1243-1254
	long	FNONFRMX	630-638
	long	FFRMINCX	329-337
	double	FOODPQ	1255-1266
	double	FOODCQ	1267-1278
	double	ALCBEVPQ	1279-1290
	double	ALCBEVCQ	1291-1302
	double	HOUSPQ	1303-1314
	double	HOUSCQ	1315-1326
	double	SHELTPQ	1327-1338
	double	SHELTCQ	1339-1350
	double	OWNDWEPQ	1351-1362
	double	OWNDWECQ	1363-1374
	double	RENDWEPQ	1375-1386
	double	RENDWECQ	1387-1398
	double	OTHLODPQ	1399-1410
	double	OTHLODCQ	1411-1422
	double	UTILPQ	1423-1434
	double	UTILCQ	1435-1446
	double	HOUSOPPQ	1447-1458
	double	HOUSOPCQ	1459-1470
	double	HOUSEQPQ	1471-1482
	double	HOUSEQCQ	1483-1494
	double	APPARPQ 	1495-1506
	double	APPARCQ 	1507-1518
	double	TRANSPQ 	1519-1530
	double	TRANSCQ 	1531-1542
	double	VEHICLPQ	1543-1554
	double	VEHICLCQ	1555-1566
	double	GASMOPQ 	1567-1578
	double	GASMOCQ 	1579-1590
	double	OTHVEHPQ	1591-1602
	double	OTHVEHCQ	1603-1614
	double	PUBTRAPQ	1615-1626
	double	PUBTRACQ	1627-1638
	double	HEALTHPQ	1639-1650
	double	HEALTHCQ	1651-1662
	double	ENTERTPQ	1663-1674
	double	ENTERTCQ	1675-1686
	double	PERSCAPQ	1687-1698
	double	PERSCACQ	1699-1710
	double	READPQ  	1711-1722
	double	READCQ  	1723-1734
	double	EDUCAPQ 	1735-1746
	double	EDUCACQ 	1747-1758
	double	TOBACCPQ	1759-1770
	double	TOBACCCQ	1771-1782
	double	MISCPQ  	1783-1794
	double	MISCCQ  	1795-1806
	double	CASHCOPQ	1807-1818
	double	CASHCOCQ	1819-1830
	double	PERINSPQ	1831-1842
	double	PERINSCQ	1843-1854
	double	LIFINSPQ	1855-1866
	double	LIFINSCQ	1867-1878
	double	RETPENPQ	1879-1890
	double	RETPENCQ	1891-1902
using 08671-0017-Data.txt;
save ..\f1984q5, replace;

cd ${SRC}\1984;
clear;
infix
	long	NEWID	1-8
	double	FINLWT21	606-616
	int	QINTRVMO	1007-1008
	int	QINTRVYR	1009-1010
	int	INCOMEY1	789-789
	int	INCOMEY2	791-791
	double	TOTEXPPQ	1231-1242
	double	TOTEXPCQ	1243-1254
	long	FNONFRMX	630-638
	long	FFRMINCX	329-337
	double	FOODPQ	1255-1266
	double	FOODCQ	1267-1278
	double	ALCBEVPQ	1279-1290
	double	ALCBEVCQ	1291-1302
	double	HOUSPQ	1303-1314
	double	HOUSCQ	1315-1326
	double	SHELTPQ	1327-1338
	double	SHELTCQ	1339-1350
	double	OWNDWEPQ	1351-1362
	double	OWNDWECQ	1363-1374
	double	RENDWEPQ	1375-1386
	double	RENDWECQ	1387-1398
	double	OTHLODPQ	1399-1410
	double	OTHLODCQ	1411-1422
	double	UTILPQ	1423-1434
	double	UTILCQ	1435-1446
	double	HOUSOPPQ	1447-1458
	double	HOUSOPCQ	1459-1470
	double	HOUSEQPQ	1471-1482
	double	HOUSEQCQ	1483-1494
	double	APPARPQ 	1495-1506
	double	APPARCQ 	1507-1518
	double	TRANSPQ 	1519-1530
	double	TRANSCQ 	1531-1542
	double	VEHICLPQ	1543-1554
	double	VEHICLCQ	1555-1566
	double	GASMOPQ 	1567-1578
	double	GASMOCQ 	1579-1590
	double	OTHVEHPQ	1591-1602
	double	OTHVEHCQ	1603-1614
	double	PUBTRAPQ	1615-1626
	double	PUBTRACQ	1627-1638
	double	HEALTHPQ	1639-1650
	double	HEALTHCQ	1651-1662
	double	ENTERTPQ	1663-1674
	double	ENTERTCQ	1675-1686
	double	PERSCAPQ	1687-1698
	double	PERSCACQ	1699-1710
	double	READPQ  	1711-1722
	double	READCQ  	1723-1734
	double	EDUCAPQ 	1735-1746
	double	EDUCACQ 	1747-1758
	double	TOBACCPQ	1759-1770
	double	TOBACCCQ	1771-1782
	double	MISCPQ  	1783-1794
	double	MISCCQ  	1795-1806
	double	CASHCOPQ	1807-1818
	double	CASHCOCQ	1819-1830
	double	PERINSPQ	1831-1842
	double	PERINSCQ	1843-1854
	double	LIFINSPQ	1855-1866
	double	LIFINSCQ	1867-1878
	double	RETPENPQ	1879-1890
	double	RETPENCQ	1891-1902
using 08671-0023-Data.txt;
save ..\f1984q6, replace;

