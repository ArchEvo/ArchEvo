#!/bin/python

import glob
import re
from functions import print_head
from functions import selection_table
import subprocess
import os
from functions import print_head


print_head('Pacman mirror configuration', 'Please select the country from which pacman download his packages:')

countries = subprocess.check_output('reflector --list-countries', shell=True).decode()
countries = countries.splitlines()

new_countries = []

for country in countries:
    country = re.sub(r'[A-Za-z]*\s*\d*$', '', country).strip()
    new_countries.append(country)

countries = sorted(new_countries)

selection_table(countries, 2)


while True:
    selected_country = input("select:")

    if selected_country in countries:
        print('your choice:"' + selected_country + '"')
        break
    else:
        print('Your entry is invalid.')

file = open("/opt/ArchEvoConf/pacman_reflector_country", "w") 
file.write(selected_country)
file.close()
