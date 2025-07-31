🧩 Custom Root Filesystem – Raspberry Pi 4 Model B (64-bit)


	This project demonstrates how to build and boot a minimal custom root filesystem (rootfs) using BusyBox for Raspberry Pi 4 Model B (64-bit).

	---

## 📌 Project Info

	- **Project Duration:** July 2025  
	- **Author:** Ramkumar B  
	- **Description:** Minimal root filesystem creation for Raspberry Pi 4 with cross-compiled BusyBox and basic init integration.

	---

## 📑 Table of Contents

- [Overview](#-overview)
- [Project Info](#-project-info)
- [Project Structure](#-project-structure)
- [Created ext4 Root Filesystem Image](#-created-ext4-root-filesystem-image)
- [Linux Kernel](#linux-kernel)
- [Created Boot Filesystem Image](#created-boot-filesystem-image)
- [Final Steps for Static BusyBox Build](#final-steps-for-static-busybox-build)
- [SD Card Setup](#-sd-card-setup)
- [Boot Setup and Serial Login](#-boot-setup-and-serial-login)
- [Project Status](#-project-status)


## 📌 Overview

	This project demonstrates the creation of a lightweight embedded Linux root filesystem for Raspberry Pi 4 Model B.  
	The rootfs is built using BusyBox (cross-compiled for ARM64) and booted via U-Boot and a Linux kernel. It includes a custom `init` script and supports serial console interaction.

	---

## 📂 Project Structure

📸 ![Click here to view full structure](screenshots/project_structure.png)



## 🧱 Created ext4 Root Filesystem Image


	- Created a 64MB ext4 image using `dd` and `mkfs.ext4`:
	```bash
	dd if=/dev/zero of=images/rootfs.ext4 bs=1M count=64
	mkfs.ext4 images/rootfs.ext4
	```

	- Mounted the image, copied the rootfs content, and unmounted:
	```bash
	sudo mount -o loop images/rootfs.ext4 /mnt
	sudo cp -a rootfs/* /mnt
			    sudo umount /mnt
			    [Added an automation script](create_rootfs.sh)

## Linux kernel

Kernel source: Cloned from Raspberry Pi GitHub

Architecture: arm64

Config: bcm2711_defconfig

Image and modules built via:

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs

📄 [See kernel_setup for detailed information](kernel_setup.md) 


## Created boot Filesystem Image

- Created a 64MB ext4 image using `dd` and `mkfs.ext4`:
```bash
dd if=/dev/zero of=images/boot.img bs=1M count=64
mkfs.vfat images/boot.img
```

- Mounted the image, copied Image,modules,dtb and unmounted:
```bash
sudo mount -o loop images/boot.img /mnt/boot/
sudo cp arch/arm64/boot/Image  /mnt/boot
sudo cp arch/arm64/boot/dtb/broadcom/bcm2711-rpi-4-b.dtb /mnt/boot

- Clone firmware
```bash
git clone --depth=1 https://github.com/raspberrypi/firmware.git
```

sudo cp firmware/boot/start4.elf /mnt/boot
sudo cp firmware/boot/fixup4.dat /mnt/boot
sudo umount /mnt/boot


[Added an automation script](create_image.sh)

## Final Steps for Static BusyBox Build


## 1️⃣ Go to BusyBox folder
cd busybox-1.36.1

## 2️⃣ Clean old configs
make distclean

## 3️⃣ Configure BusyBox
make menuconfig
Navigate to Settings → Build Options

Enable:

✅ [*] Build BusyBox as a static binary (no shared libs)

(Optional) Disable Networking Utilities → tc (avoids TCA_CBQ_MAX error).

Save and exit.

## 4️⃣ Build BusyBox
make CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)

## 5️⃣ Copy BusyBox to rootfs
sudo cp busybox_unstripped /media/ram/564593b5-24e7-44d4-bc70-defb896fc9b2/bin/busybox
sudo chmod +x /media/ram/564593b5-24e7-44d4-bc70-defb896fc9b2/bin/busybox

## 6️⃣ Create shell symlink
sudo ln -sf busybox /media/ram/564593b5-24e7-44d4-bc70-defb896fc9b2/bin/sh
✅ Verify

file busybox_unstripped
Output should include:

statically linked

## 💿 SD Card Setup

To flash boot.img and rootfs.ext4 into an SD card:

Partition layout:

p1 → FAT32 (boot) – 64MB

p2 → ext4 (rootfs) – 64MB

Files copied using dd and parted

📄[See sdcard_setup.md for detailed instructions](sdcard_setup.md)


## 🐧 Boot Setup and Serial Login
To enable root login via the serial console without a password:

🔐 1. Configure /etc/passwd
Ensure the following line is added to your rootfs’s /etc/passwd:

root::0:0:root:/root:/bin/sh
This allows the root user to log in without a password.

⚙️ 2. Set Up Serial Login via getty
In your custom init script (/init), replace or append the following line to launch getty on UART:

	exec /sbin/getty -L ttyS0 115200 vt100
	This enables the serial login prompt on ttyS0 at 115200 baud rate.

	💻 3. Connect via Serial Terminal
	Insert the SD card into your Raspberry Pi and connect to the board using:

	sudo screen /dev/ttyACM0 115200

	You should see the init started message which confirms init started from your custom init file

[init-started](screenshots/init-started.png)

	You should now see a login prompt like this:

[login-screen](screenshots/login-screen.png)

## 🛠️ Project Status
✅ Project Completed

Achievements:
✔️ BusyBox cross-compilation for ARM64 (static build)

✔️ Base rootfs layout with custom init script

✔️ ext4 image generation

✔️ UART-based boot testing and successful root login




