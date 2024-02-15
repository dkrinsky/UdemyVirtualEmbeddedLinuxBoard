#start in top directory (above busybox)
sudo umount mount_rootfs
sudo rm -rf rootfs.ext4
sudo sudo rm -rf mount_rootfs
dd if=/dev/zero of=rootfs.ext4 bs=1M count=128
mkfs.ext4 rootfs.ext4
mkdir -p mount_rootfs
sudo mount rootfs.ext4 mount_rootfs
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
cd ..
sudo umount mount_rootfs