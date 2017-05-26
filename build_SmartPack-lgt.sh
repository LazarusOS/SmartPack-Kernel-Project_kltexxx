#!/bin/bash

# SmartPack Kernel Build Script
#
# (c) sunilpaulmathew@xda-developers.com

export ARCH=arm
export CROSS_COMPILE=/home/sunil/arm-linux-androideabi-4.9-linaro/bin/arm-linux-androideabi-

mkdir output_lgt

# building Smartpack kernel for kltelgt

make -C $(pwd) O=output_lgt msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_lgt_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -C $(pwd) O=output_lgt

# copying zImage to anykernel directory

cp output_lgt/arch/arm/boot/zImage anykernel_SmartPack/

# generating recovery flashable zip file

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_kltelgt_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_kltelgt_$(date +"%Y%m%d").zip && cd ..

# cleaning...

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack/ && rm -r output_*

# everything done... please visit "release_SmartPack"...
