#!/bin/python

from functions import print_head


print_head('Linux kernel configuration', 'Please enter your linux version:')

linux_versions = ['linux', 'linux-lts', 'linux-hardened']

for linux_version in linux_versions:
    print(linux_version)
print()

while True:
    selected_linux_version = input("select:")

    if selected_linux_version in linux_versions:
        print('your choice:"' + selected_linux_version + '"')
        break
    else:
        print('Your entry is invalid.')


file = open("/opt/ArchEvoConf/linux_version", "w") 
file.write(selected_linux_version) 
file.close()
