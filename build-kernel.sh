#!/bin/bash
source $HOME/vszero-build/build.conf
cd $KERNELDIR
touch .scmversion
echo "Cleaning and preparing .config"
make clean
make $KERNEL_DEFCONFIG
make menuconfig
cp .config.old arch/arm/configs/$KERNEL_DEFCONFIG.old
cp .config arch/arm/configs/$KERNEL_DEFCONFIG
echo "Compiling dts, kernel and modules"
make -j8
echo "Saving to voltastream0 platform folder"
rm -r $DESTDIR/vszero/lib
make modules_install ARCH=arm INSTALL_MOD_PATH=$DESTDIR/vszero/
make firmware_install ARCH=arm INSTALL_FW_PATH=$DESTDIR/vszero/lib/firmware
cp arch/arm/boot/zImage $DESTDIR/vszero/boot/
cp arch/arm/boot/dts/$KERNEL_DTB $DESTDIR/vszero/boot/$KERNEL_DTB
kver=`make kernelrelease`-`date +%Y.%m.%d-%H.%M`
rm $DESTDIR/vszero/boot/config*
cp .config $DESTDIR/vszero/boot/config-${kver}
cp .config $DESTDIR/vszero/config-${kver}
echo "Compressing voltastream0 platform files"
cd $DESTDIR
tar cvfJ vszero.tar.xz ./vszero
echo "Done"
