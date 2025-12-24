#!/bin/bash
set -e  # stop on error

# Required image files
FILES=("sysfs.ubi" "modem.ubi" "boot.img")

# Check if all required files exist
for f in "${FILES[@]}"; do
    if [[ ! -f "$f" ]]; then
        echo "Error: required file '$f' not found in current directory."
        exit 1
    fi
done

echo "All required files found."

echo "Press any key to erase partitions: boot, recovery, system, recoveryfs, modem, fsg"
read -n1 -s
fastboot erase boot
fastboot erase recovery
fastboot erase system
fastboot erase recoveryfs
fastboot erase modem
fastboot erase fsg

echo ""
echo "Press any key to flash partitions (excluding boot and recovery)"
read -n1 -s
fastboot flash system sysfs.ubi
fastboot flash recoveryfs sysfs.ubi
fastboot flash modem modem.ubi
fastboot flash fsg modem.ubi

echo ""
echo "Operation completed. Press any key to boot using 'fastboot boot boot.img' to load the kernel in RAM and check if the module starts. BEWARE that you might need to do this twice to reach a stable non-rebooting state"
read -n1 -s
fastboot boot boot.img
echo "If the system booted correctly and went to fastboot, press enter again to boot. This time it should NOT reboot by itself."
read -n1 -s
fastboot boot boot.img
echo "Press enter to reboot manually via adb. We will enter fastboot one last time to flash definitively boot and recovery"
read -n1 -s
adb reboot
echo "Wait a couple of seconds for the device to reappear in lsusb. Press enter to proceed with flashing the kernel"
read -n1 -s
fastboot flash boot boot.img
fastboot flash recovery boot.img


