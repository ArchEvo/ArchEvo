#!/bin/bash

pacman -S --noconfirm --needed sudo

usermod -a -G wheel $INPUT_USER_NAME
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
