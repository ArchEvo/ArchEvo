#!/bin/bash

pacman -S --noconfirm reflector

reflector --verbose -l 10 -a 12 --score 50 --sort rate -p https --country '$INPUT_REFLECTOR_COUNTRY'  --save /etc/pacman.d/mirrorlist
