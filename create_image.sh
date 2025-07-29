#!/bin/sh
IMAGE=images/boot.img
BOOT_MOUNT=/mnt/boot
KERNEL=linux/arch/arm64/boot/Image
DTB=linux/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dtb
FIRMWARE=firmware/boot/start4.elf
FIXUP4=firmware/boot/fixup4.dat

# Create 64MB empty boot.img file
dd if=/dev/zero of=$IMAGE bs=1M count=64

# Format it as FAT32
mkfs.ext4 $IMAGE

# Mount it using loop device
sudo mkdir -p $BOOT_MOUNT
sudo mount -o loop $IMAGE $BOOT_MOUNT

# Copy kernel, DTB, Firmware and fixup.dat
sudo cp $KERNEL $DTB $FIRMWARE $FIXUP4 $BOOT_MOUNT

# Create cmdline.txt
echo "console=serial0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait init=/sbin/init" | sudo tee $BOOT_MOUNT/cmdline.txt > /dev/null

# Create config.txt
cat <<EOF | sudo tee $BOOT_MOUNT/config.txt > /dev/null
arm_64bit=1
kernel=Image
enable_uart=1
EOF

# Unmount the image
sudo umount $BOOT_MOUNT

echo "Boot image created successfully."
