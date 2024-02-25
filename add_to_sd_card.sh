#!/usr/bin/bash


# add_to_sd_card.sh
#
# $1 - partition number, 1:boot, 2:rootfs
# $2 - file to add to partition

# losetup provides access to the sdcard partition for formatting
# NOTE: we are NOT going to load the uboot image onto the sdcard
# rather, we format the boot partition so it can store the uboot.env
# and other data
ld=$(sudo losetup -f --show --partscan sdcard.img)
echo ${ld}
partition=${ld}"p"$1
echo ${partition}

sudo mkdir -p mount

if [ "$1" -eq 1 ]; then
   echo "add $2 to boot partition"
fi
if [ "$1" -eq 2 ]; then
   echo "add $2 to rootfs partition"
fi

if [ -f $2 ]; then
  sudo mount ${partition} mount
  sudo cp $2 mount
  sync
  sudo umount mount
else
  echo "no such file $2"
fi

sync
sudo losetup -d ${ld}
