#!/bin/bash

pacman -S --noconfirm sudo

usermod -a -G wheel user
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
