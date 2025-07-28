 🧩 Custom Root Filesystem – Raspberry Pi 4 Model B (64-bit)

This project demonstrates how to build and boot a minimal custom root filesystem (rootfs) using BusyBox for Raspberry Pi 4 Model B (64-bit).

---

## 📌 Project Info

- **Project Duration:** July 2025  
- **Author:** Ramkumar B  
- **Description:** Minimal root filesystem creation for Raspberry Pi 4 with cross-compiled BusyBox and basic init integration.

---

## 📑 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Features](#features)
- [Build Instructions](#build-instructions)
- [RootFS Layout](#rootfs-layout)
- [Init Script](#init-script)
- [Learnings](#learnings)
- [Next Steps](#next-steps)
- [Project Status](#project-status)

---

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

 Added an automation script: `create_image.sh`





## 🛠️ Project Status

This repository is an active work-in-progress. I’m building the root filesystem step-by-step over several days and updating the README and commits accordingly.

✅ Completed so far:

* BusyBox cross-compilation for ARM64

* Base rootfs layout with init script

* ext4 image generation


🔜 Coming Next:

  * U-Boot boot script and integration

  * UART-based boot testing and logging


