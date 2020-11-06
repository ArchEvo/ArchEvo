#!/bin/bash

#init checks
source ./modules/install/checks/init_check.sh

#init interface
source ./modules/interface/init_install.sh

#install archlinux 
source ./modules/install/init/before_check.sh
source ./modules/install/init/work.sh
source ./modules/install/init/after_check.sh

arch-chroot /mnt/ sh /opt/ArchEvo/update.sh
