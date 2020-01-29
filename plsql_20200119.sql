CREATE OR REPLACE procedure  update_table
is
 begin
   insert into t1 (c1,c2,c3) values (999,999,999);
   commit;
   --update t1 set c2=888 where c1=999;
   --commit;
   delete from t1 where c1=999;
   commit;
 end;
 /






 
------------------UPDATE EVERY MIN ONLY------------------------------

ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YYYY HH24:MI:SS';
SET SERVEROUTPUT ON

var v_JobNo number;
exec dbms_job.submit(:v_JobNo, 'CK.UPDATE_TABLE;', INTERVAL => 'SYSDATE+(1/1440)');

exec dbms_job.remove(XX);

   
--------------------EVERY 10 SEC 
begin
dbms_scheduler.create_job (
   job_name           =>  'UPDATE_EVERY_10SEC',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'CK.UPDATE_TABLE',
   start_date         =>  SYSDATE,
   repeat_interval    =>  'FREQ=SECONDLY;INTERVAL=5',
   enabled            =>  TRUE);
END;
/

EXEC DBMS_SCHEDULER.DROP_JOB(JOB_NAME=>'UPDATE_EVERY_10SEC');
---------------------------------






