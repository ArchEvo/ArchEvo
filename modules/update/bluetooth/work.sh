#!/bin/bash

pacman -S --noconfirm --needed bluez bluez-utils bluez-libs bluez-plugins 
systemctl enable bluetooth.service
