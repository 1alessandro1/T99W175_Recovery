# Guide to convert any T99W175 into Lenovo, HP, DELL etc.

In the following guide I will describe the necessary steps to convert any T99W175 from any customer to any other customer. 

First, you need to access the virtual serial ports: you can use a program such as PUTTY or MobaXTerm, check in windows inside the "Device Manager" app what is the COM port that is appearing under "MODEM", right click on the device, then "Properties" and in the "Modem" tab you will see the COM port.

Once you obtain this information, you can send the following commands to change any customer to any other customer.

# The importance of AT^CUSTOMER command

There is this undocumented command inside the firmware of T99W175 that can select how the modem will present itself. This configures the vendor, modem mbn settings for carrier etc.

The following file was extracted from the T99W175 firmware, and is very clear on what customer is what:


```bash
eval FindAndMountUBI modem /firmware ,noexec,nodev$firmware_selinux_opt
#Modify by foxconn zhulin for change /firmware/image to rw instead of ro for different customer have different carrier list 2020/07/29 end
#Add by foxconn zhulin for Implement feature to support different carrier for different customer 2019/10/17 start

vendor_info=`cat /sys/devices/virtual/oem/pro/pro_info`
#platform_info=`cat /sys/devices/virtual/oem/platform/platform_info`
rm /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log

if [ ! -f "/firmware/image/modem_pr/mcfg/configs/mcfg_sw/last_vendor_info.txt" ]; then
	echo $vendor_info > /firmware/image/modem_pr/mcfg/configs/mcfg_sw/last_vendor_info.txt
	#echo $platform_info > /firmware/image/modem_pr/mcfg/configs/mcfg_sw/last_platform_info.txt
	last_vendor_info=100
	#last_platform_info=100
else
	last_vendor_info=`cat /firmware/image/modem_pr/mcfg/configs/mcfg_sw/last_vendor_info.txt`
	#last_platform_info=`cat /firmware/image/modem_pr/mcfg/configs/mcfg_sw/last_platform_info.txt`
fi

if [ $vendor_info = $last_vendor_info ]; then
	echo exit >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
	exit 0
else
	rm /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig

	echo Do something >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
	echo "vendor_info:$vendor_info" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
	echo "last_vendor_info:$last_vendor_info" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
	#echo "platform_info:$platform_info" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
	#echo "last_platform_info:$last_platform_info" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
	
	
	case "$vendor_info" in
		"0")
			#echo "Vendor is QC" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_all.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_all.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"1")
			#echo "Vendor is DELL" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_DELL.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_dell.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"2")
			#echo "Vendor is Telit" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Telit.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Telit.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"3")
			#echo "Vendor is LENOVO WOS " >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Lenovo_wos.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_lenovo_wos.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"4")
			#echo "Vendor is HP" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_HP.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_hp.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"5")
			#echo "Vendor is DELL NON-ESIM" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_DELL.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_dell.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"6")
			#echo "Vendor is LENOVO X86" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Lenovo_x86.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_lenovo_x86.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"7")
			#echo "Vendor is DELL FX" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_all.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_all.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"8")
			#echo "Vendor is LENOVO WW Sku WOS" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Lenovo_wos.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_lenovo_wos.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"9")
			#echo "Vendor is LENOVO Lenovo Eagle WW SKU" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Lenovo_wos.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_lenovo_wos.dig  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		":")
			#echo "Vendor is DELL unknown 10" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_DELL.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_dell.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		";")
			#echo "Vendor is DELL NON-ESIM 11" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_DELL.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_dell.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"<")
			#echo "Vendor is Telit unknown 12" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Telit.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Telit.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"=")
			#echo "Vendor is HP unknown 13" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_HP.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_hp.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		">")
			#echo "Vendor is Thales USB3 14" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Thales.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Thales.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"?")
			#echo "Vendor is Thales USB3 15" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Thales.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Thales.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"@")
			#echo "Vendor is Thales PCIE 16" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Thales.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Thales.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"A")
			#echo "Vendor is Thales PCIE 17" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Thales.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Thales.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"B")
			#echo "Vendor is Lenovo wos Lenovo Eagle China 18" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Lenovo_wos.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_lenovo_wos.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;	
		"C")
			#echo "Vendor is Lenovo x86 Lenovo Zeus2 WW SKU 19" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Lenovo_x86.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_lenovo_x86.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"D")
			#echo "Vendor is Lenovo x86 unknown 20" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_all.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_all.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"E")
			#echo "Vendor is Lenovo x86 unknown 21" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Thales.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Thales.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"F")
			#echo "Vendor is Lenovo x86 unknown 22" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Thales.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Thales.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"G")
			#echo "Vendor is Lenovo x86 unknown 23" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Thales.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Thales.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"H")
			#echo "Vendor is Lenovo x86 unknown 24" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Thales.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Thales.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"I")
			#echo "Vendor is Lenovo x86 unknown 25" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Lenovo_wos.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_lenovo_wos.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"J")
			#echo "Vendor is Lenovo x86 unknown 26" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_IDU.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_idu.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"K")
			#echo "Vendor is Lenovo x86 unknown 27" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Lenovo_wos.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_lenovo_wos.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"L")
			#echo "Vendor is Lenovo x86 unknown 28" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Lenovo_wos.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_lenovo_wos.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"M")
			#echo "Vendor is Lenovo x86 unknown 29" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_IDU.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_idu.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"N")
			#echo "Vendor is Thales vendor 30" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Thales.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Thales.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
		"O")
			#echo "Vendor is Lenovo x86 unknown 31" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_all.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_all.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;	
			
		"S")
			#echo "Vendor is FX 35" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_all.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_all.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
				
		"T")
			#echo "Vendor is FX 36" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_all.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_all.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
					
		"U")
			#echo "Vendor is Telit 37" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_Telit.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_Telit.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
																																																					
		*)
			#echo "Vendor info read fail:$vendor_info" >> /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mcfg.log
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw_all.txt /firmware/image/modem_pr/mcfg/configs/mcfg_sw/oem_sw.txt
			ln -s  /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw_all.dig /firmware/image/modem_pr/mcfg/configs/mcfg_sw/mbn_sw.dig
			;;
	esac
fi
echo $vendor_info > /firmware/image/modem_pr/mcfg/configs/mcfg_sw/last_vendor_info.txt
#echo $platform_info > /firmware/image/modem_pr/mcfg/configs/mcfg_sw/last_platform_info.txt
```


