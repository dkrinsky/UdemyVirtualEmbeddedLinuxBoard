mkdir -p kernel
cd kernel
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.11.tar.xz
tar xvf linux-6.6.11.tar.xz
cd linux-6.6.11

export ARCH=arm
export CROSS_COMPILE=arm-linux-
# no additional menuconfig changes are required,
#so just use checked in defconfig
make vexpress_defconfig
make

cd ../../

