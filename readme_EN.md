# Matebook 14/13 (2019/2020/2021) MacOS Monterey & Bigsur Black Apple Installation Tutorial
>Record the Matebook14 hacking process, complete the single hard drive Macos Monterey & Bigsur and Windows 11 dual system installation without loss

【 English | [中文](readme.md) 】

### Model configuration information
| Project | Detailed Parameters |
| :--: | :-------------------------------- |
| Model | Matebook 14 |
| CPU | Whiskey Lake i5 8265u |
|Memory|DDR3L 8G|
| Graphics Card | UHD620@MX250|
| Hard Drive | WD SN720 512G|
| Sound Card | Realtek ALC256 |
|LCD| 2160*1440|
|BIOS|1.06|

### renew

-2022/05/28 update
* Delete the `CLOVER` driver, modify it to `OpenCore` driver, use version `7.9`, support model `Matebook 14/13 (2019/2020/2021)` install `Bigsur` and `Monterey`, perfect long-term use
* Add `INTEL` wireless network card driver, the default driver is `Monterey`, to switch the wireless network card driver, please unzip `/EFI/OC/AirportItlwm_v2.1.0_stable_BigSur.kext.zip` or `/EFI/OC/AirportItlwm_v2. 1.0_stable_Monterey.kext.zip` can directly replace `/EFI/OC/Kexts/AirportItlwm.kext`
* Fix the problem that the resolution of `HiDIP` is set too high, and the screen will be blurred when the cover is opened. Now there is no limit to the resolution. It is recommended to set the parameters to `1680x1120 1500x1000 1350x900`, [setting method](#hidip-setting method)
* Fix the problem that `Monterey` Cpu cannot be hard-solved
* Fix `HDMI` black screen problem, support hot swap

-2020/04/25 This update. Use [Matebook_13_14_2020_Hackintosh_OpenCore](https://github.com/Zero-zer0/Matebook_13_14_2020_Hackintosh_OpenCore) project path patch and kext, theoretically this CLOVER can support Matebook14 2020 machines. My Matebook14 2019 uses [Matebook_13_14_2020_Hackintosh_OpenCore](https://github.com/Zero-zer0/Matebook_13_14_2020_Hackintosh_OpenCore), all functions are normal, it is recommended to use OpenCore to start, for [Zero-zer0](https://github.com/Zero-zer0) Contributions are appreciated.

-2020/02/29 Update CLOVER 5104, AirportBrcmFixup 2.0.6, AppleALC 1.4.6, CPUFriden 1.2.0, Lilu 1.4.1, NoTouchID 1.0.3, NullEthernet 1.0.6, WhateverGreen 1.3.6, added [IntelBluetoothFirmware] (https://github.com/zxystd/IntelBluetoothFirmware) The patch solves the problem that the bluetooth cannot be loaded in the cold boot. The above are all tested in Catilina 10.15.3

-2019/12/20 Update CLOVER to 5101, fix HDMI/HDMI audio, add two sets of themes for Catalina2K/4K, add Bluetooth hot start script to be used with Fusion virtual machine and TinyCoreLinux, add 10.15 Bluetooth [patch](/Bluetooth patch), test 10.14/10.15 both work fine

-2019/06/30 Update CLOVER to 4972

-2019/06/29 Update I2C, add HUAWEI theme, please use Kext Utility.app to rebuild cache (under tools directory) after update, add and modify USB WIFI icon and Chinese

-2019/05/26 HDMI driver, add IMEI patch to solve wake-up application stuck, QiuckPlayer cannot record screen, upgrade CLOVER to 4934, update other/kext driver, remove useless code in config.plis

### already driven
* CPU Turbo
* wake up
* Recording
* Speaker/Headset
* Touchpad / Gestures
*USB3.0/2.0
* HiDPI
* HDMI is normal
* Bluetooth
* WIFI (INTEL wireless network card)

### Unable to drive:
* Camera
* MX250 and other discrete graphics cards

### Additional Notes
* HiDIP is switched with RDM, [setting method] (#hidip-setting method) see below
* The default model of config.plis is Macbookpro15,2. You can use the tool to generate a new serial number by yourself. It is not recommended to modify the model.

### Prepare tools
* 8G U disk
* [WePE](http://www.wepe.com.cn/)
* [Apple mirror](blog.daliansky.net)

## Dual system non-destructive installation points:
* Install the Windows11 system first, and backup the Windows boot EFI partition (EFI/Boot and Microsoft)
* Adjust the EFI partition, use DiskGenius to adjust the EFI partition to 200M (if not, create a new EFI partition, the new type must select the EFI partition type), you can delete the redundant MSR partition (obsessive-compulsive disorder). The EFI partition is generally placed at the front of the hard disk. If there is no space in the front of the hard disk, move the system partition first so that there is 200M space in the front of the hard disk, and then create or adjust it. Because the MAC system installation must meet the EFI partition greater than 200M.
* Create a new MAC system partition. This step is very important. If you do not create a new MAC system in the next step, you can only format the entire disk. Creating a MAC partition is the core of a lossless installation. Adjust the Windows system and other partitions according to personal requirements, and then create all the remaining hard disk space as Apple partitions, and create optional MAC type partition formats (here I choose HFS+). In this way, the next step to install the MAC system can recognize the Apple partition, so there is no need to format the entire hard disk
* Install the MAC system, replace the `EFI` folder of the EFI partition after the system installation is complete

### Installation process
* Adjust the partition of the hard disk, and burn the WePE to the U disk (the PE disk has been made and skip it)
* USB access to the prepared PE disk, restart the machine and press F12 on the LOGO interface to enter the Boot Menu and choose to boot from the U disk
* When entering PE system, use AOMEI Assistant to adjust the hard disk of the machine (taking Matebook14 as an example, the original hard disk is divided into EFI 100M, MSR 16M, Windows 80G is adjusted to EFI 200M, MSR 16M, Windows remains unchanged)
* Open DiskGenius at the end of the hard disk, and create a new Apple HFS+ (120G partition is recommended). This step is very important. If you do not create an HFS+ partition and enter the mac installation disk tool, you will not be able to erase the disk. This is the key to non-destructive installation of dual systems.
* Return to WIN, burn the U disk to the Apple installation image, the image is recommended to use the latest packaged image of Heiguo Xiaobing
* Mount the U-disk EFI partition and replace the `EFI` folder in the U-disk EFI partition
  ```cmd
  diskpart
  list disk # disk list
  select disk n # Select the disk where the U disk EFI partition is located, n is the disk number
  list partition # disk partition list
  select partition n # Select the EFI partition, n is the EFI partition number
  set id="ebd0a0a2-b9e5-4433-87c0-68b6b72699c7" # Set as EFI partition
  assign letter=X # x is the drive letter of the EFI partition
  ````

* Enter the BIOS, change the language to Chinese, find the two items of secure boot and software security chip and close them.
* Press F12 to boot and choose to boot from U disk to start the installation
* After the installation is complete, copy CLOVER to the hard disk EFI partition (after entering the Mac system, mount the EFI partition, copy the `OC` folder and `BOOT` folder of the U disk EFI partition to the mounted hard disk `EFI` partition

### HiDIP setting method
* Use HiDIP script to set [Github](https://github.com/xzhih/one-key-hidpi), choose to enable HiDPI (without injecting EDID), choose icons, customize several 3:2 resolutions, Such as 1680x1120 1500x1000 1350x900 etc.

### The solution to the occasional noise from the sound card
* Occasionally there is a problem of background noise [hoarseness] in external playback, go to Sound Settings->Sound Control Preferences->Switch the input and output options to restore normal playback of external playback

### write at the end
* It is best if the version of `OpenCore` is not the latest. The appropriate version should be stable. If you want to upgrade the version of `OpenCore`, it is recommended to use [OCAuxiliaryTools](https://github.com/ic005k/OCAuxiliaryTools/blob/master/READMe -cn.md)
* [Screenshots](./Screenshots/) see here

### end of tutorial