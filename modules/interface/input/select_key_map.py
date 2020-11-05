#!/bin/python

import glob
import re
from functions import print_head
from functions import selection_table


print_head('Keyboard Configuration', 'Please choose your keyboard layout/keymap:')

keymaps = glob.glob('/usr/share/kbd/keymaps/i386/**/*.map.gz', recursive=True)

new_keymaps = []

for keymap in keymaps:
    temp = re.sub(r'^/.*/', '', keymap)
    temp = re.sub('.map.gz', '', temp)
    new_keymaps.append(temp)

keymaps = new_keymaps
keymaps = sorted(keymaps)

selection_table(keymaps, 2)

print()

while True:
    selected_keymap = input("select:")

    if selected_keymap in keymaps:
        print('your choice:"' + selected_keymap + '"')
        break
    else:
        print('Your entry is invalid.')

file = open("/opt/ArchEvoConf/vconsole_keymap", "w") 
file.write(selected_keymap)
file.close()
