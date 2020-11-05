#!/bin/python

from functions import print_head


print_head('Hostname configuration', 'Please enter the hostname:')

while True:
    hostname = input("select:")

    if hostname.isalpha():
        print('your choice:' + hostname)
        break
    else:
        print('your entry was invalid; the hostname may only contain alphabetic characters')

file = open("/opt/ArchEvoConf/hostname", "w") 
file.write(hostname) 
file.close()
