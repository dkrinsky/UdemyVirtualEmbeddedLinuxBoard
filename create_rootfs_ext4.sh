#!/usr/bin/bash

echo "create_rootfs_ext4.sh"
bash check_mounts.sh

#start in top directory (above busybox)
sudo umount mount_rootfs
sync
sudo rm -rf rootfs.ext4
sudo rm -rf mount_rootfs
dd if=/dev/zero of=rootfs.ext4 bs=1M count=128
mkfs.ext4 rootfs.ext4
mkdir -p mount_rootfs
sudo mount rootfs.ext4 mount_rootfs
sync
cd mount_rootfs
sudo cp -r ../busybox/rootfs/* ./
sudo mkdir -p dev
sudo mknod dev/tty1 c 4 1  
sudo mknod dev/tty2 c 4 2  
sudo mknod dev/tty3 c 4 3  
sudo mknod dev/tty4 c 4 4
sudo mknod -m 666 dev/null c 1 3
sudo mknod -m 600 dev/console c 5 1
# create proc,sys,etc directories
sudo mkdir -p proc
sudo mkdir -p sys
sudo mkdir -p etc
sudo mkdir -p etc/init.d
sudo cp -r ../rcS etc/init.d
sudo chmod +x etc/init.d/rcS
sudo cp -r ../inittab etc/
sudo cp -r ../profile etc/
sudo mkdir -p etc/network
sudo cp -r ../interfaces etc/network
sync

# create initramfs for optional runs not using rootfs
if [ -f "../initramfs.cpio" ]; then
   echo "delete initramfs.cpio"
   sudo rm ../initramfs.cpio
fi
if [ -f "../initramfs.cpio.gz" ]; then
   echo "delete initramfs.cpio.gz"
   sudo rm ../initramfs.cpio.gz
fi

find . | cpio -H newc -ov --owner root:root > ../initramfs.cpio
cd ..
gzip initramfs.cpio
sudo umount mount_rootfs
sync
# create users
bash set_rootfs_users.sh passwd
sync

bash check_mounts.sh
echo "create_rootfs_ext4.sh DONE"

