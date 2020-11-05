#!/bin/python

from functions import print_head


print_head('swap configuration', 'Please specify the size of the swap file in GB (integer):')

while True:
    swap_size = input("select:")

    if swap_size.isnumeric():
        print('your choice:' + swap_size + 'GB')
        break
    else:
        print('your entry was invalid')


file = open("/opt/ArchEvoConf/swap_size", "w") 
file.write(swap_size) 
file.close()
