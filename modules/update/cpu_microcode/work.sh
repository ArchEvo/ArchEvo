#!/bin/bash

if [ $INPUT_CPU_VENDOR == intel ]; then
   pacman -Syy --noconfirm intel-ucode
fi

if [ $INPUT_CPU_VENDOR == amd ]; then
   pacman -Syy --noconfirm amd-ucode
fi

grub-mkconfig -o /boot/grub/grub.cfg
