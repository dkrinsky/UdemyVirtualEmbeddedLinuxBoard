
# setup convenient aliases 
. setup_alias.sh

# wget, patch, and build u-boot
# patch updates include/configs/vexpress_common.h to set boot.scr load address
. get_bootloader.sh

# create and display empty sd_card
. create_sd_card.sh
. print_sd_card.sh

# wget and build kernel
. get_kernel.sh

# wget, build,and install busybox
. get_busybox.sh

# create rootfs.ext4 using busybox
# 
. create_rootfs_ext4.sh

# load sd_card FAT partition p1 with kernel, dtb
# load sd_card EXT4 partition p2 with rootfs.ext4
# display sd_card for sanity check

. load_sd_card.sh
. print_sd_card.sh


# make boot.scr (from boot.txt) and add to FAT (boot) parition1 of sd card

mk_bootscr
. add_to_sd_card.sh 1 boot.scr

#run
run_uboot_sdcard


