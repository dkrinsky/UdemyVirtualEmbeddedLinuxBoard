#!/usr/bin/bash

echo "create_sd_card.sh"
bash check_mounts.sh

# create the sdcard.img file, 1G of zeros
dd if=/dev/zero of=sdcard.img bs=1M count=1024

# to create the partitions programatically (rather than manually)
# we're going to simulate the manual input to fdisk
# The sed script strips off all the comments so that we can 
# document what we're doing in-line with the actual commands
# Note that a blank line (commented as "defualt" will send a empty
# line terminated with a newline to take the fdisk default.
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk sdcard.img
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +64M # 64 MB boot parttion
  t # change partition type
  e #   to W95 FAT16 (LBA)
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
  +64M # 64 MB rootfs partition (probably should make it bigger) 
  n # new partition
  p # primary partition
  3 # partion number 3
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  a # make a partition bootable
  1 # bootable partition is partition 1 
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF


# losetup provides access to the sdcard partition for formatting
# NOTE: we are NOT going to load the uboot image onto the sdcard
# rather, we format the boot partition so it can store the uboot.env
# kernel, dtb, and other data
ld=$(sudo losetup -f --show --partscan sdcard.img)
echo ${ld}
boot_partition=${ld}"p1"
echo ${boot_partition}
rootfs_partition=${ld}"p2"
echo ${rootfs_partition}
sudo mkfs.vfat -F 16 -n boot ${boot_partition}
sudo mkfs.ext4 ${rootfs_partition}
sudo losetup -d ${ld}
sync
sync
bash check_mounts.sh
echo "create_sd_card.sh DONE"
