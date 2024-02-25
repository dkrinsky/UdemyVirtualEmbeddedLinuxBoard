# UdemyVirtualEmbeddedLinuxBoard
scripts, logs, etc. related to the Udemy Virtual Embedded Linux Board course


1. setup_alias.sh
   creates convenient aliases for running qemu, creating/printing the sdcard image, etc.

2. get_bootloader.sh
   retrieves and builds u-boot.  uses the checked in udemy_qemu_vm_defconfig to create the .config (avoids make menuconfig requirement).
   after get_bootloader is called, the run_uboot alias can be used to run uboot but without any FAT partition, so there is not much to see.

alias run_uboot="qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel bootloader/u-boot-2023.10/u-boot"

U-Boot 2023.10 (Feb 25 2024 - 07:38:11 -0500)

DRAM:  128 MiB
WARNING: Caches not enabled
Core:  18 devices, 10 uclasses, devicetree: embed
Flash: 64 MiB
MMC:   mmci@5000: 0
Loading Environment from FAT... Card did not respond to voltage select! : -110
** Bad device specification mmc 0 **
In:    serial
Out:   serial
Err:   serial
Net:   eth0: ethernet@3,02000000
Hit any key to stop autoboot:  0

3. create_sd_card.sh

   the create_sd_card.sh creates and partitions an sdcard.img file

dkrinsky@dkrinsky-Precision-7670:~/qemu/qemu_0225$ . create_sd_card.sh 
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.343906 s, 3.1 GB/s

Welcome to fdisk (util-linux 2.37.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x31b43306.

Command (m for help): Created a new DOS disklabel with disk identifier 0xfa1e513b.

Command (m for help): Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): Partition number (1-4, default 1): First sector (2048-2097151, default 2048): Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-2097151, default 2097151): 
Created a new partition 1 of type 'Linux' and of size 64 MiB.

Command (m for help): Selected partition 1
Hex code or alias (type L to list all): Changed type of partition 'Linux' to 'W95 FAT16 (LBA)'.

Command (m for help): Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): Partition number (2-4, default 2): First sector (133120-2097151, default 133120): Last sector, +/-sectors or +/-size{K,M,G,T,P} (133120-2097151, default 2097151): 
Created a new partition 2 of type 'Linux' and of size 64 MiB.

Command (m for help): Partition type
   p   primary (2 primary, 0 extended, 2 free)
   e   extended (container for logical partitions)
Select (default p): Partition number (3,4, default 3): First sector (264192-2097151, default 264192): Last sector, +/-sectors or +/-size{K,M,G,T,P} (264192-2097151, default 2097151): 
Created a new partition 3 of type 'Linux' and of size 895 MiB.

Command (m for help): Partition number (1-3, default 3): 
The bootable flag on partition 1 is enabled now.

Command (m for help): Disk sdcard.img: 1 GiB, 1073741824 bytes, 2097152 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xfa1e513b

Device      Boot  Start     End Sectors  Size Id Type
sdcard.img1 *      2048  133119  131072   64M  e W95 FAT16 (LBA)
sdcard.img2      133120  264191  131072   64M 83 Linux
sdcard.img3      264192 2097151 1832960  895M 83 Linux

Command (m for help): The partition table has been altered.
Syncing disks.

[sudo] password for dkrinsky: 
/dev/loop16
/dev/loop16p1
/dev/loop16p2
mkfs.fat 4.2 (2021-01-31)
mkfs.fat: Warning: lowercase labels might not work properly on some systems
mke2fs 1.46.5 (30-Dec-2021)
Discarding device blocks: done                            
Creating filesystem with 16384 4k blocks and 16384 inodes

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

4. print_sd_card.sh

   the print_sd_card.sh can be used at any time to display the partitions and contents of the sdcard.
   after the initial creation, there will be three partitions, with only the rootfs partition containing
   anything (lost + found dir)
   
dkrinsky@dkrinsky-Precision-7670:~/qemu/qemu_0225$ . print_sd_card.sh 

Welcome to fdisk (util-linux 2.37.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): Disk sdcard.img: 1 GiB, 1073741824 bytes, 2097152 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xfa1e513b

Device      Boot  Start     End Sectors  Size Id Type
sdcard.img1 *      2048  133119  131072   64M  e W95 FAT16 (LBA)
sdcard.img2      133120  264191  131072   64M 83 Linux
sdcard.img3      264192 2097151 1832960  895M 83 Linux

Command (m for help): 
/dev/loop16
ls /dev/loop16p1
total 0
ls /dev/loop16p2
total 16
drwx------ 2 root root 16384 Feb 25 07:48 lost+found


5. run_uboot_sdcard

   once the sdcard is created, the run_uboot_sdcard can be used to run qemu.  

alias run_uboot_sdcard="qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel bootloader/u-boot-2023.10/u-boot -sd sdcard.img"

      this command attaches the sdcard.img and now uboot can read the FAT partition.
      in order to create a uboot.env, just type saveenv from the uboot prompt.


U-Boot 2023.10 (Feb 25 2024 - 07:38:11 -0500)

DRAM:  128 MiB
WARNING: Caches not enabled
Core:  18 devices, 10 uclasses, devicetree: embed
Flash: 64 MiB
MMC:   mmci@5000: 0
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1... 
In:    serial
Out:   serial
Err:   serial
Net:   eth0: ethernet@3,02000000
Hit any key to stop autoboot:  0 
