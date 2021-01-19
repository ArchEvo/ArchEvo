#!/bin/bash

if [ $INPUT_GPU_DRIVER == intel ];
then
   pacman -S --noconfirm --needed xf86-video-intel
fi

if [ $INPUT_GPU_DRIVER == ati ];
then
   pacman -S --noconfirm --needed xf86-video-ati
fi

if [ $INPUT_GPU_DRIVER == amdgpu ];
then
   pacman -S --noconfirm --needed xf86-video-amdgpu
fi

if [ $INPUT_GPU_DRIVER == nvidia ];
then
   pacman -S --noconfirm --needed nvidia
fi

if [ $INPUT_GPU_DRIVER == nouveau ];
then
   pacman -S --noconfirm --needed xf86-video-nouveau
fi

if [ $INPUT_GPU_DRIVER == vmware ];
then
   pacman -S --noconfirm --needed open-vm-tools
fi

if [ $INPUT_GPU_DRIVER == virtualbox ];
then
   pacman -S --noconfirm --needed virtualbox-guest-utils
fi


pacman -S --noconfirm --needed mesa
