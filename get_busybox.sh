mkdir -p busybox
rm -rf busybox
mkdir -p busybox

cd busybox
wget https://busybox.net/downloads/busybox-1.36.0.tar.bz2
tar xvf busybox-1.36.0.tar.bz2
cd busybox-1.36.0

# there is no make savedefconfig support in busybox
# therefore, the .config file generated from the make menuconfig
# (e.g. disables IPV6) is checked into the project directly.
# using make defconfig will undo some required make menuconfig commands
# and cause compile errors.
# bottom line: just make using checked in .config

git restore .config

CROSS_COMPILE=arm-linux- make

cd ../../



