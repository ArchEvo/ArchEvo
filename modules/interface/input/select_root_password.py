#!/bin/python

from functions import print_head


print_head('root password configuration', 'Please enter the root password:')

while True:
    root_password = input("select:")

    if len(root_password) > 5:
        print('your choice:"' + root_password + '"')
        break
    else:
        print('The password is too short. Please at least six characters.')


file = open("/opt/ArchEvoConf/root_password", "w") 
file.write(root_password) 
file.close()
