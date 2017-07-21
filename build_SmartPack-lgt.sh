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

# creating backups

cp scripts/mkcompile_h release_SmartPack/

# updating kernel name

sed "s/\`echo \$LINUX_COMPILE_BY | \$UTS_TRUNCATE\`/SmartPack-Kernel-kltelgt-[sunilpaulmathew/g" -i scripts/mkcompile_h
sed "s/\`echo \$LINUX_COMPILE_HOST | \$UTS_TRUNCATE\`/xda-developers.com]/g" -i scripts/mkcompile_h

mkdir output_lgt

echo -e $COLOR_GREEN"\n building Smartpack kernel for kltelgt\n"$COLOR_NEUTRAL

make -C $(pwd) O=output_lgt msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_lgt_defconfig SELINUX_DEFCONFIG=selinux_defconfig && make -j$NUM_CPUS -C $(pwd) O=output_lgt

echo -e $COLOR_GREEN"\n copying zImage to anykernel directory\n"$COLOR_NEUTRAL

cp output_lgt/arch/arm/boot/zImage anykernel_SmartPack/

echo -e $COLOR_GREEN"\n generating recovery flashable zip file\n"$COLOR_NEUTRAL

cd anykernel_SmartPack/ && zip -r9 SmartPack_kernel_kltelgt_$(date +"%Y%m%d").zip * -x README SmartPack_kernel_kltelgt_$(date +"%Y%m%d").zip && cd ..

echo -e $COLOR_GREEN"\n cleaning...\n"$COLOR_NEUTRAL

rm anykernel_SmartPack/zImage && mv anykernel_SmartPack/SmartPack_* release_SmartPack/

# restoring backups

mv release_SmartPack/mkcompile_h scripts/

echo -e $COLOR_GREEN"\n everything done... please visit "release_SmartPack"...\n"$COLOR_NEUTRAL
