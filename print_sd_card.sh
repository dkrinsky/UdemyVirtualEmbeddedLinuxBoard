# use fdisk print to show sdcard partitions
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk sdcard.img
  p # print the in-memory partition table
  q # and we're done
EOF
