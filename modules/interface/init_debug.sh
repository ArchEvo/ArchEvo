#!/bin/bash

# Configuration directory
mkdir -p /opt/ArchEvoConf
rm -f /opt/ArchEvoConf/*

echo 'de' > /opt/ArchEvoConf/vconsole_keymap

echo 'sda' > /opt/ArchEvoConf/install_drive
echo '123456' > /opt/ArchEvoConf/luks_password
echo '1' > /opt/ArchEvoConf/swap_size

echo 'ArchEvo' > /opt/ArchEvoConf/hostname
echo 'Berlin' > /opt/ArchEvoConf/timezone_city
echo 'Europe' > /opt/ArchEvoConf/timezone_continent
echo 'de_DE' > /opt/ArchEvoConf/locale

echo '123456' > /opt/ArchEvoConf/root_password
echo 'alex' > /opt/ArchEvoConf/user_name
echo '123456' > /opt/ArchEvoConf/user_password

echo 'vmware' > /opt/ArchEvoConf/gpu_driver
echo 'linux' > /opt/ArchEvoConf/linux_version
echo 'Germany' > /opt/ArchEvoConf/pacman_reflector_country

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
export INPUT_REFLECTOR_COUNTRY=$(cat /opt/ArchEvoConf/pacman_reflector_country)

# set locale environment
export LC_ALL=C
