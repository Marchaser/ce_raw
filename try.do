use ${SRC}\bls9613\fmli961x, clear
rename *, upper
bysort NEWID QINTRVYR QINTRVMO: egen nobs=count(NEWID)

cd D:\data\cex\bls9613
use mtbi962, clear
