#!/bin/bash

# SmartPack Kernel Build Script
#
# (c) sunilpaulmathew@xda-developers.com

export ARCH=arm
export CROSS_COMPILE=/home/sunil/arm-linux-androideabi-4.9-linaro/bin/arm-linux-androideabi-

mkdir output_kor output_eur output_duos output_spr output_dv

# building Smartpack kernel for kltekor

make -C $(pwd) O=output_kor msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_kor_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -C $(pwd) O=output_kor

# copying zImage to anykernel directory

cp output_kor/arch/arm/boot/zImage anykernel_SmartPack/

# generating recovery flashable zip file

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_kltekor_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_kltekor_$(date +"%Y%m%d").zip && cd ..

# cleaning...

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/dtb release_SmartPack && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

# building Smartpack kernel for klte

make -C $(pwd) O=output_eur msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_eur_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -C $(pwd) O=output_eur

# copying zImage to anykernel directory

cp output_eur/arch/arm/boot/zImage anykernel_SmartPack/

# generating recovery flashable zip file

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_klte_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_klte_$(date +"%Y%m%d").zip && cd ..

# cleaning...

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

# building Smartpack kernel for klteduos

make -C $(pwd) O=output_duos msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_duos_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -C $(pwd) O=output_duos

# copying zImage to anykernel directory

cp output_duos/arch/arm/boot/zImage anykernel_SmartPack/

# generating recovery flashable zip file

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_klteduos_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_klteduos_$(date +"%Y%m%d").zip && cd ..

# cleaning...

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

# building Smartpack kernel for kltespr

make -C $(pwd) O=output_spr msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_spr_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -C $(pwd) O=output_spr

# copying zImage to anykernel directory

cp output_spr/arch/arm/boot/zImage anykernel_SmartPack/

# generating recovery flashable zip file

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_kltespr_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_kltespr_$(date +"%Y%m%d").zip && cd ..

# cleaning...

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

# building Smartpack kernel for kltedv

make -C $(pwd) O=output_dv msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_dv_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -C $(pwd) O=output_dv

# copying zImage to anykernel directory

cp output_dv/arch/arm/boot/zImage anykernel_SmartPack/

# generating recovery flashable zip file

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_kltedv_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_kltedv_$(date +"%Y%m%d").zip && cd ..

# cleaning...

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack && mv release_SmartPack/dtb anykernel_SmartPack/ && rm -r output_*

# everything done... please visit "release_SmartPack"...
