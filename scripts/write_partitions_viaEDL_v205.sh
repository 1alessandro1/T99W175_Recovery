# wait for device to be just ready if stuck on 20s loop
edl es 0 639 --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl es 640 1279 --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

edl ws 640 mibib.bin --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl ws 0 sbl.bin --vid 105b --pid e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn" 

# wait for device to be just ready if stuck on 20s loop

edl w ablbak ablbak.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w abl abl.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w aopbak aopbak.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w aop aop.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w apdp apdp.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

# wait for device to be just ready if stuck on 20s loop

edl w ddr ddr.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w devinfo devinfo.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w efs2 efs2.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

# wait for device to be just ready if stuck on 20s loop

edl w fota fota.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w foxnv foxnv.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w fwinfo fwinfo.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w ipa_fw ipa_fw.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w loader_sti loader_sti.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

# wait for device to be just ready if stuck on 20s loop

edl w misc misc.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w multi_bak multi_bak.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w multi_image multi_image.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w qheebak qheebak.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w qhee qhee.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

# wait for device to be just ready if stuck on 20s loop

edl w scrub scrub.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w sec sec.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w toolsfv toolsfv.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w tzbak tzbak.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w tz tz.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w tz_devcfgbak tz_devcfgbak.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w tz_devcfg tz_devcfg.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

# wait for device to be just ready if stuck on 20s loop

edl w uefibak uefibak.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w uefi uefi.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w usb_qti usb_qti.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w vendor vendor.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w xbl_configbak xbl_configbak.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl w xbl_config xbl_config.bin --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

# wait for device to be just ready if stuck on 20s loop

edl e boot --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl e recovery --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

# follow fastboot steps from now.

# these won't be necessary and most of the time they won't work because they're slower from 9008 than fastboot.
edl e recoveryfs --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl e system --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"

edl e modem --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"
edl e fsg --vid=105b --pid=e0ab --loader="/home/ale/Qualcomm_EDL/prog_firehose_sdx55.mbn"



