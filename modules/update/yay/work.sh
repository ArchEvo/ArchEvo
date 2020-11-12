#!/bin/bash

pacman -S --noconfirm git base-devel go

git clone https://aur.archlinux.org/yay.git /tmp/ArchEvo_yay

cd /tmp/ArchEvo_yay/
chown $INPUT_USER_NAME. -R /tmp/ArchEvo_yay

su $INPUT_USER_NAME -c "makepkg"

pacman -U --noconfirm yay-*-x86_64.pkg.tar.zst

cd

rm -rf /tmp/ArchEvo_yay/
