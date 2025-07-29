SD Card Preparation – Boot + RootFS Deployment

This section documents the process of partitioning and preparing an SD card to boot Raspberry Pi 4 Model B using a custom-built bootloader and root filesystem.

🗂️ Overview

The SD card is structured into two partitions:

Boot Partition (boot.img) – Contains firmware files, kernel8.img, and config.txt

RootFS Partition (rootfs.ext4) – Holds the BusyBox-based minimal root filesystem

SD Card Setup Steps
## 1. Identify SD Card Device
Before inserting:

lsblk

Insert SD card and run again:

lsblk

Note the new block device, e.g., /dev/sdX (replace X accordingly).

## 2. Partitioning SD Card

umount if it is mounted

sudo fdisk /dev/sdX
Inside fdisk:

o → Create a new DOS partition table

n → New primary partition 1 → +64M

t → Change type to c (W95 FAT32 LBA)

n → New primary partition 2 → Use remaining space

w → Write changes and exit

📸[partition_creation](screenshots/partition_creation.png)


## 3. Format Partitions

sudo mkfs.vfat /dev/mmcblk0p1
sudo mkfs.ext4 /dev/mmcblk0p2


## 4. Mount and Copy Boot Files

📸[lsblk](screenshots/lsblk.png)

sudo mkdir -p /mnt/boot /mnt/tmpboot 

sudo mount /dev/mmcblk0p1 /mnt/boot --> Sdcard
sudo mount -o loop images/boot.img /mnt/tmpboot --> Yours created boot.img

sudo cp -a /mnt/tmpboot/* /mnt/boot
sudo umount /mnt/tmpboot

## 5. Mount and Copy RootFS

sudo mkdir -p /mnt/rootfs /mnt/tmpfs

sudo mount /dev/mmcblk0p2 /mnt/rootfs --> Sdcard
sudo mount -o loop images/rootfs.ext4 /mnt/tmpfs --> Yours created rootfs.ext4

sudo cp -a /mnt/tmpfs/* /mnt/rootfs
sudo umount /mnt/tmpfs



## 6. Final Unmount

sudo umount /mnt/boot
sudo umount /mnt/rootfs









