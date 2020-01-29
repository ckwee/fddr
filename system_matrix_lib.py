import numpy as np
import csv
import subprocess
from IPython.core.display import display, HTML


################################################################################################
#
#THIS IS FOR MINING SPLX'S EVENT_LOGS, ORACLE'S ALERT_LOGS, LISTENER'S LOGS and OS' LOGS
#
################################################################################################
import os
import shutil
import difflib
import subprocess
import numpy as np
import re

def hashing(mesg):
    hashed_value=hash(mesg)%10**8
    return hashed_value

def run_bash(cmd):
   try:
      output=subprocess.check_output(['bash','-c',cmd],stderr=subprocess.STDOUT)
   except subprocess.CalledProcessError as e:
      raise RuntimeError("command '{}' return with error (code {}): {}".format(e.cmd, e.returncode, e.output))
   return output

def splx_fault_log():
   fff=[0,0,0,0,0]
   f='/home/oracle/fddr/check_event_log_err.sh'
   ff=run_bash(f).rstrip()
   ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]')
   fff = ansi_escape.sub('', ff)
   ffff=fff.split("~")     
   if ffff[0] =='0': ffff[0] = 0
   if ffff[1] =='0': ffff[1] = 0
   if ffff[2] =='0': ffff[2] = 0
   if ffff[3] =='0': ffff[3] = 0
   if ffff[4] =='0': ffff[4] = 0   
   splx_fault_list=[hashing(ffff[0]),hashing(ffff[1]),hashing(ffff[2]),hashing(ffff[3]),hashing(ffff[4])]
   return splx_fault_list

def ora_fault_log():
   ggg=[0,0,0]
   g='/home/oracle/fddr/check_alert_log_err.sh'
   gg=run_bash(g).rstrip()
   ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]')
   ggg = ansi_escape.sub('', gg)
   gggg=ggg.split("~")     
   if gggg[0] =='0': gggg[0] = 0
   if gggg[1] =='0': gggg[1] = 0
   if gggg[2] =='0': gggg[2] = 0
   ora_fault_list=[hashing(gggg[0]),hashing(gggg[1]),hashing(gggg[2])]
   return ora_fault_list

def dre_all_logstats():
   l1=splx_fault_log()
   l2=ora_fault_log()
   all_log_list=l1+l2
   return all_log_list


def dre_all_processes():
   j='/home/oracle/fddr/check_all_processes.sh'
   jj=run_bash(j).rstrip()
   ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]')
   jjj = ansi_escape.sub('', jj)
   jjjj=jjj.split("~")     
   all_process_list=[int(jjjj[0]),int(jjjj[1]),int(jjjj[2]),int(jjjj[3]),int(jjjj[4]),int(jjjj[5]),int(jjjj[6]),int(jjjj[7])]
   return all_process_list

###################################################################
#
#THIS IS FOR THE SYSTEM'S SOFTWARE METRICS
#
####################################################################


#def service_status_change(state):		#redundant
#    flag=1
#    if state==1:
#       flag=0
#    return flag

def decomment(csvfile):
    for row in csvfile:
        raw = row.split('#')[0].strip()
        if raw: yield raw

def get_system_matrix():
   line=0
   system_matrix= [[0 for col in range(6)] for row in range(5)] #initialize
   with open('/home/oracle/fddr/system_vector.txt') as csvfile:
      readCSV = csv.reader(decomment(csvfile), delimiter='~')
      for row in readCSV:
         line+=1
         software_type=int(row[0])
         software_service_grp=int(row[1])
         cmd=row[3]
         a=run_bash(cmd)
         status_flag=int(a.rstrip())
         #print(software_type, software_service_grp, int(a.rstrip()), status_flag)
         system_matrix[software_type][software_service_grp]+=status_flag
   return system_matrix
   
def dre_state():
   splx_fault_log()
   ora_fault_log()
   get_system_matrix()
   
def DRE_diagnostic_metrics():
   diag_metrics=[]
   with open('/home/oracle/fddr/system_vector.txt') as csvfile:
      readCSV = csv.reader(decomment(csvfile), delimiter='~')
      for row in readCSV:
         software_type=int(row[0])
         software_service_grp=int(row[1])
         cmd=row[3]
         a=int(run_bash(cmd))
         diag_metrics.append(a)
   return diag_metrics
