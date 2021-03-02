#!/bin/bash

#Codecs:
#image codecs
pacman -S --noconfirm --needed jasper libwebp

#audio codecs
pacman -S --noconfirm --needed flac wavpack lame libmad opus libvorbis libdca faad2 libfdk-aac

#video codecs
pacman -S --noconfirm --needed ffmpeg gstreamer gst-plugins-base gst-plugins-ugly gst-plugins-good gst-libav libavif libheif aom dav1d rav1e libde265 libdv libmpeg2 libtheora schroedinger libvpx x264 x265 xvidcore libquicktime


#Hardware video acceleration:
#AMD/ATI
if [ "$INPUT_GPU_DRIVER" == "amdgpu" ] || [ "$INPUT_GPU_DRIVER" == "ati" ]; then
    pacman -S --noconfirm --needed libva-mesa-driver mesa-vdpau
fi

#Intel
if [ "$INPUT_GPU_DRIVER" == "intel" ]; then
    pacman -S --noconfirm --needed libva-intel-driver intel-media-driver gstreamer-vaapi
fi

#NVIDIA (opensource)
if [ "$INPUT_GPU_DRIVER" == "nouveau" ]; then
    pacman -S --noconfirm --needed libva-mesa-driver mesa-vdpau
fi

#NVIDIA (closesource)
if [ "$INPUT_GPU_DRIVER" == "nvidia" ] || [ "$INPUT_GPU_DRIVER" == "nvidia-lts" ]; then
    pacman -S --noconfirm --needed nvidia-utils gst-plugins-bad 
fi
