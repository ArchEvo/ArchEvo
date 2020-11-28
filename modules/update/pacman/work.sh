#!/bin/bash

pacman -Sy
pacman -S --noconfirm --needed archlinux-keyring
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys --keyserver hkp://pool.sks-keyservers.net 
