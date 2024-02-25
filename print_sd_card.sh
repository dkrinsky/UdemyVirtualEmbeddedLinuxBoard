# use fdisk print to show sdcard partitions
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk sdcard.img
  p # print the in-memory partition table
  q # and we're done
EOF


# losetup provides access to the sdcard partition for formatting
# NOTE: we are NOT going to load the uboot image onto the sdcard
# rather, we format the boot partition so it can store the uboot.env
# and other data
ld=$(sudo losetup -f --show --partscan sdcard.img)
echo ${ld}

boot_partition=${ld}"p1"
rootfs_partition=${ld}"p2"

mkdir -p mount

echo "ls boot partition"${boot_partition}
sudo mount ${boot_partition} mount
sudo ls -l mount
sync
sudo umount mount

echo "ls rootfs partition "${rootfs_partition}
sudo mount ${rootfs_partition} mount
sudo ls -l mount
sync
sudo umount mount
sync
sudo losetup -d ${ld}
