# T99W175 Sahara 9008 repair guide

## DISCLAIMER

I am not responsible for bricked modems, thermonuclear war, or you getting fired because the T99W175 failed to turn in CFUN = 1. Please do some research 
if you have any concerns about the steps included in this guide before following it! YOU are choosing to make these modifications, and if you blame me in any way for what happens to your device, I will laugh at you. BOOM! goes the dynamite

## Prerequisites

This guide assumes that:

- the steps to obtain a working pyenv for the [project](https://github.com/bkerler/edl) have been already followed correctly and the command `edl -h` returns the help page of the python program with no issues.

- You're trying to fix a broken T99W175 in the following states: 9008 15s loop, 9008 stable. T99W175 in the deadly customer = 3. 

- You have the USB+Ethernet 5GPHY adapter to make it work in USB mode even if the bootpoint under the modem for USB is broken

- In case anything breaks, the T99W175 EDL bootpoint is accessible by flipping the board with tweezers or solder (not recommended because the bootpoints are easily destroyed by bad soldering iron usage). I recommend to use a thin cable, peeling off the cover and touching the EDL bootpoint platforms making a short between the two by pushing the thin copper wires for that 3-4 seconds while powering the T99W175 on. This way, you can read the guide again by shorting it without damaging it. 

## Hardware variants

Foxconn released two main hardware variants for this T99W175 5G NGFF 30x42 modem. The known variant code can be found on the top of the modem itself, near the 5 pin M.2 key B connector. These two hardware variants have different *partition layout* also called *MIBIB* in which is described the start and the end of every partition. 

 - V045,V065,V085,V105 (or in short, V105 and earlier): have the "old" layout, without the partitions *usb_qti* and *ipa_fw*
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

If somebody provided you a copy of the FULLNAND.bin, you can write it to the T99W175 with the caveat that the UBI partitions and the ones containing the kernel are ERASED before rebooting to fastboot:
 - system (contains Linux rootfs)
 - recoveryfs (copy of system, called if system or boot partition is damaged, together with fsg and recovery)
 - modem (SDX55 firmware, uploaded at boot)
 - fsg (copy of modem)
 - boot (contains the kernel)
 - recovery (contains a copy of the kernel)

I recommend to keep also the kernel and its copy (recovery) ERASED, so the fastboot state can always be reached, given that the other partitions are sane or just flashed 
Are erased and flashed ONLY via fastboot, in a second step. You can erase them in the following way:

```
edl e boot --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
edl e recovery --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
edl e system --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
edl e recoveryfs --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
edl e modem --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
edl e fsg --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
```


This step is NECESSARY before attempting to boot the modem, otherwise it will be stuck in an unknown state where the EDL boot pin will be necessary again and you have to go back and short it to reach 9008 again.



