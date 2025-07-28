#!/bin/sh
IMAGE=images/rootfs.ext4
ROOTFS=rootfs

dd if=/dev/zero of=$IMAGE bs=1M count=64
mkfs.ext4 $IMAGE
sudo mount -o loop $IMAGE /mnt
sudo cp -a $ROOTFS/* /mnt
sudo umount /mnt

echo "rootfs.ext4 created successfully."
