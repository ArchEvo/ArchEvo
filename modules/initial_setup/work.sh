#!/bin/bash

#remove partiton
sgdisk --zap-all /dev/sda
#create partiton
sgdisk --new=1:0:+488MB --typecode=1:ef00 --change-name=1:'EFI' /dev/sda 
sgdisk --new=2:0:0 --typecode=2:8300 --change-name=2:'cryptroot' /dev/sda
# 488 MIB = 512 MB; sgdisk makes all information in MIB


#create filesystem boot/efi
mkfs.vfat -F 32 -n EFI /dev/sda1
#create crypt luks
echo -n "password" | cryptsetup -q --key-size 512 --hash sha512 --use-random --type luks1 luksFormat /dev/sda2 -

#open crypt filesystem
echo "password" |  cryptsetup luksOpen /dev/sda2 cryptroot -
#create btrfs on luks
mkfs.btrfs /dev/mapper/cryptroot

#mount btrfs
mount /dev/mapper/cryptroot /mnt

#create subvol
btrfs sub create /mnt/@root
btrfs sub create /mnt/@home
btrfs sub create /mnt/@swap
btrfs sub create /mnt/@snapshots

#umount
umount /mnt

#mount subvol
mount -o compress=zstd,space_cache=v2,ssd,noatime,commit=60,subvol=@root /dev/mapper/cryptroot /mnt

mkdir /mnt/{home,.snapshots,swap}

mount -o compress=zstd,space_cache=v2,ssd,noatime,commit=60,subvol=@home /dev/mapper/cryptroot /mnt/home/
mount -o ssd,noatime,subvol=@swap /dev/mapper/cryptroot /mnt/swap/
mount -o compress=zstd,space_cache=v2,ssd,noatime,commit=60,subvol=@snapshots /dev/mapper/cryptroot /mnt/.snapshots/

#mount efi
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

# install init system
pacstrap /mnt base linux linux-firmware grub btrfs-progs efibootmgr lzop zstd cryptsetup git bash-completion vim amd-ucode intel-ucode reflector

# create fstab
genfstab -U /mnt >> /mnt/etc/fstab

# conig new system
echo "ArchEvo" > /mnt/etc/hostname
echo LANG=de_DE.UTF-8 > /mnt/etc/locale.conf
echo -e "en_US.UTF-8 UTF-8\nde_DE.UTF-8 UTF-8" > /mnt/etc/locale.gen
echo KEYMAP=de-latin1 > /mnt/etc/vconsole.conf
echo FONT=lat9w-16 >> /mnt/etc/vconsole.conf

# reflector: get fastest arch linux archive server; https only
arch-chroot /mnt/ reflector -c Germany -a 2 -p https --sort rate --save /etc/pacman.d/mirrorlist

ln -sf /mnt/usr/share/zoneinfo/Europe/Berlin /mnt/etc/localtime

arch-chroot /mnt/ locale-gen
arch-chroot /mnt/ mkinitcpio -p linux

# root passwd
echo "root:password" | arch-chroot /mnt chpasswd

# add user
arch-chroot /mnt useradd -m -g users -G wheel user

# user passwd
echo "user:password" | arch-chroot /mnt chpasswd

#grub edit
uuid_sda2=$(blkid -s UUID -o value /dev/sda2)

#remove line
sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/d' /mnt/etc/default/grub
sed -i '/GRUB_CMDLINE_LINUX=/d' /mnt/etc/default/grub
sed -i '/GRUB_ENABLE_CRYPTODISK=y/d' /mnt/etc/default/grub

#add line
echo 'GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"' >> /mnt/etc/default/grub
echo "GRUB_ENABLE_CRYPTODISK=y" >> /mnt/etc/default/grub
echo "GRUB_CMDLINE_LINUX=cryptdevice=UUID=$uuid_sda2:cryptroot" >> /mnt/etc/default/grub

# grub config gen
arch-chroot /mnt/ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch-crypt
arch-chroot /mnt/ grub-mkconfig -o /boot/grub/grub.cfg

# add grub keyfile
arch-chroot /mnt/ dd bs=512 count=4 if=/dev/random of=/crypto_keyfile.bin iflag=fullblock
chmod 600 /mnt/crypto_keyfile.bin 
chmod 600 /mnt/boot/initramfs-linux*
echo -n "password" | cryptsetup luksAddKey /dev/sda2 /mnt/crypto_keyfile.bin -

#overwrite mkinitcpio.conf
echo 'MODULES=()
BINARIES=(/usr/bin/btrfs)
FILES=(/crypto_keyfile.bin)
HOOKS="base udev autodetect modconf block btrfs keyboard keymap consolefont encrypt filesystems"

COMPRESSION="zstd"' > /mnt/etc/mkinitcpio.conf

arch-chroot /mnt/ mkinitcpio -p linux


#swapfile
arch-chroot /mnt/ truncate -s 0 /swap/swapfile
arch-chroot /mnt/ chattr +C /swap/swapfile
arch-chroot /mnt/ btrfs property set /swap/swapfile compression none

arch-chroot /mnt/ dd if=/dev/zero of=/swap/swapfile bs=1G count=4 status=progress
arch-chroot /mnt/ chmod 600 /swap/swapfile
arch-chroot /mnt/ mkswap /swap/swapfile
arch-chroot /mnt/ swapon /swap/swapfile
echo "/swap/swapfile none swap defaults 0 0" >> /mnt/etc/fstab

arch-chroot /mnt/ mkdir -p /opt/ArchEvo
arch-chroot /mnt/ git clone https://github.com/ArchEvo/ArchEvo.git /opt/ArchEvo



arch-chroot /mnt/ sync

# only for debug
arch-chroot /mnt/ pacman -Sy dhcpcd htop --noconfirm
