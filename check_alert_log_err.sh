export ORACLE_BASE=/u01/app/oracle
export DB1_ALERT_LOG=${ORACLE_BASE}/diag/rdbms/db1/DB1/trace/alert_DB1.log
export DB1_ALERT_LOG_BAK=${DB1_ALERT_LOG}_bak
export DB2_ALERT_LOG=${ORACLE_BASE}/diag/rdbms/db2/DB2/trace/alert_DB2.log
export DB2_ALERT_LOG_BAK=${DB2_ALERT_LOG}_bak
export LISTENER_LOG=${ORACLE_BASE}/diag/tnslsnr/localhost/listener/trace/listener.log
export LISTENER_LOG_BAK=${LISTENER_LOG}_bak

DB1=`diff ${DB1_ALERT_LOG} ${DB1_ALERT_LOG_BAK}|awk '/ORA-/ {print $2}'|head -n1`
if [ `echo $DB1|wc -m` -lt 2  ]; then DB1=0;fi

DB2=`diff ${DB2_ALERT_LOG} ${DB2_ALERT_LOG_BAK}|awk '/ORA-/ {print $2}'|head -n1`
if [ `echo $DB2|wc -m` -lt 2  ]; then DB2=0;fi

LSNR=`diff ${LISTENER_LOG} ${LISTENER_LOG_BAK}|awk '/TNS-/ {print $2}'|head -n1`
if [ `echo $LSNR|wc -m` -lt 2 ]; then LSNR=0;fi

echo $DB1~$DB2~$LSNR
#make backups
rm ${DB1_ALERT_LOG_BAK}
cp ${DB1_ALERT_LOG} ${DB1_ALERT_LOG_BAK}
rm ${DB2_ALERT_LOG_BAK}
cp ${DB2_ALERT_LOG} ${DB2_ALERT_LOG_BAK}
rm ${LISTENER_LOG_BAK}
cp ${LISTENER_LOG} ${LISTENER_LOG_BAK}

