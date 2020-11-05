#!/bin/python

from functions import print_head


print_head('username configuration', 'Please enter the username:')

while True:
    user_name = input("select:")

    if user_name.isprintable():
        print('your choice:' + user_name)
        break
    else:
        print('Your entry has invalid characters.')


file = open("/opt/ArchEvoConf/user_name", "w") 
file.write(user_name) 
file.close()
