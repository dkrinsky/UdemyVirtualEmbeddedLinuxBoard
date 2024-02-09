bash create_rootfs_ext4.sh
bash set_rootfs_users.sh

#run_kernel_rootfs
qemu-system-arm -M vexpress-a9 -kernel kernel/linux-6.6.11/arch/arm/boot/zImage -dtb kernel/linux-6.6.11/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dtb -append 'console=ttyAMA0,115200 root=/dev/mmcblk0 rw' -nographic -sd rootfs.ext4
