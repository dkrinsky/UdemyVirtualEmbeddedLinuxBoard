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
