#!/bin/python

import subprocess
from functions import print_head


print_head('CPU configuration', '')

cpu_info = subprocess.check_output("lshw -c cpu | grep vendor | awk -F : '{ print $2 }' | xargs", shell=True).decode().strip().lower()

cpu_vendor = ''

if 'amd' in cpu_info:
    print('The installer has recognized an AMD cpu.')
    cpu_vendor = 'amd'

if 'intel' in cpu_info:
    print('The installer has recognized an Intel cpu.')
    cpu_vendor = 'intel'

if cpu_vendor:
    file = open("/opt/ArchEvoConf/cpu_vendor", "w") 
    file.write(cpu_vendor) 
    file.close()
