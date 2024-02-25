#!/usr/bin/bash


# rm_from_sd_card.sh
#
# $1 - partition number, 1:boot, 2:rootfs
# $2 - file to remove from partition

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
   echo "remove $2 from boot partition"
fi
if [ "$1" -eq 2 ]; then
   echo "remove $2 from rootfs partition"
fi

sudo mount ${partition} mount
if [ -f mount/$2 ]; then

  sudo rm mount/$2
  sync
else
  echo "no such file $2"
fi
sudo umount mount

sync
sudo losetup -d ${ld}
