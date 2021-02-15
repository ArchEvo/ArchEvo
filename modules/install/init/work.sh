#!/bin/bash

#remove partiton
sgdisk --zap-all "/dev/$INPUT_INSTALL_DRIVE"
#create partiton
sgdisk --new=1:0:+488MB --typecode=1:ef00 --change-name=1:'EFI' "/dev/$INPUT_INSTALL_DRIVE"
sgdisk --new=2:0:0 --typecode=2:8300 --change-name=2:'cryptroot' "/dev/$INPUT_INSTALL_DRIVE"
# 488 MIB = 512 MB; sgdisk makes all information in MIB


#create filesystem boot/efi
mkfs.vfat -F 32 -n EFI "/dev/$( echo $INPUT_INSTALL_DRIVE)1"
#create crypt luks
echo -n "$INPUT_LUKS_PASSWORD" | cryptsetup -q --cipher aes-xts-plain64 --iter-time 3000 --key-size 512 --hash sha512 --use-random --type luks1 luksFormat "/dev/$( echo $INPUT_INSTALL_DRIVE)2" -

#open crypt filesystem
echo "$INPUT_LUKS_PASSWORD" |  cryptsetup luksOpen "/dev/$( echo $INPUT_INSTALL_DRIVE)2" cryptroot -
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
mount -o compress=zstd,space_cache=v2,ssd,noatime,discard=async,commit=60,subvol=@root /dev/mapper/cryptroot /mnt

mkdir /mnt/{home,.snapshots,swap}

mount -o compress=zstd,space_cache=v2,ssd,noatime,discard=async,commit=60,subvol=@home /dev/mapper/cryptroot /mnt/home/
mount -o ssd,noatime,subvol=@swap /dev/mapper/cryptroot /mnt/swap/
mount -o compress=zstd,space_cache=v2,ssd,noatime,discard=async,commit=60,subvol=@snapshots /dev/mapper/cryptroot /mnt/.snapshots/

#mount efi
mkdir -p /mnt/boot/efi
mount "/dev/$( echo $INPUT_INSTALL_DRIVE)1" /mnt/boot/efi

# install init system
pacstrap /mnt base $INPUT_LINUX_VERSION $( echo $INPUT_LINUX_VERSION)-headers linux-firmware grub btrfs-progs efibootmgr lzop zstd cryptsetup git bash-completion vim reflector

# create fstab
genfstab -U /mnt >> /mnt/etc/fstab

# add ramdisk for tmp
echo "tmpfs   /tmp            tmpfs   rw       0       0
tmpfs   /var/tmp        tmpfs   rw      0        0" >> /mnt/etc/fstab

# conig new system
echo "KEYMAP=$INPUT_VCONSOLE_KEYMAP" > /mnt/etc/vconsole.conf
echo "FONT=lat2-16" >> /mnt/etc/vconsole.conf
echo "FONT_MAP=8859-2" >> /mnt/etc/vconsole.conf
echo $INPUT_HOSTNAME > /mnt/etc/hostname
echo "$INPUT_LOCALE.UTF-8 UTF-8" >> /mnt/etc/locale.gen
echo "LANG=$INPUT_LOCALE.UTF-8 
LANGUAGE=$INPUT_LOCALE
LC_TIME=$INPUT_LOCALE.UTF-8
LC_MONETARY=$INPUT_LOCALE.UTF-8
LC_NUMERIC=$INPUT_LOCALE.UTF-8
LC_CTYPE=$INPUT_LOCALE.UTF-8
LC_MESSAGES=$INPUT_LOCALE.UTF-8
LC_PAPER=$INPUT_LOCALE.UTF-8
LC_MEASUREMENT=$INPUT_LOCALE.UTF-8
LC_NAME=$INPUT_LOCALE.UTF-8
LC_ADDRESS=$INPUT_LOCALE.UTF-8
LC_TELEPHONE=$INPUT_LOCALE.UTF-8
LC_IDENTIFICATION=$INPUT_LOCALE.UTF-8
"> /mnt/etc/locale.conf

