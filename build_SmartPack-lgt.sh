#!/bin/bash

# SmartPack Kernel Build Script
#
# (c) sunilpaulmathew@xda-developers.com

export ARCH=arm
export CROSS_COMPILE=/home/sunil/arm-linux-androideabi-4.9-linaro/bin/arm-linux-androideabi-

mkdir output_lgt

echo -e $COLOR_GREEN"\n building Smartpack kernel for kltelgt\n"$COLOR_NEUTRAL

make -C $(pwd) O=output_lgt msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_lgt_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -C $(pwd) O=output_lgt

echo -e $COLOR_GREEN"\n copying zImage to anykernel directory\n"$COLOR_NEUTRAL

cp output_lgt/arch/arm/boot/zImage anykernel_SmartPack/

echo -e $COLOR_GREEN"\n generating recovery flashable zip file\n"$COLOR_NEUTRAL

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_kltelgt_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_kltelgt_$(date +"%Y%m%d").zip && cd ..

echo -e $COLOR_GREEN"\n cleaning...\n"$COLOR_NEUTRAL

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

echo -e $COLOR_GREEN"\n everything done... please visit "release_SmartPack"...\n"$COLOR_NEUTRAL
