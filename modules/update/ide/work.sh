#!/bin/bash

pacman -S --noconfirm --needed arduino arduino-cli arduino-docs arduino-avr-core avr-gcc avr-binutils avr-libc avrdude code esptool

# userconfig
gpasswd -a $INPUT_USER_NAME lock
gpasswd -a $INPUT_USER_NAME uucp
