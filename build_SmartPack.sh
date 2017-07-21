#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[1;32m"
COLOR_NEUTRAL="\033[0m"

echo -e $COLOR_GREEN"\n SmartPack Kernel Build Script\n"$COLOR_NEUTRAL
#
echo -e $COLOR_GREEN"\n (c) sunilpaulmathew@xda-developers.com\n"$COLOR_NEUTRAL

TOOLCHAIN="/home/sunil/arm-linux-androideabi-4.9-linaro/bin/arm-linux-androideabi-"
ARCHITECTURE=arm

NUM_CPUS=""   # number of cpu cores used for build (leave empty for auto detection)

export ARCH=$ARCHITECTURE
export CROSS_COMPILE="${CCACHE} $TOOLCHAIN"

if [ -z "$NUM_CPUS" ]; then
	NUM_CPUS=`grep -c ^processor /proc/cpuinfo`
fi

mkdir output_kor output_eur output_duos output_spr output_dv

# creating backups

cp scripts/mkcompile_h release_SmartPack/

# updating kernel name

sed "s/\`echo \$LINUX_COMPILE_BY | \$UTS_TRUNCATE\`/SmartPack-Kernel-kltekor-[sunilpaulmathew/g" -i scripts/mkcompile_h
sed "s/\`echo \$LINUX_COMPILE_HOST | \$UTS_TRUNCATE\`/xda-developers.com]/g" -i scripts/mkcompile_h

echo -e $COLOR_GREEN"\n building Smartpack kernel for kltekor\n"$COLOR_NEUTRAL

make -C $(pwd) O=output_kor msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_kor_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -j$NUM_CPUS -C $(pwd) O=output_kor

echo -e $COLOR_GREEN"\n copying zImage to anykernel directory\n"$COLOR_NEUTRAL

cp output_kor/arch/arm/boot/zImage anykernel_SmartPack/

echo -e $COLOR_GREEN"\n generating recovery flashable zip file\n"$COLOR_NEUTRAL

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_kltekor_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_kltekor_$(date +"%Y%m%d").zip && cd ..

echo -e $COLOR_GREEN"\n cleaning...\n"$COLOR_NEUTRAL

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/dtb release_SmartPack && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

echo -e $COLOR_GREEN"\n building Smartpack kernel for klte\n"$COLOR_NEUTRAL

# updating kernel name

sed -i "s;SmartPack-Kernel-kltekor;SmartPack-Kernel-klte;" scripts/mkcompile_h;

make -C $(pwd) O=output_eur msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_eur_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -j$NUM_CPUS -C $(pwd) O=output_eur

echo -e $COLOR_GREEN"\n copying zImage to anykernel directory\n"$COLOR_NEUTRAL

cp output_eur/arch/arm/boot/zImage anykernel_SmartPack/

echo -e $COLOR_GREEN"\n generating recovery flashable zip file\n"$COLOR_NEUTRAL

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_klte_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_klte_$(date +"%Y%m%d").zip && cd ..

echo -e $COLOR_GREEN"\n cleaning...\n"$COLOR_NEUTRAL

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

echo -e $COLOR_GREEN"\n building Smartpack kernel for klteduos\n"$COLOR_NEUTRAL

# updating kernel name

sed -i "s;SmartPack-Kernel-klte;SmartPack-Kernel-klteduos;" scripts/mkcompile_h;

make -C $(pwd) O=output_duos msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_duos_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -j$NUM_CPUS -C $(pwd) O=output_duos

echo -e $COLOR_GREEN"\n copying zImage to anykernel directory\n"$COLOR_NEUTRAL

cp output_duos/arch/arm/boot/zImage anykernel_SmartPack/

echo -e $COLOR_GREEN"\n generating recovery flashable zip file\n"$COLOR_NEUTRAL

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_klteduos_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_klteduos_$(date +"%Y%m%d").zip && cd ..

echo -e $COLOR_GREEN"\n cleaning...\n"$COLOR_NEUTRAL

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

echo -e $COLOR_GREEN"\n building Smartpack kernel for kltespr\n"$COLOR_NEUTRAL

# updating kernel name

sed -i "s;SmartPack-Kernel-klteduos;SmartPack-Kernel-kltespr;" scripts/mkcompile_h;

make -C $(pwd) O=output_spr msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_spr_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -j$NUM_CPUS -C $(pwd) O=output_spr

echo -e $COLOR_GREEN"\n copying zImage to anykernel directory\n"$COLOR_NEUTRAL

cp output_spr/arch/arm/boot/zImage anykernel_SmartPack/

echo -e $COLOR_GREEN"\n generating recovery flashable zip file\n"$COLOR_NEUTRAL

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_kltespr_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_kltespr_$(date +"%Y%m%d").zip && cd ..

echo -e $COLOR_GREEN"\n cleaning...\n"$COLOR_NEUTRAL

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

echo -e $COLOR_GREEN"\n building Smartpack kernel for kltedv\n"$COLOR_NEUTRAL

# updating kernel name

sed -i "s;SmartPack-Kernel-kltespr;SmartPack-Kernel-kltedv;" scripts/mkcompile_h;

make -C $(pwd) O=output_dv msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_dv_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -j$NUM_CPUS -C $(pwd) O=output_dv

echo -e $COLOR_GREEN"\n copying zImage to anykernel directory\n"$COLOR_NEUTRAL

cp output_dv/arch/arm/boot/zImage anykernel_SmartPack/

echo -e $COLOR_GREEN"\n generating recovery flashable zip file\n"$COLOR_NEUTRAL

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_kltedv_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_kltedv_$(date +"%Y%m%d").zip && cd ..

echo -e $COLOR_GREEN"\n cleaning...\n"$COLOR_NEUTRAL

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack && mv release_SmartPack/dtb anykernel_SmartPack/

# restoring backups

mv release_SmartPack/mkcompile_h scripts/

echo -e $COLOR_GREEN"\n everything done... please visit "release_SmartPack"...\n"$COLOR_NEUTRAL
