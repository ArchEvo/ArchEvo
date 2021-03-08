#!/bin/bash

set -e
set -u
set -o pipefail

# set environment
export INPUT_VCONSOLE_KEYMAP=$(cat /opt/ArchEvoConf/vconsole_keymap)
export INPUT_HOSTNAME=$(cat /opt/ArchEvoConf/hostname)
export INPUT_TIMEZONE_CITY=$(cat /opt/ArchEvoConf/timezone_city)
export INPUT_TIMEZONE_CONTINENT=$(cat /opt/ArchEvoConf/timezone_continent)
export INPUT_LOCALE=$(cat /opt/ArchEvoConf/locale)
export INPUT_USER_NAME=$(cat /opt/ArchEvoConf/user_name)
export INPUT_GPU_DRIVER=$(cat /opt/ArchEvoConf/gpu_driver)
export INPUT_CPU_VENDOR=$(cat /opt/ArchEvoConf/cpu_vendor)
export INPUT_LINUX_VERSION=$(cat /opt/ArchEvoConf/linux_version)
export INPUT_REFLECTOR_COUNTRY=$(cat /opt/ArchEvoConf/pacman_reflector_country)

# set locale environment
export LC_ALL=C


# pacman update signature
source /opt/ArchEvo/modules/update/pacman/work.sh

# get best mirror
source /opt/ArchEvo/modules/update/reflector/work.sh

# install and config ntp
source /opt/ArchEvo/modules/update/ntp/work.sh

# install audio
source /opt/ArchEvo/modules/update/pipewire/work.sh
#source /opt/ArchEvo/modules/update/audio/work.sh

# install graphic
source /opt/ArchEvo/modules/update/graphic/work.sh

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

# install gpu driver
source /opt/ArchEvo/modules/update/gpu_driver/work.sh

# config timedatectl
source /opt/ArchEvo/modules/update/timedatectl/work.sh

# install codecs and hardware video acceleration
source /opt/ArchEvo/modules/update/codecs/work.sh

# install cpu microcode
source /opt/ArchEvo/modules/update/cpu_microcode/work.sh

# install gvfs
source /opt/ArchEvo/modules/update/gvfs/work.sh

# install utilities
source /opt/ArchEvo/modules/update/utilities/work.sh

# install bluetooth
source /opt/ArchEvo/modules/update/bluetooth/work.sh

# install printer
source /opt/ArchEvo/modules/update/printer/work.sh

# install input
source /opt/ArchEvo/modules/update/input/work.sh

# config sysctl
source /opt/ArchEvo/modules/update/sysctl/work.sh

# config ide
source /opt/ArchEvo/modules/update/ide/work.sh
