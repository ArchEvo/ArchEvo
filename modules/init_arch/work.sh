#!/bin/bash

#create partiton
sgdisk --zap-all /dev/sda
sgdisk --new=1:0:+512MB --typecode=1:ef00 --change-name=1:EFI /dev/sda
sgdisk --new=2:0:0 --typecode=2:8300 --change-name=2:cryptroot /dev/sda

#create filesystem
mkfs.vfat -F 32 -n ESP /dev/sda1
echo -n "Password" | cryptsetup -q --key-size 512 --hash sha512 --use-random --type luks1 luksFormat /dev/sda2 -

#open crypt filesystem
echo "Password" |  cryptsetup luksOpen /dev/sda2 cryptroot -
mkfs.btrfs /dev/mapper/cryptroot

#mount 
mount /dev/mapper/cryptroot /mnt

#create subvol
btrfs sub create /mnt/@
btrfs sub create /mnt/@home
btrfs sub create /mnt/@snapshots

#umount
umount /mnt

#mount subvol
mount -o compress=lzo,space_cache,ssd,noatime,commit=120,subvol=@ /dev/mapper/cryptroot /mnt
mkdir -p /mnt/home
mkdir -p /mnt/.snapshots
mount -o compress=lzo,space_cache,ssd,noatime,commit=120,subvol=@home /dev/mapper/cryptroot /mnt/home/
mount -o compress=lzo,space_cache,ssd,noatime,commit=120,subvol=@snapshots /dev/mapper/cryptroot /mnt/.snapshots/

#mount efi
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

# install init system
pacstrap /mnt base base-devel linux linux-firmware linux-headers grub btrfs-progs dosfstools efibootmgr bash-completion vim nano cryptsetup dialog

# create fstab
genfstab -U /mnt >> /mnt/etc/fstab

# conig new system
echo "test" > /mnt/etc/hostname
echo LANG=de_DE.UTF-8 > /mnt/etc/locale.conf
echo -e "en_US.UTF-8 UTF-8\nde_DE.UTF-8 UTF-8" > /mnt/etc/locale.gen
echo KEYMAP=de-latin1 > /mnt/etc/vconsole.conf
echo FONT=lat9w-16 >> /mnt/etc/vconsole.conf

ln -sf /mnt/usr/share/zoneinfo/Europe/Berlin /mnt/etc/localtime

arch-chroot /mnt/ locale-gen
arch-chroot /mnt/ mkinitcpio -p linux

# passwd
arch-chroot /mnt/ echo "root:password" | chpasswd

#grub edit
uuid_sda2=$(blkid -s UUID -o value /dev/sda2)

#remove line
sed -i '/GRUB_CMDLINE_LINUX=/d' /mnt/etc/default/grub
sed -i '/GRUB_ENABLE_CRYPTODISK=y/d' /mnt/etc/default/grub

#add line
echo "GRUB_ENABLE_CRYPTODISK=y" >> /mnt/etc/default/grub
echo "GRUB_CMDLINE_LINUX=cryptdevice=UUID=$uuid_sda2:cryptroot" >> /mnt/etc/default/grub

# grub config gen
arch-chroot /mnt/ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch-crypt
arch-chroot /mnt/ grub-mkconfig -o /boot/grub/grub.cfg

# add grub keyfile
arch-chroot /mnt/ dd bs=512 count=4 if=/dev/random of=/crypto_keyfile.bin iflag=fullblock
chmod 600 /mnt/crypto_keyfile.bin 
chmod 600 /mnt/boot/initramfs-linux*
echo -n "Password" | cryptsetup luksAddKey /dev/sda2 /mnt/crypto_keyfile.bin -

#overwrite mkinitcpio.conf
echo 'MODULES=()
BINARIES=(/usr/bin/btrfs)
FILES=(/crypto_keyfile.bin)
HOOKS="base udev autodetect modconf block keyboard keymap encrypt filesystems"

COMPRESSION="lzop"' > /mnt/etc/mkinitcpio.conf

arch-chroot /mnt/ mkinitcpio -p linux


# only for debug
arch-chroot /mnt/ pacman -Sy dhcpcd

