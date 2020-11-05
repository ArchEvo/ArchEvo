#!/bin/python

from functions import print_head
from functions import print_request


print_head('GPU configuration', 'Please enter your gpu:')

gpus = ['AMD/ATI', 'Nvidia', 'Intel', 'VM']

for gpu in gpus:
    print(gpu)
print()

while True:
    selected_gpu = input("select:")

    if selected_gpu in gpus:
        print('your choice:"' + selected_gpu + '"')
        break
    else:
        print('Your entry is invalid.')

print_request('Please select the graphic card driver:')

if selected_gpu == 'AMD/ATI':
    gpu_drivers = ['amdgpu', 'ati']
    note = """"
note: ...amd...
"""

if selected_gpu == 'Nvidia':
    gpu_drivers = ['nouveau', 'nvidia']
    note = """
note: ...nvidia...
"""

if selected_gpu == 'Intel':
    gpu_drivers = ['intel']
    note = """
note: ...intel...
"""

if selected_gpu == 'VM':
    gpu_drivers = ['virtualbox', 'vmware']
    note= """
note: ...vm...
"""


for gpu_driver in gpu_drivers:
    print(gpu_driver)
print(note)
print()

while True:
    selected_gpu_driver = input("select:")

    if selected_gpu_driver in gpu_drivers:
        print('your choice:"' + selected_gpu_driver + '"')
        break
    else:
        print('Your entry is invalid.')


file = open("/opt/ArchEvoConf/gpu_driver", "w") 
file.write(selected_gpu_driver) 
file.close()
