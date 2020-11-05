#!/bin/python

import subprocess
import os 
from functions import print_head


print_head('Drive configuration', 'Please select the drive where Arch Linux will be installed:')

drives = subprocess.check_output('lsblk -d -o NAME | tail -n +2 | grep -v "^sr[0-999]" | grep -v "^loop[0-999]"', shell=True).decode().strip()
drives = drives.splitlines()


for drive in drives:
    drive_size = subprocess.check_output('lsblk --output SIZE -n -d /dev/' + drive, shell=True).decode().strip()

    print(drive + ' (' + drive_size + ')')
print()

while True:
    drive_input = input("select:")

    if drive_input in drives:
        print('your choice:"' + drive_input + '"')
        break
    else:
        print('your entry was invalid')


file = open("/opt/ArchEvoConf/install_drive", "w") 
file.write(drive_input) 
file.close()
