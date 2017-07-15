### voltastream0-build
Scripts to help build your own Voltastream Zero image.       
This build set targets developers.  
#### Note  

These scripts use, but are not part of the Volumio 2 Build and platform repo.  

#### Prerequisites

```
git squashfs-tools kpartx multistrap qemu-user-static samba debootstrap parted dosfstools qemu binfmt-support qemu-utils
```

It is recommended, not a necessity, to use Debian Jessie 8 (as that's what we are building for).  
If on Ubuntu, you may need to remove `$forceyes` from line 989 of /usr/sbin/multistrap  

### How to
#### Prepare
- clone the help scripts repo to $HOME  :  
git clone http://github.com/gkkpch/voltastream0-build  $HOME/vszero-build
- go to $HOME/vszero-build, type
```
./infrainit.sh  
```
This will  
- clone the voltastream0 kernel repo to $HOME/linux-imx-pv  
- clone the official Volumio 2 build repo to $HOME/volumio-build  
- place the default platform-pv files into the volumio-build folder

#### Build the platform files, only needed the first time (except when you changed kernel or uboot)   
- go to $HOME/vszero-build to start the kernel build, type:    

```
./build-uboot.sh
./build-kernel.sh  	
```

This will create the kenel and uboot, picked up by the volumio build process in the next steps  
(When building the kernel and you need no config changes, just exit menuconfig).

#### Build voltastream zero Image
- goto $HOME/volumio-build and type:   

```
sudo ./build.sh -b arm -d voltastream0 -v -<anything to identify>
```

You can do it separate, rootfs first and then the image:    

```
sudo ./build.sh -b arm  
sudo ./build.sh -d voltastream0 -v -<anything to identify>   
```

Once you built the arm rootfs, there is no need to repeat this (unless volumio has changed).  
For subsequent image builds, just do:  

```
sudo ./build.sh -d voltastream0 -v -<anything to identify>
```
