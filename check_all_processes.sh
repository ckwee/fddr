ORA1_PROCESS=`if [ $(ps aux|grep -i ora_smon_DB1|grep -v grep|wc -l) -eq 1 ]; then echo 0; else echo 1;fi`
ORA2_PROCESS=`if [ $(ps aux|grep -i ora_smon_DB2|grep -v grep|wc -l) -eq 1 ]; then echo 0; else echo 1;fi`
SPX1_PROCESS=`if [ $(ps aux|grep -i sp_cop|grep -v grep|wc -l) -eq 1 ]; then echo 0; else echo 1;fi`
#SPX2_PROCESS=`if [ $(ps aux|grep -i sp_cop|grep -v grep|wc -l) -eq 1 ]; then echo 0; else echo 1;fi`
LNR1_PROCESS=`if [ $(ps aux|grep -i "tnslsnr LISTENER"|grep -v grep|wc -l) -ge 1 ]; then echo 0; else echo 1;fi`
#LNR2_PROCESS=`if [ $(ps aux|grep -i "tnslsnr LISTENER"|grep -v grep|wc -l) -ge 1 ]; then echo 0; else echo 1;fi`
DB1_TNSPING=`if tnsping DB1 2>/dev/null|grep -q -i ok ; then echo 0; else echo 1;fi`
DB2_TNSPING=`if tnsping DB2 2>/dev/null|grep -q -i ok ; then echo 0; else echo 1;fi`
OS1_PROCESS=`if ping -c1 localhost 2>/dev/null|grep -q -i icmp ; then echo 0; else echo 1;fi`
OS2_PROCESS=`if ping -c1 localhost 2>/dev/null|grep -q -i icmp ; then echo 0; else echo 1;fi`

#echo $ORA1_PROCESS~$ORA2_PROCESS~$SPX1_PROCESS~$SPX2_PROCESS~$LNR1_PROCESS~$LNR2_PROCESS~$OS1_PROCESS~$OS2_PROCESS
echo $ORA1_PROCESS~$ORA2_PROCESS~$SPX1_PROCESS~$LNR1_PROCESS~$DB1_TNSPING~$DB2_TNSPING~$OS1_PROCESS~$OS2_PROCESS

