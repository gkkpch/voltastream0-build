#!/bin/bash
source ./build.conf
cd $HOME
echo "Cloning voltastream zero linux repo"
git clone https://github.com/PolyVection/linux-imx --depth 1 --branch imx_4.1.15_2.1.0_ga_PV
echo "Copying initial config"
echo "Note: you must (re-)configure options, especially wifi drivers!)"
echo "TODO (Gé): will fix this as soon as we have a running image"
echo "^^^^^^^^^"
cp platform-pv/vszero/initial-kernel-config/imx_v7_PV_defconfig $KERNELDIR/arch/arm/configs
echo "Cloning voltastream zero u-boot repo"
git clone https://github.com/PolyVection/u-boot --depth 1 --branch v2017.05_PV
cd $UBOOTDIR
echo "Patching u-boot env vars"
patch -p1 < $TOOLDIR/platform-pv/vszero/patches/u-boot-env-vars-volumio.patch
cd $HOME
echo "Cloning volumio build repo"
git clone http://github.com/volumio/Build volumio-build
echo "Moving default platform files into volumio-build"
cd vszero-build
cp -r platform-pv/ ../volumio-build
echo "Done..."
