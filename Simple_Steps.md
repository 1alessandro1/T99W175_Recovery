# T99W175 Sahara 9008 repair guide

Use 5GPHY for T99W175 with 3.3V on pin3

## Hardware variants

Foxconn released two main hardware variants for this T99W175 5G NGFF 30x42 modem. The known variant code can be found on the top of the modem itself, near the 5 pin M.2 key B connector. These two hardware variants have different *partition layout* also called *MIBIB* in which is described the start and the end of every partition. 

 - V045,V065,V085,V105 (or in short, V105 and earlier): have the "old" layout, **without** the partitions *usb_qti* and *ipa_fw*
 - V205, V305 (or in short, V205 and greater): usually come with the "new" layout, **with** *usb_qti* and *ipa_fw*

## Flashing using FULLNAND.bin

You can obtain a copy of FULLNAND.bin for your model, you can flash it via [edlclient](https://github.com/bkerler/edl). Read carefully below before executing it. This is the command:

```
edl ws 0 FULLNAND_V085.bin --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
edl ws 0 FULLNAND_V205.bin --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn
```

**NOTE:** you can write it to the T99W175 with the caveat that the UBI partitions and the ones containing the kernel are ERASED before rebooting to the system (Linux system inside the T99W175).

Erase only boot and recovery, then unplug and reconnect the USB cable and the modem will go automatically in fastboot.

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


Written by @1alessandro1 at Github. Credits include also @stich86.



