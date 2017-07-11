#!/bin/bash
source $HOME/vszero-build/build.conf

cd $UBOOTDIR
make mrproper
touch .scmversion
make clean
make $UBOOT_DEFCONFIG
make -j8
cp u-boot-dtb.imx $DESTDIR/vszero/u-boot/

echo "Backup platform files..."
cd $DESTDIR
tar cfvJ vszero.tar.xz ./vszero
echo "Creating platform files completed"

