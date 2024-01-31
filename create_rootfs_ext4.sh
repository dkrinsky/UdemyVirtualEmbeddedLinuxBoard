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
cd ..
sudo umount mount_rootfs
