#!/bin/bash
source ./build.conf
cd $HOME
echo "Cloning voltastream zero linux repo"
git clone https://github.com/PolyVection/linux-imx --depth 1 --branch imx_4.1.15_2.1.0_ga_PV
echo "Cloning voltastream zero u-boot repo"
git clone https://github.com/PolyVection/u-boot --depth 1 --branch v2017.05_PV
cd $UBOOT_DIR
sed -i "s/CONFIG_VOLTASTREAM0_4G=y/# CONFIG_VOLTASTREAM0_4G not set/g" configs/$UBOOT_DEFCONFIG
sed -i "s/# CONFIG_VOLTASTREAM0_8G is not set/CONFIG_VOLTASTREAM0_8G=y/g" configs/$UBOOT_DEFCONFIG
cd $HOME
echo "Cloning volumio build repo"
git clone http://github.com/volumio/Build volumio-build
echo "Moving default platform files into volumio-build"
cd vszero-build
cp -r platform-pv/ ../volumio-build
echo "Done..."
