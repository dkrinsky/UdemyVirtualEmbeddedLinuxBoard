#!/usr/bin/bash

echo "get_dropbear.sh"

#
# Dropbear
# ------------
# 
# Dropbear is a lightweight SSHd daemon.
# 
# Using our toolchain, we can build a very simple static binary from the dropbear sources that 
# will allow us to SSH into virtual board
# 
# Building From source
# --------------------

mkdir -p dropbear
cd dropbear

wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2022.82.tar.bz2
tar -xvf dropbear-2022.82.tar.bz2
cd dropbear-2022.82

# This prevents the dropbear daemon from blocking due to lack of entropy in the kernel's randomness state
sed -i 's/ getrandom//' configure.ac

autoconf

./configure --host=arm-linux  --disable-zlib --enable-static CC="arm-linux-gcc" LD=arm-linux-ld

make

# Copy this on the target
# 
# Run on target
# --------------
# 
# $ dropbear -p 22 -R -B -a -E
# 
# Fixing issues
# ----------------

# $ mkdir /dev/pts
# $ mount -t devpts -o rw,mode=620,ptmxmode=666 devpts /dev/pts

# ssh command
# -------------
#  $ ssh -o PubkeyAuthentication=no -o PreferredAuthentications=password  -p 22 root@192.168.0.100

# Dropbear security options
# --------------------------
# 
# -w		Disallow root logins
# 
# -G		Restrict logins to members of specified group
# 
# ssh-keygen -t rsa
# -s		Disable password logins
# 
# openssl passwd -crypt
# -g		Disable password logins for root




cd ../../



