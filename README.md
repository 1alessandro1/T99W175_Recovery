# T99W175 Sahara 9008 repair guide

## DISCLAIMER

I am not responsible for bricked modems, thermonuclear war, or you getting fired because the T99W175 failed to turn in CFUN = 1. Please do some research 
if you have any concerns about the steps included in this guide before following it! YOU are choosing to make these modifications, and if you blame me in any way for what happens to your device, I will laugh at you. BOOM! goes the dynamite

## Prerequisites

This guide assumes that:

- The steps to obtain a working pyenv for the [project](https://github.com/bkerler/edl) have been already followed correctly and the command `edl -h` returns the help page of the python program with no issues.

- You're trying to fix a broken T99W175 in the following states: 
   1. 9008 15s loop
   2. 9008 stable with no reboots. 
   3. Deadly *CUSTOMER 3* or any other qlink error states (use 5GPHY board with 3.3V on pin3 to enable USB and once the device appears, use `adb wait-for-device && adb reboot edl` if you're stuck in a wrong *CUSTOMER*, customer 0 is the recommended) 

- You have the USB+Ethernet 5GPHY adapter to make it work in USB mode even if the bootpoint under the modem for USB is broken

- In case anything breaks, the T99W175 EDL bootpoint is accessible by flipping the board, by with tweezers or solder (not recommended because the bootpoints are easily destroyed by bad soldering iron usage). I recommend to use a thin cable, peeling off the jacket and touching the EDL testpoints with hair-style copper wires making a short between the two by pushing for 3-4 seconds while connecting the T99W175 to the USB port. This way, you can always enter 9008 as many times as you like, without having to deal with solder and risk related to damaging the pins.

## Hardware variants

Foxconn released two main hardware variants for this T99W175 5G NGFF 30x42 modem. The known variant code can be found on the top of the modem itself, near the 5 pin M.2 key B connector. These two hardware variants have different *partition layout* also called *MIBIB* in which is described the start and the end of every partition. 
 - V045 is a 5 pin modem, needs to be soldered on the back regardless of whether there are 3.3V on the pin3 or not
 - V065,V085,V105 (or in short, V105 and earlier): have the "old" layout, without the partitions *usb_qti* and *ipa_fw*
 - V205, V305 (or in short, V205 and greater): usually come with the "new" layout, **with** *usb_qti* and *ipa_fw*

**Personal recommendation**: check first with the command `edl printgpt` what the actual layout looks like, use the correct parameters for the usb device listed in `lsusb` looking for *Foxconn QUSB_BULK* such as `--vid 105b` and `--vid 105b` and `--loader=/path/to/prog_firehose_sdx55.mbn`  before flashing the dumps I provide. 

 Example 1: `edl printgpt --vid 105b --pid e0ab --loader=/home/user/prog_firehose_sdx55.mbn`

 Example 2: `edl printgpt --vid 105b --pid E0B0 --loader=/home/user/prog_firehose_sdx55.mbn`


 **NOTE**: the *sbl* partition and *mibib* must be in sane condition (not erased or overwritten by faulty flashing) in order to see the layout with the command `edl pringpt`. If `edl pringpt ` doesn't print anything, the layout must be guessed by reading the hardware variant, and NAND has to be manually flashed with sector offsets just for *MIBIB* and *SBL*:


 Example
  **Remember**: these commands will **overwrite** the current partition layout regardless if it existed before or not.
 ```
    Erase first, just to be sure:
    edl es 0 639 --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
    edl es 640 1279 --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

    Write sectors:
    edl ws 0 sbl.bin --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn" 
    edl ws 640 mibib.bin --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
 ```

You may now proceed by flashing all the other partitions not by using sector offsets but by using sector names. The EDL python program will handle the offsets for you. 

Example: 

``` 
WRITE uefi.bin partition TO the modem
edl w uefi uefi.bin --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn

READ xbl_config partition FROM the modem to file (xbl_config.bin)

edl r xbl_config xbl_config.bin --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn

```

## Flashing using FULLNAND.bin

You can flash a copy of FULLNAND.bin, you can flash it too. Read carefully below before executing it. This is the command:

```
edl ws 0 FULLNAND.bin --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
```

**NOTE:** you can write it to the T99W175 with the caveat that the UBI partitions and the ones containing the kernel are ERASED before rebooting to the system (Linux system inside the T99W175).

There are two ways to do this: 

   1. (FASTER) Erase only boot and recovery, then unplug the cable and the modem will go automatically in fastboot.

   ```
   edl e boot --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
   edl e recovery --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
   ```
   
   Once the modem reboots in fastboot mode, you can run the following:

   ```
   fastboot erase system;
   fastboot erase recoveryfs; 
   fastboot erase modem; 
   fastboot erase fsg;
   ```


   2. (SLOWER) You can do this from edlclient as well, but it will be slower writing zeroes than `fastboot erase`:
   
   ```
   edl e boot --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
   edl e recovery --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
   edl e system --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
   edl e recoveryfs --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
   edl e modem --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
   edl e fsg --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
   ```


Explanation:

 - system (contains Linux rootfs)
 - recoveryfs (copy of system, called if system or boot partition is damaged, together with fsg and recovery)
 - modem (SDX55 firmware, uploaded at boot)
 - fsg (copy of modem)
 - boot (contains the kernel)
 - recovery (contains a copy of the kernel)

To lower the number of times you have to use 9008, do not flash `boot` and `recovery` until you're sure that everything works as expected. This way, the fastboot state can always be reached after a power loss (cable disconnection), given that the other partitions (abl, xbl, uefi, qhee, etc) were correctly flashed.


This step is NECESSARY before attempting to boot the modem, otherwise it will be stuck in an unknown state where the EDL boot pin will be necessary again and you have to go back and short it to reach 9008 again.


## Flashing firmware

Once all the other partitions are in a good state, you can proceed from fastboot mode to flash all the rest. Start with the UBIs such as system, modem and then the others.

```
fastboot flash system t99w175_cfw_sdxprairie_sysfs.ubi
fastboot flash modem NON-HLOS_sdxprairie_cfw.ubi
fastboot flash recoveryfs t99w175_cfw_sdxprairie_sysfs.ubi
fastboot flash fsg NON-HLOS_sdxprairie_cfw.ubi
```

Then to boot the system you can run:


```
fastboot boot t99w175_boot.img
```

**Note 1:** Beware to use "*boot*" now, not "*flash*": we want to make sure that a power disconnection will bring us again at the bootloader stage (fastboot) in case anything goes wrong. 

**Note 2:** The first time, the modem will boot, unpack the UBIs and reboot. For what we did, we expect it to go to fastboot again. Run again `fastboot boot t99w175_boot.img`, this time, it shouldn't reboot: if it does, something is incompatible and other ways have to be followed to fix it. From the fastboot state you can reach 9008, flash firmware, erase partitions way easier/faster than using 9008 and the `.mbn` loader.  

After you get the T99W175 to boot without any issues with fastboot boot you may proceed to run: 

```
fastboot flash boot t99w175_boot.img
fastboot flash recovery t99w175_boot.img
```

Your T99W175 should work as expected. 


## Additional notes

To change the active slot, useful when testing different kinds of firmware, you can use the following commands after entering a shell, for example with `adb shell`:


To use boot+modem+system:

```
echo -ne '\x00' | dd of=/dev/mtdblock21 bs=1 seek=28 count=1 conv=notrunc 
```

To use recovery+fsg+recoveryfs:

```
echo -ne '\x01' | dd of=/dev/mtdblock21 bs=1 seek=28 count=1 conv=notrunc 
```








