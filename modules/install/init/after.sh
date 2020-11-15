#!/bin/bash

sync
umount /mnt/boot/efi
umount /mnt/home
umount /mnt/.snapshots
umount /mnt/swap  
umount /mnt        
cryptsetup luksClose cryptroot

echo -e "\e[31mThe installation was successful.\e[39m"
echo -e "\e[31mATTENTION: THE SCRIPT IS STILL IN DEVELOPMENT\e[39m"
