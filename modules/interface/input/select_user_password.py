#!/bin/python

from functions import print_head


print_head('user password configuration', 'Please enter the user password:')

while True:
    user_password = input("select:")

    if len(user_password) > 5:
        print('your choice:' + user_password)
        break
    else:
        print('The password is too short. Please at least six characters.')


file = open("/opt/ArchEvoConf/user_password", "w") 
file.write(user_password) 
file.close()
