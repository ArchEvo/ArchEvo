#!/bin/bash

set -e

# pacman update signature
source /opt/ArchEvo/modules/update/pacman/work.sh

# get best mirror
source /opt/ArchEvo/modules/update/reflector/work.sh

# install and config ntp
source /opt/ArchEvo/modules/update/ntp/work.sh

# install and config gnome
source /opt/ArchEvo/modules/update/gnome/before_check.sh
source /opt/ArchEvo/modules/update/gnome/work.sh
source /opt/ArchEvo/modules/update/gnome/after_check.sh

# install and config networkmanager
source /opt/ArchEvo/modules/update/networkmanager/before_check.sh
source /opt/ArchEvo/modules/update/networkmanager/work.sh
source /opt/ArchEvo/modules/update/networkmanager/after_check.sh

# install and config snapper
source /opt/ArchEvo/modules/update/snapper/before_check.sh
source /opt/ArchEvo/modules/update/snapper/work.sh
source /opt/ArchEvo/modules/update/snapper/after_check.sh

# install font and ttf
source /opt/ArchEvo/modules/update/font/work.sh

# install network tools
source /opt/ArchEvo/modules/update/net_tools/work.sh

# install ufw / firewall
source /opt/ArchEvo/modules/update/ufw/work.sh

# install support filesystems
source /opt/ArchEvo/modules/update/filesystem/work.sh

# install libreoffice
source /opt/ArchEvo/modules/update/libreoffice/work.sh

# install yay
source /opt/ArchEvo/modules/update/yay/work.sh

# install and config sudo
source /opt/ArchEvo/modules/update/sudo/work.sh

# install and config power management
source /opt/ArchEvo/modules/update/power_management/work.sh

# install avahi
source /opt/ArchEvo/modules/update/avahi/work.sh

# install gpu driver
source /opt/ArchEvo/modules/update/gpu_driver/work.sh

# config timedatectl/
source /opt/ArchEvo/modules/update/timedatectl/work.sh
