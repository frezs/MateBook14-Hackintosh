# Matebook 14/13 (2019/2020/2021) MacOS Monterey & Bigsur 黑苹果安装教程
>记录Matebook14黑苹果过程，无损完成单硬盘Macos Monterey & Bigsur 和Windows 11双系统安装

【 中文 | [English](readme_EN.md) 】

### 机型配置信息
| 项目 | 详细参数|
| :--: | :-------------------- |
| 型号 | Matebook 14    |
| CPU  | Whiskey Lake i5 8265u |
|内存| DDR3L 8G|
| 显卡 | UHD620@MX250|
| 硬盘 | WD SN720 512G|
| 声卡 | Realtek ALC256 |
|LCD| 2160*1440|
|BIOS|1.06|

### 更新

-2022/05/28 更新
* 删除`CLOVER`驱动，修改为`OpenCore`驱动，使用版本为`7.9`，支持机型`Matebook 14/13 (2019/2020/2021)`安装`Bigsur`和`Monterey`，长期完美使用
* 添加`INTEL`无线网卡驱动，默认驱动为`Monterey`的，若要切换无线网卡驱动，请解压`/EFI/OC/AirportItlwm_v2.1.0_stable_BigSur.kext.zip`或者`/EFI/OC/AirportItlwm_v2.1.0_stable_Monterey.kext.zip`直接替换`/EFI/OC/Kexts/AirportItlwm.kext`即可
* 修复`HiDIP`分辨率设置过高会，开盖会花屏的问题，现在没有设置分辨率的限制，建议设置参数为`1680x1120 1500x1000 1350x900`，[设置方法](#hidip-设置方法)
* 修复`Monterey`Cpu无法硬解的问题
* 修复`HDMI`黑屏问题，支持热插拔

-2020/04/25  此次更新使用[Matebook_13_14_2020_Hackintosh_OpenCore](https://github.com/Zero-zer0/Matebook_13_14_2020_Hackintosh_OpenCore)项目path补丁和kext，理论此CLOVER可以支持Matebook14 2020款机器。本人Matebook14 2019使用[Matebook_13_14_2020_Hackintosh_OpenCore](https://github.com/Zero-zer0/Matebook_13_14_2020_Hackintosh_OpenCore)所有功能正常，建议使用OpenCore启动，对[Zero-zer0](https://github.com/Zero-zer0)贡献表示感谢。

-2020/02/29  更新CLOVER 5104，AirportBrcmFixup 2.0.6，AppleALC 1.4.6，CPUFriden 1.2.0，Lilu 1.4.1，NoTouchID 1.0.3，NullEthernet 1.0.6，WhateverGreen 1.3.6，新增[IntelBluetoothFirmware ](https://github.com/zxystd/IntelBluetoothFirmware)补丁解决冷启动无法加载蓝牙问题，以上均在Catilina 10.15.3通过测试

-2019/12/20  更新CLOVER为5101，修复HDMI/HDMI音频，新增Catalina2K/4K两套主题，添加蓝牙热启动脚本需配合Fusion虚拟机和TinyCoreLinux使用，新增10.15蓝牙[补丁](/蓝牙补丁)，测试10.14/10.15均工作正常

-2019/06/30  更新CLOVER为4972

-2019/06/29  更新I2C、新增HUAWEI主题，更新后请用Kext Utility.app重建缓存(tools目录下)、添加修改USB WIFI图标及汉化

-2019/05/26  HDMI驱动、添加IMEI补丁解决唤醒应用卡死,QiuckPlayer不能录屏、升级CLOVER为4934、更新other/kext驱动、去掉config.plis无用代码

### 已经驱动
* CPU睿频
* 唤醒
* 录音
* 扬声器/耳麦
* 触摸板/手势
* USB3.0/2.0
* HiDPI
* HDMI正常
* 蓝牙
* WIFI(INTEL无线网卡)

### 无法驱动：
* Camera
* MX250及其他规格独立显卡

### 补充说明
* HiDIP 用RDM切换,[设置方法](#hidip-设置方法)见下面
* config.plis默认机型为 Macbookpro15,2 可自行使用工具生成新的序列号，不建议修改机型

### 准备工具
* 8G U盘
* [WePE](http://www.wepe.com.cn/)
* [苹果镜像](blog.daliansky.net)

## 双系统无损安装要点：
* 先安装Windows11系统，并备份Windows的引导EFI分区的（EFI/Boot和Microsoft）
* 调整EFI分区，使用DiskGenius将EFI分区调整为200M（没有则新建EFI分区，新建类型一定要选择EFI分区类型），可以将多余MSR分区删掉（强迫症）。EFI分区一般放在硬盘最前面，硬盘前端没有空间就先移动系统分区使硬盘前端有200M空间再新建或者调整。因为MAC系统安装必须满足EFI分区大于200M才可以
* 新建MAC系统分区，这个步骤非常重要，如果不新建在一下个步骤安装MAC就只能整盘格式化，创建MAC分区是无损安装的核心。根据个人要求调整好Windows系统和其他分区，再将剩余硬盘空间全部新建为苹果分区，新建任选MAC类型分区格式都可以（此处我选择的是HFS+）。这样下一个步骤去安装MAC系统就能识别到苹果分区，从而不需要格式整个硬盘
* 安装MAC系统，系统安装完成后替换EFI分区的`EFI`文件夹

### 安装过程
* 调整硬盘分区，U盘刻录WePE(已制作好PE盘跳过)
* USB接入制作好的PE盘，重启机器在LOGO界面按F12进行Boot Menu 选择从U盘启动
* 进PE系统使用傲梅助手对机器硬盘调整（以Matebook14为例，将原厂硬盘分为EFI 100M,MSR 16M，Windows 80G调整为EFI 200M,MSR 16M,Windows保持不变）
* 打开DiskGenius在硬盘最后端，新建苹果HFS+（建议分区分配120G）此步骤非常重要，如不建立HFS+分区进入mac安装磁盘工具出现无法抹盘，这是无损安装双系统的关键，不格盘安装
* 回WIN，将U盘刻录苹果安装镜像，镜像推荐使用黑果小兵最新打包镜像
* 挂载U盘EFI分区，替换U盘EFI分区内的`EFI`文件夹
  ```cmd
  diskpart
  list disk           # 磁盘列表
  select disk n       # 选择U盘EFI分区所在的磁盘，n为磁盘号
  list partition      # 磁盘分区列表
  select partition n  # 选择EFI分区，n为EFI分区号
  set id="ebd0a0a2-b9e5-4433-87c0-68b6b72699c7"	# 设置为EFI分区
  assign letter=X     # x为EFI分区盘符
  ```

* 进BIOS，改语言改为中文，找到安全启动和软件安全芯片两个项目关闭。
* 开机按F12 选择从U盘启动，开始安装
* 完成安装后，将CLOVER复制到硬盘EFI分区(进入Mac系统后，挂载EFI分区，复制U盘EFI分区的`OC`文件夹和`BOOT`文件夹到挂载的硬盘`EFI`分区

### HiDIP 设置方法
* 使用HiDIP脚本进行设置 [Github](https://github.com/xzhih/one-key-hidpi) ，选择开启HiDPI（不注入EDID），图标自选，自定义几个3:2的分辨率，如1680x1120 1500x1000 1350x900等

### 声卡偶尔外放出现噪音的解决方法
* 偶尔外放播放出现底噪[声音沙哑]问题，进入声音设置->声音控制偏好->将输入与输出选项进行切换一下即可恢复外放正常播放

### 写在最后
* `OpenCore`版本不是最新就最好，合适的版本达到稳定即可，若要升级`OpenCore`版本推荐使用，[OCAuxiliaryTools](https://github.com/ic005k/OCAuxiliaryTools/blob/master/READMe-cn.md)
* [截图](./Screenshots/)请看这里

### 教程结束
