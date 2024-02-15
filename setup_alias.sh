

alias get_crosstools="git clone https://github.com/crosstool-ng/crosstool-ng.git; cd crosstool-ng;git checkout crosstool-ng-1.26.0 "
# cd cros
alias make_1gig_sdcard_img="dd if=/dev/zero of=sdcard.img bs=1M count=1024"
alias make_rootfs_ext4="dd if=/dev/zero of=rootfs.ext4 bs=1M count=128"

alias "loop_setup_sdcard"="sudo losetup -f --show --partscan sdcard.img"

alias run_uboot="qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel bootloader/u-boot-2023.10/u-boot"
alias run_uboot_sdcard="qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel bootloader/u-boot-2023.10/u-boot -sd sdcard.img"

alias run_kernel_initrd="qemu-system-arm -M vexpress-a9 -kernel kernel/linux-6.6.11/arch/arm/boot/zImage -dtb kernel/linux-6.6.11/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dtb -append 'console=ttyAMA0,115200 rdinit=/bin/sh' -nographic -initrd busybox/initramfs.cpio.gz"
alias run_kernel_rootfs="qemu-system-arm -M vexpress-a9 -kernel kernel/linux-6.6.11/arch/arm/boot/zImage -dtb kernel/linux-6.6.11/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dtb -append 'console=ttyAMA0,115200 root=/dev/mmcblk0 rw' -nographic -sd rootfs.ext4"
alias run_kernel_rootfs_net="sudo qemu-system-arm -M vexpress-a9 -kernel kernel/linux-6.6.11/arch/arm/boot/zImage -dtb kernel/linux-6.6.11/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dtb -append 'console=ttyAMA0,115200 root=/dev/mmcblk0 rw' -nographic -sd rootfs.ext4 -net tap,script=./qemu-ifup -net nic"
