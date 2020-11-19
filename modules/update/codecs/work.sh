#!/bin/bash

#Codecs:
#image codecs
pacman -Sy --noconfirm jasper libwebp

#audio codecs
pacman -Sy --noconfirm flac wavpack lame libmad opus libvorbis libdca faad2 libfdk-aac

#video codecs
pacman -Sy --noconfirm ffmpeg gstreamer gst-plugins-good gst-libav libavif libheif aom dav1d rav1e libde265 libdv libmpeg2 libtheora schroedinger libvpx x264 x265 xvidcore


#Hardware video acceleration:
#AMD/ATI
if [ "$INPUT_GPU_DRIVER" == "amdgpu" ] || [ "$INPUT_GPU_DRIVER" == "ati" ]; then
    pacman -Sy --noconfirm libva-mesa-driver mesa-vdpau
fi

#Intel
if [ "$INPUT_GPU_DRIVER" == "intel" ]; then
    pacman -Sy --noconfirm libva-intel-driver intel-media-driver gstreamer-vaapi
fi

#NVIDIA (opensource)
if [ "$INPUT_GPU_DRIVER" == "nouveau" ]; then
    pacman -Sy --noconfirm libva-mesa-driver mesa-vdpau
fi

#NVIDIA (closesource)
if [ "$INPUT_GPU_DRIVER" == "nvidia" ] || [ "$INPUT_GPU_DRIVER" == "nvidia-lts" ]; then
    pacman -Sy --noconfirm nvidia-utils
fi