# Practical synthesis

AT^CUSTOMER is followed by a number


```bash
"0") echo "Vendor is QC" // send AT^CUSTOMER=0 to set QUALCOMM generic vendor
"1") echo "Vendor is DELL" // send AT^CUSTOMER=1 to set DELL version 
"2") echo "Vendor is Telit" // send AT^CUSTOMER=2 to set TELIT version 
"3") echo "Vendor is LENOVO WOS (windows on snapdragon) // NOT RECOMMENDED DO NOT USE, check customer 6.
"4") echo "Vendor is HP" // send AT^CUSTOMER=4 to set HP version 
"5") #echo "Vendor is DELL NON-ESIM" // send AT^CUSTOMER=5 to set DELL NON ESIM version 
"6") #echo "Vendor is LENOVO X86" // send AT^CUSTOMER=6 for LENOVO 
"7") #echo "Vendor is DELL FX"
"8") #echo "Vendor is LENOVO WW Sku WOS"
"9") echo "Vendor is LENOVO Lenovo Eagle WW SKU"
":") echo "Vendor is DELL unknown 10
";") #echo "Vendor is DELL NON-ESIM 11"
"<") #echo "Vendor is Telit unknown 12"
"=") #echo "Vendor is HP unknown 13"
">") #echo "Vendor is Thales USB3 14" 
"?") #echo "Vendor is Thales USB3 15" 
"@") #echo "Vendor is Thales PCIE 16"
"A") #echo "Vendor is Thales PCIE 17"
"B") #echo "Vendor is Lenovo wos Lenovo Eagle China 18"
C") echo "Vendor is Lenovo x86 Lenovo Zeus2 WW SKU 19"
#echo "Vendor is Lenovo x86 unknown 20"
#echo "Vendor is Lenovo x86 unknown 21"
echo "Vendor is Lenovo x86 unknown 22"
#echo "Vendor is Lenovo x86 unknown 23"
#echo "Vendor is Lenovo x86 unknown 24"
#echo "Vendor is Lenovo x86 unknown 25"

```

# BEWARE of the UNSAFE CUSTOMERs information

Some customers were tested by the community. The unsafe customers are grouped into this list, BEWARE to not use the unsafe modes. Thanks to 4PDA T99W175 forum for the information.

```
AT^CUSTOMER=0 Qualcomm T99W175
AT^CUSTOMER=1 Dell T99W175
AT^CUSTOMER=2 Telit FN982m
AT^CUSTOMER=3 reboot - Never transfer to this mode
AT^CUSTOMER=4 Qualcomm T99W175
AT^CUSTOMER=5 Dell T99W175
AT^CUSTOMER=6 Qualcomm T99W175
AT^CUSTOMER=7 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=8 Qualcomm T99W175
AT^CUSTOMER=9 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=10 reboot (qlink error) - Never transfer to this mode
AT^CUSTOMER=11 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=12 Telit FN982m
AT^CUSTOMER=13 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=14 Thales MV31-W
AT^CUSTOMER=15 reboot (qlink error) - Never translate into this mode
AT^CUSTOMERE=16 Thales MV31-W
AT^CUSTOMER=17 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=18 Qualcomm T99W175
AT^CUSTOMER=19 Qualcomm T99W175
AT^CUSTOMER=20 Qualcomm T99W175
AT^CUSTOMER=21 Thales MV31-W
AT^CUSTOMER=22 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=23 Thales MV31-W
AT^CUSTOMER=24 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=25 Qualcomm T99W175
AT^CUSTOMER=26 reboot (qlink error) - Never transfer to this mode
AT^CUSTOMER=27 Qualcomm T99W175
AT^CUSTOMER=28 Qualcomm T99W175
AT^CUSTOMER=29 Qualcomm T99W175
AT^CUSTOMER=30 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=31 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=32 Thales MV31-W
AT^CUSTOMER=33 Thales MV31-W
AT^CUSTOMER=34 Thales MV31-W (rmnet)
AT^CUSTOMER=35 reboot (qlink error) - Never translate into this mode
AT^CUSTOMER=36 Qualcomm T99W175 (one SIM) - Works at OpenWRT
AT^CUSTOMER=73 Qualcomm T99W175
AT^CUSTOMER=74 Qualcomm T99W175
```
