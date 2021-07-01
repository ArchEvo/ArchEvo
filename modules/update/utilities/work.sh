#!/bin/bash

# filesystem
pacman -S --noconfirm --needed iotop sysstat lsof lostfiles ncdu
pacman -S --noconfirm --needed cifs-utils exfat-utils nfs-utils nilfs-utils

# compress
pacman -S --noconfirm --needed unrar unzip p7zip lhasa

# network
pacman -S --noconfirm --needed inetutils iputils bind-tools iotop sysstat whois tcpdump

# prozess
pacman -S --noconfirm --needed sysstat htop top

# scripting
pacman -S --noconfirm --needed jq

# hardware
pacman -S --noconfirm --needed smartmontools
