#!/bin/bash

set -e

#init checks
source ./modules/install/checks/init_check.sh

#init interface
source ./modules/interface/init_install.sh

#install archlinux 
source ./modules/install/init/before.sh
source ./modules/install/init/work.sh

# start update script; install/config packages 
arch-chroot /mnt/ sh /opt/ArchEvo/update.sh

# umount partition
source ./modules/install/init/after.sh
