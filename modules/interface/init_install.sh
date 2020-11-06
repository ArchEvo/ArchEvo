#!/bin/bash

# Configuration directory
mkdir -p /opt/ArchEvoConf
rm /opt/ArchEvoConf/*

./modules/interface/input/select_key_map.py

./modules/interface/input/select_drive.py
./modules/interface/input/select_luks_password.py
./modules/interface/input/select_swap_size.py

./modules/interface/input/select_hostname.py
./modules/interface/input/select_timezone.py
./modules/interface/input/select_locale.py

./modules/interface/input/select_root_password.py
./modules/interface/input/select_user_name.py
./modules/interface/input/select_user_password.py

./modules/interface/input/select_gpu.py
./modules/interface/input/select_linux_version.py


# set environment
export INPUT_VCONSOLE_KEYMAP=$(cat /opt/ArchEvoConf/vconsole_keymap)
export INPUT_INSTALL_DRIVE=$(cat /opt/ArchEvoConf/install_drive)
export INPUT_LUKS_PASSWORD=$(cat /opt/ArchEvoConf/luks_password)
export INPUT_HOSTNAME=$(cat /opt/ArchEvoConf/hostname)
export INPUT_TIMEZONE_CITY=$(cat /opt/ArchEvoConf/timezone_city)
export INPUT_TIMEZONE_CONTINENT=$(cat /opt/ArchEvoConf/timezone_continent)
export INPUT_SWAP_SIZE=$(cat /opt/ArchEvoConf/swap_size)
export INPUT_LOCALE=$(cat /opt/ArchEvoConf/locale)
export INPUT_ROOT_PASSWORD=$(cat /opt/ArchEvoConf/root_password)
export INPUT_USER_NAME=$(cat /opt/ArchEvoConf/user_name)
export INPUT_USER_PASSWORD=$(cat /opt/ArchEvoConf/user_password)
export INPUT_GPU_DRIVER=$(cat /opt/ArchEvoConf/gpu_driver)
export INPUT_LINUX_VERSION=$(cat /opt/ArchEvoConf/linux_version)


#echo $INPUT_VCONSOLE_KEYMAP
#echo $INPUT_INSTALL_DRIVE
#echo $INPUT_LUKS_PASSWORD
#echo $INPUT_SWAP_SIZE
#echo $INPUT_HOSTNAME
#echo $INPUT_TIMEZONE_CITY
#echo $INPUT_TIMEZONE_CONTINENT
#echo $INPUT_LOCALE
#echo $INPUT_ROOT_PASSWORD
#echo $INPUT_USER_NAME
#echo $INPUT_USER_PASSWORD
#echo $INPUT_GPU_DRIVER
#echo $INPUT_LINUX_VERSION
