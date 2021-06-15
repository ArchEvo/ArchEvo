#!/bin/bash

pacman -Sy
pacman -S --noconfirm --needed archlinux-keyring haveged pacman-contrib
systemctl start haveged
systemctl enable haveged
systemctl enable paccache.timer

for i in {12..01}
do
  clear
  echo -n "Please wait $i seconds. Entropy is created."
  sleep 1
done

rm -fr /etc/pacman.d/gnupg

pacman-key --init
pacman-key --populate archlinux
#pacman-key --refresh-keys --keyserver hkp://pool.sks-keyservers.net


#config
sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#CheckSpace/CheckSpace/' /etc/pacman.conf
sed -i 's/#TotalDownload/TotalDownload/' /etc/pacman.conf
