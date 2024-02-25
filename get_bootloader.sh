mkdir -p bootloader
cd bootloader
wget https://ftp.denx.de/pub/u-boot/u-boot-2023.10.tar.bz2

tar xvf u-boot-2023.10.tar.bz2
cd u-boot-2023.10

export ARCH=arm
export CROSS_COMPILE=arm-linux-
make udemy_qemu_vm_defconfig
make

cd ../../
