
rt os
import time
import shutil
import difflib
import subprocess
import numpy as np
import datetime
import re
import csv
import system_matrix_lib as sm

def run_bash(cmd):
   try:
      output=subprocess.check_output(['bash','-c',cmd],stderr=subprocess.STDOUT)
   except subprocess.CalledProcessError as e:
      raise RuntimeError("command '{}' return with error (code {}): {}".format(e.cmd, e.returncode, e.output))
   return output

def decomment(csvfile):
    for row in csvfile:
        raw = row.split('#')[0].strip()
        if raw: yield raw       

l1=[]
#with open('/home/oracle/fddr/system_vector.txt') as csvfile:
#   readCSV = csv.reader(decomment(csvfile), delimiter='~')
#   for row in readCSV:
#      software_type=int(row[0])
#      software_service_grp=int(row[1])
#      cmd=row[3]
#      print(cmd)
#      a=int(run_bash(cmd))
#      l1.append(a)
#print(l1)
print (datetime.datetime.now())

print 'DRE log stats =', sm.dre_all_logstats()
print 'DRE proc stats=', sm.dre_all_processes()
print 'Diag service fault=', sm.get_system_matrix()
print 'DRE diagnose metrics=', sm.DRE_diagnostic_metrics()

with open('/home/oracle/fddr/breakfix.txt') as csvfile:
   readCSV = csv.reader(decomment(csvfile), delimiter='~')
   for row in readCSV:
      status=row[0]
      cmd=row[1]
      print('***',status,'****  ',cmd)
      a=run_bash(cmd)
      #print(a)
      time.sleep(30)
      print 'DRE log stats =', sm.dre_all_logstats()
      print 'DRE proc stats=', sm.dre_all_processes()
      print 'Diag service fault=', sm.get_system_matrix()
      print 'DRE diagnose metrics=', sm.DRE_diagnostic_metrics()  
      time.sleep(30)  
       
print ('***************ok',datetime.datetime.now())