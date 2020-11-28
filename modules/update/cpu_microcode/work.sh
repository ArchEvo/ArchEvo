#!/bin/bash

if [ $INPUT_CPU_VENDOR == intel ]; then
   pacman -S --noconfirm --needed intel-ucode
fi

if [ $INPUT_CPU_VENDOR == amd ]; then
   pacman -S --noconfirm --needed amd-ucode
fi

grub-mkconfig -o /boot/grub/grub.cfg
