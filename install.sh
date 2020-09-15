#!/bin/bash

#init checks
source ./modules/checks/init_check.sh

#install archlinux 
source ./modules/initial_setup/before_check.sh
source ./modules/initial_setup/work.sh
source ./modules/initial_setup/after_check.sh

arch-chroot /mnt/ sh /opt/ArchEvo/update.sh
