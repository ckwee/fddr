source /u01/app/splx/mdir/job_profile_2100

/u01/app/splx/mdir/shutdown.sh 
echo "startup all shareplex process..."

nohup ${PDIR}/bin/sp_cop -u${ORACLE_SIDR}_${sp_cop_uport} > output.out  2>error.err < /dev/null &
#nohup ${PDIR}/bin/sp_cop -u${ORACLE_SIDR}_${sp_cop_uport} 2> /dev/null &
