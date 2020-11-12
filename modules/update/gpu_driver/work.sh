#!/bin/bash

if [ $INPUT_GPU_DRIVER == intel ];
then
   pacman -Syy --noconfirm xf86-video-intel
fi

if [ $INPUT_GPU_DRIVER == ati ];
then
   pacman -Syy --noconfirm xf86-video-ati
fi

if [ $INPUT_GPU_DRIVER == amdgpu ];
then
   pacman -Syy --noconfirm xf86-video-amdgpu
fi

if [ $INPUT_GPU_DRIVER == nvidia ];
then
   pacman -Syy --noconfirm nvidia
fi

if [ $INPUT_GPU_DRIVER == nouveau ];
then
   pacman -Syy --noconfirm xf86-video-nouveau
fi

if [ $INPUT_GPU_DRIVER == vmware ];
then
   pacman -Syy --noconfirm open-vm-tools
fi

if [ $INPUT_GPU_DRIVER == virtualbox ];
then
   pacman -Syy --noconfirm virtualbox-guest-utils
fi
