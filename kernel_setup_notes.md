# 🧩 Custom RootFS – Kernel Setup for Raspberry Pi 4B (64-bit)

This update documents the kernel setup for Raspberry Pi 4B using cross-compilation on an x86 host machine.

---

## 📦 Kernel Cloning & Configuration

### ✅ Steps Completed

#### 🔹 Cloned the Linux Kernel

```bash
git clone --depth=1 https://github.com/raspberrypi/linux.git -b rpi-6.6.y kernel-rpi
cd kernel-rpi
```

- Shallow clone using `--depth=1` for faster setup.
- Used the `rpi-6.6.y` branch for Raspberry Pi 4 compatibility.

#### 🔹 Set Up Cross-Compilation Environment

```bash
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
```

- Set environment variables for cross-compiling from x86 to ARM64.
- These can be added to `.bashrc` or a setup script for reuse.

#### 🔹 Default Configuration for Raspberry Pi 4

```bash
make bcm2711_defconfig
```

- Loads the default config for the BCM2711 SoC used in Raspberry Pi 4.
- Generates the `.config` file required for kernel builds.

#### 🔹 Verified and Inspected `.config`

```bash
ls .config
make menuconfig  # optional
```

- Verified that `.config` was generated.
- Optionally modified settings via menu-based interface.

📸 [ls_.config](screenshots/ls_.config.png)

---

## 🛠️ Build Image, Modules, and Device Tree

After configuring the kernel:

```bash
make Image modules dtbs -j$(nproc)
```

- **Image**: The compressed kernel image for ARM64, typically found at:
  ```
  arch/arm64/boot/Image
  ```
- **Device Tree Blobs (DTBs)**: Hardware description files generated at:
  ```
  arch/arm64/boot/dts/broadcom/*.dtb
  ```
- **Modules**: Kernel modules built into:
  ```
  ./modules/
  ```
  
## Verified Module Compilation
  
After building the kernel image and device tree blobs, kernel modules were compiled using:

make modules

To verify successful compilation, the following command was used:

find . -name "*.ko" | head -n 20

This listed the .ko (kernel object) files, confirming that modules like vsock.ko, nfnetlink.ko, and xt_socket.ko were generated successfully.

📸 [Generated_Image](screenshots/Generated_Image.png)
📸 [dtb_files](screenshots/dtb_files.png)
📸 [compiled_modules](screenshots/compiled_modules.png)


## 🧠 Notes

- **BCM2711** is the SoC used in Raspberry Pi 4, and its configuration is pre-defined in the kernel.
- **Cross-compilation** is essential when building ARM64 software on an x86 host.
- Efficient cloning and setup practices (like shallow clone) help save time during prototyping.

---
