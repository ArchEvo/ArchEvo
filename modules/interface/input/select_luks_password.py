#!/bin/python

from functions import print_head


print_head('LUKS configuration', 'Please enter the HDD password (LUKS):')

while True:
    luks_password = input("select:")

    if len(luks_password) > 8:
        print('your choice:"' + luks_password + '"')
        break
    else:
        print('The password is too short. Please use at least eight characters.')
        print("If your password is shorter, you don't need encryption :-)")
        print("Optimal: more than 18 characters; Punctuation marks; Numbers; Big and small letters! Everything mixed up.")

file = open("/opt/ArchEvoConf/luks_password", "w") 
file.write(luks_password) 
file.close()
