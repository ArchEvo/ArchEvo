#!/bin/python

import subprocess
import re
from functions import print_head
from functions import selection_table


print_head('timezone configuration', 'Please enter your continent:')

continents = subprocess.check_output('timedatectl list-timezones | sed "s/\/.*$//" | uniq', shell=True).decode().split('\n')

continents.remove('')
continents = sorted(continents)

for continent in continents:
    print(continent)
print()

while True:
    selected_continent = input("select:")

    if selected_continent in continents:
        print('your choice:"' + selected_continent + '"')
        break
    else:
        print('Your entry is invalid.')

citys = subprocess.check_output('timedatectl list-timezones | grep ' + selected_continent + ' | sed "s/^.*\///"', shell=True).decode().split('\n')

citys.remove('')
citys = sorted(citys)

selection_table(citys, 2)

print()
        
while True:
    selected_city = input("select:")

    if selected_city in citys:
        print('your choice:"' + selected_city + '"')
        break
    else:
        print('Your entry is invalid.')


file = open("/opt/ArchEvoConf/timezone_continent", "w") 
file.write(selected_continent) 
file.close()

file = open("/opt/ArchEvoConf/timezone_city", "w") 
file.write(selected_city) 
file.close()
