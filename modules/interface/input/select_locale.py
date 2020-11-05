#!/bin/python

import subprocess
import re

from functions import print_head
from functions import selection_table


print_head('Locale configuration', 'Please enter the locale:')

f = open("/etc/locale.gen_nn", "r")
file = f.read()
locales_list = file.split('\n')

new_list = []

for i in locales_list:
    i = re.sub(r'#', '', i)
    i = re.search("^\w{2,4}_\w{2,4}", i)
    if isinstance(i, re.Match):
        if i.group(0) not in new_list:
            new_list.append(i.group(0))

locales = sorted(new_list)

selection_table(locales, 5)

print()

while True:
    selected_locale = input("select:")

    if selected_locale in locales:
        print('your choice:"' + selected_locale + '"')
        break
    else:
        print('Your entry is invalid.')

file = open("/opt/ArchEvoConf/locale", "w") 
file.write(selected_locale) 
file.close()
