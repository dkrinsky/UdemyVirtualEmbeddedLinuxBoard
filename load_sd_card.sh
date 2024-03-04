# losetup provides access to the sdcard partition for formatting
# NOTE: we are NOT going to load the uboot image onto the sdcard
# rather, we format the boot partition so it can store the uboot.env
# and other data
ld=$(sudo losetup -f --show --partscan sdcard.img)
echo ${ld}
boot_partition=${ld}"p1"
echo ${boot_partition}
rootfs_partition=${ld}"p2"
echo ${rootfs_partition}

sudo mkdir -p mount
#sudo umount mount
sudo mkdir -p rootfs_mount
#sudo umount rootfs_mount


sudo mount ${boot_partition} mount
sudo cp kernel/linux-6.6.11/arch/arm/boot/zImage mount
sudo cp kernel/linux-6.6.11/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dtb mount
sudo umount mount

sudo mount ${rootfs_partition} mount
sudo mount rootfs.ext4 rootfs_mount
sudo cp -rf rootfs_mount/* mount
sudo umount mount
sudo umount rootfs_mount

sudo losetup -d ${ld}

# make boot.scr (from boot.txt) and add to FAT (boot) parition1 of sd card

mk_bootscr
. add_to_sd_card.sh 1 boot.scr
