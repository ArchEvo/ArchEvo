#!/bin/bash

pacman -S --noconfirm --needed bluez bluez-utils bluez-libs bluez-plugins bluez-hid2hci
systemctl enable bluetooth.service