# reflector: get fastest arch linux archive server; https only
reflector --verbose -l 10 -a 12 --score 50 --sort rate -p https --country "$INPUT_REFLECTOR_COUNTRY"  --save /etc/pacman.d/mirrorlist
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

ln -sf "/mnt/usr/share/zoneinfo/$INPUT_TIMEZONE_CONTINENT/$INPUT_TIMEZONE_CITY" /mnt/etc/localtime

arch-chroot /mnt/ locale-gen

# root passwd
echo "root:$INPUT_ROOT_PASSWORD" | arch-chroot /mnt chpasswd

# add user
arch-chroot /mnt useradd -m -g users -G wheel $INPUT_USER_NAME

# user passwd
echo "$INPUT_USER_NAME:$INPUT_USER_PASSWORD" | arch-chroot /mnt chpasswd

#grub edit
uuid_drive_part2=$(blkid -s UUID -o value "/dev/$( echo $INPUT_INSTALL_DRIVE)2")


#replace grub config
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"/' /mnt/etc/default/grub
sed -i 's/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=cryptdevice=UUID='$uuid_drive_part2':cryptroot/' /mnt/etc/default/grub
sed -i 's/#GRUB_ENABLE_CRYPTODISK=.*/GRUB_ENABLE_CRYPTODISK=y/' /mnt/etc/default/grub
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=2/' /mnt/etc/default/grub 


# grub config gen
arch-chroot /mnt/ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch-crypt
arch-chroot /mnt/ grub-mkconfig -o /boot/grub/grub.cfg

# add grub keyfile
arch-chroot /mnt/ dd bs=512 count=4 if=/dev/random of=/crypto_keyfile.bin iflag=fullblock
chmod 600 /mnt/crypto_keyfile.bin 
chmod 600 /mnt/boot/initramfs-linux*
echo -n "$INPUT_LUKS_PASSWORD" | cryptsetup luksAddKey "/dev/$( echo $INPUT_INSTALL_DRIVE)2" /mnt/crypto_keyfile.bin -


#replace mkinitcpio.conf
sed -i 's/BINARIES=()/BINARIES=(\/usr\/bin\/btrfs)/' /mnt/etc/mkinitcpio.conf
sed -i 's/FILES=()/FILES=(\/crypto_keyfile.bin)/' /mnt/etc/mkinitcpio.conf
sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block keyboard keymap consolefont encrypt filesystems)/' /mnt/etc/mkinitcpio.conf
sed -i 's/MODULES=()/MODULES=(crc32c-intel)/' /mnt/etc/mkinitcpio.conf
sed -i 's/#COMPRESSION="zstd"/COMPRESSION="zstd"/' /mnt/etc/mkinitcpio.conf


arch-chroot /mnt/ mkinitcpio -p $INPUT_LINUX_VERSION

echo '127.0.0.1	localhost $INPUT_HOSTNAME.localdomain $INPUT_HOSTNAME' >> /mnt/etc/hosts
echo '::1	localhost' >> /mnt/etc/hosts

#swapfile
if [ $INPUT_SWAP_SIZE != 0 ]; then
    arch-chroot /mnt/ truncate -s 0 /swap/swapfile
    arch-chroot /mnt/ chattr +C /swap/swapfile
    arch-chroot /mnt/ btrfs property set /swap/swapfile compression none

    arch-chroot /mnt/ dd if=/dev/zero of=/swap/swapfile bs=1G count=$INPUT_SWAP_SIZE status=progress
    arch-chroot /mnt/ chmod 600 /swap/swapfile
    arch-chroot /mnt/ mkswap /swap/swapfile
    arch-chroot /mnt/ swapon /swap/swapfile
    echo "/swap/swapfile none swap defaults 0 0" >> /mnt/etc/fstab
fi

arch-chroot /mnt/ mkdir -p /opt/ArchEvo
arch-chroot /mnt/ git clone https://github.com/ArchEvo/ArchEvo.git /opt/ArchEvo

cp -r /opt/ArchEvoConf /mnt/opt/ArchEvoConf

arch-chroot /mnt/ sync
