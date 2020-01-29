export VDIR=/u01/app/splx/vdir
export EVENT_LOG=${VDIR}/log/event_log
export EVENT_LOG_BAK=${EVENT_LOG}_bak

CAPTURE=`diff ${EVENT_LOG} ${EVENT_LOG_BAK}|awk '/Error/ && /Capture/ {for(i=7; i<=13; ++i) printf "%s ", $i; print ""}' |head -n1`
if [ `echo $CAPTURE|wc -m` -lt 2 ]; then CAPTURE=0;fi
READ=`diff ${EVENT_LOG} ${EVENT_LOG_BAK}|awk '/Error/ && /Read/    {for(i=7; i<=13; ++i) printf "%s ", $i; print ""}' |head -n1`
if [ `echo $READ|wc -m` -lt 2 ]; then READ=0;fi
EXPORT=`diff ${EVENT_LOG} ${EVENT_LOG_BAK}|awk '/Error/ && /Export/  {for(i=7; i<=13; ++i) printf "%s ", $i; print ""}' |head -n1`
if [ `echo $EXPORT|wc -m` -lt 2 ]; then EXPORT=0;fi
IMPORT=`diff ${EVENT_LOG} ${EVENT_LOG_BAK}|awk '/Error/ && /Import/  {for(i=7; i<=13; ++i) printf "%s ", $i; print ""}' |head -n1`
if [ `echo $IMPORT|wc -m` -lt 2 ]; then IMPORT=0;fi
POST=`diff ${EVENT_LOG} ${EVENT_LOG_BAK}|awk '/Error/ && /Post/    {for(i=7; i<=13; ++i) printf "%s ", $i; print ""}' |head -n1` 
if [ `echo $POST|wc -m` -lt 2 ]; then POST=0;fi
#echo "CAPTURE~READ~EXPORT~IMPORT~POST"
echo "$CAPTURE~$READ~$EXPORT~$IMPORT~$POST"

#make backups
rm  ${EVENT_LOG_BAK}
cp  ${EVENT_LOG} ${EVENT_LOG_BAK}