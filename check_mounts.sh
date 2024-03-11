#!/usr/bin/bash
#set -e

sleep 1

sudo losetup -a | egrep 'qemu_|sdcard' | tee losetup.out
sudo findmnt | egrep 'qemu_|sdcard' | tee findmnt.out

file=losetup.out
minimumsize=0
actualsize=$(wc -c <"$file")
if [ $actualsize -gt $minimumsize ]; then
    echo ERROR $file size $actualsize is over $minimumsize bytes
fi
file=findmnt.out
minimumsize=0
actualsize=$(wc -c <"$file")
if [ $actualsize -gt $minimumsize ]; then
    echo ERROR $file size $actualsize is over $minimumsize bytes
fi

