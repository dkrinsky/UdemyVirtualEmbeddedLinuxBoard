mkdir -p busybox
cd busybox
wget https://busybox.net/downloads/busybox-1.36.0.tar.bz2
tar xvf busybox-1.36.0.tar.bz2
cd busybox-1.36.0

export ARCH=arm
export CROSS_COMPILE=arm-linux-
make defconfig

#make menuconfig

