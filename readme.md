# Matebook 14 黑苹果教程
>记录Matebook14黑苹果过程，无损完成单硬盘MAC和Windows双系统

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

-2019/12/20  更新CLOVER为5101，修复HDMI/HDMI音频，新增Catalina2K/4K两套主题，添加蓝牙热启动脚本需配合Fusion虚拟机和TinyCoreLinux使用，新增10.15蓝牙[补丁](/蓝牙补丁)，测试10.14/10.15均工作正常

-2019/06/30  更新CLOVER为4972

-2019/06/29  更新I2C、新增HUAWEI主题，更新后请用Kext Utility.app重建缓存(tools目录下)、添加修改USB WIFI图标及汉化

-2019/05/26  HDMI驱动、添加IMEI补丁解决唤醒应用卡死,QiuckPlayer不能录屏、升级CLOVER为4934、更新other/kext驱动、去掉config.plis无用代码

### 已经驱动
* CPU睿频
* 睡眠/合盖一晚测试掉电0%
* 唤醒
* 录音
* 扬声器/耳机可自动切换
* 触摸板/手势
* USB3.0/2.0
* HiDPI 1340*894
* HDMI正常
* 蓝牙/热启动

###  目前不完善
* Intel蓝牙工作正常，正常关闭开启（替换S/L/E IOBluetoothFamily.kext）,冷启动需要配合虚拟机热启动蓝牙[参考教程](http://bbs.pcbeta.com/viewthread-1807726-1-3.html)
* 开启HiDIP分辨率最高设置1340*894，超过900分辨率唤醒会花屏
* 亮度调节按键无效，但可以通过修改显示器快捷键，设置 - 键盘 - 快捷键 - 显示器 修改快捷键为F1 F2，若设置页面没有显示器选项，接入USB键盘后则可以出现显示器选项
* Camera

### 无法驱动：
* WIFI -- 偶然看到小新pro13(网卡[AX201NGW](https://www.intel.cn/content/www/cn/zh/products/docs/wireless/wi-fi-6-ax201-module-brief.html)M.2: CNVio2接口)更换BCM94360CS2并在Windows成功驱动[帖子链接](https://post.smzdm.com/p/aqnlz47p/)，Matebook 14需要验证是否可行，详细资料看补充说明
* MX250

### 补充说明
* 耳机扬声器切换有底噪或遭遇的请自行打去底噪补丁，[设置方法](#声卡切换底噪睡眠唤醒有噪音解决)见下
* HiDIP 用RDM切换,[设置方法](#hidip-设置方法)见下面
* config.plis默认机型为 Macbookpro15,2 使用请自行使用CloveConfigurator生成新的序列号
* 使用蓝牙补丁IOBluetoothFamily.kext替换S/L/E系统自带驱动，解决热启动蓝牙无法关闭问题，替换后重建缓存，从Win热启动或者使用虚拟机热启动蓝牙
* 10.15需要先获取权限后才能修改系统文件，获取权限命令如下，重启后需要重新获取：
```cmd
sudo -s                # 获取超级权限，并输入密码
sudo mount -o rw /     # 获取系统读写权限
killall Finder         # 重启启动Finder
```
* 更换网卡方案参考资料 M2(NGFF)[接口定义](https://blog.csdn.net/greless/article/details/51698662),Matebook 14 网卡使用M.2 E键，接口定义内有一组PCIe x2通道，如果这一组PCIe x2通道存，是可以驱动BCM94360CS2、DW1820A等网卡

### 准备工具
* 8G U盘
* [WePE](http://www.wepe.com.cn/)
* [苹果镜像](blog.daliansky.net)

## 双系统无损安装要点：
* 先安装Windows系统，并备份Windows的引导EFI分区的（EFI/Boot和Microsoft）
* 调整EFI分区，使用DiskGenius将EFI分区调整为200M（没有则新建EFI分区，新建类型一定要选择EFI分区类型），可以将多余MSR分区删掉（强迫症）。EFI分区一般放在硬盘最前面，硬盘前端没有空间就先移动系统分区使硬盘前端有200M空间再新建或者调整。因为MAC系统安装必须满足EFI分区大于200M才可以
* 新建MAC系统分区，这个步骤非常重要，如果不新建在一下个步骤安装MAC就只能整盘格式化，创建MAC分区是无损安装的核心。根据个人要求调整好Windows系统和其他分区，再将剩余硬盘空间全部新建为苹果分区，新建任选MAC类型分区格式都可以（此处我选择的是HFS+）。这样下一个步骤去安装MAC系统就能识别到苹果分区，从而不需要格式整个硬盘
* 安装MAC系统，系统安装完成后替换EFI分区的CLOVER
* 重启系统重建缓存

### 安装过程
* 调整硬盘分区，U盘刻录WePE(已制作好PE盘跳过)
* USB接入制作好的PE盘，重启机器在LOGO界面按F12进行BOOT MEUN 选择从U盘启动
* 进PE系统使用傲梅助手对机器硬盘调整（以Matebook14为例，将原厂硬盘分为EFI 100M,MSR 16M，Windows 80G调整为EFI 200M,MSR 16M,Windows保持不变）
* 打开DiskGenius在硬盘最后端，新建苹果HFS+（建议分区分配120G）此步骤非常重要，如不建立HFS+分区进入mac安装磁盘工具出现无法抹盘，这是无损安装双系统的关键，不格盘安装
* 回WIN，将U盘刻录苹果安装镜像，镜像推荐使用黑果小兵最新打包镜像
* 挂载U盘EFI分区，替换CLOVER，WIN+R 打开命令行，按下命令操作挂载分区，替换掉U盘EFI分区原CLOVER文件夹，若不熟悉命令也可使用DiskGenius给U盘分配盘符
  ```cmd
  diskpart
  list disk           # 磁盘列表
  select disk n       # 选择U盘EFI分区所在的磁盘，n为磁盘号
  list partition      # 磁盘分区列表
  select partition n  # 选择EFI分区，n为EFI分区号
  set id="ebd0a0a2-b9e5-4433-87c0-68b6b72699c7"	# 设置为EFI分区
  assign letter=X     # x为EFI分区盘符
  ```
* 不使用镜像黑果小兵的CLOVER(缺少驱动或者config.plis配置不对)省掉跑代码直接进入安装，安装过程参照 黑果小兵 小新Air macOS Mojave安装过程 [LINK](https://blog.daliansky.net/Lenovo-Xiaoxin-Air-13-macOS-Mojave-installation-tutorial.html)

* 进BIOS，改语言改为中文，找到安全启动和软件安全芯片两个项目关闭。
* 开机按F12 选择从U盘启动，开始安装
* 完成安装后，将CLOVER复制到硬盘EFI分区，mac系统使用CloveConfigurator挂载EFI分区，WIN同上步骤
* 设置HiDIP，备份S/L/E系统驱动IOBluetoothFamily.kext并补丁进行替换，重建缓存
* 教程结束

### HiDIP 设置方法
* 使用HiDIP脚本进行设置 [Github](https://github.com/xzhih/one-key-hidpi)  
* 复制 **DisplayVendorID-dae** 和 **Icons.plist** 到 **/系统/资源库/Displays/Contents/Resources/Overrides/**  
* 使用DRM切换到1340*894分辨率  
![img](/HiDPI/01.png)
![img](/HiDPI/02.png)
![img](/HiDPI/03.png)
![img](/HiDPI/04.png)

### 声卡切换底噪，睡眠唤醒有噪音解决
给声卡打ALCPlugFix 修复耳机切换底噪问题
![img](/ALC256_ALCPlugFix/01.png)

### 更改USB WIFI图标及汉化
效果
![img](/usb-wifi/wifi-icns.png)

1、拷贝dark(暗色图标)或者light(浅色图标)文件夹内文件到 /资源库/Application Support/WLAN/StatusBarApp.app(显示包内容)/Contents/Resources 替换原图标，退出登录即可生效
![img](/usb-wifi/wifi-icns-1.png)

2、汉化WIFI语言，同上将lang-cn下Localizable.strings 文件拷贝到 /资源库/Application Support/WLAN/StatusBarApp.app(显示包内容)/Contents/Resources/English.lproj 替换原文件，退出登录即可生效
![img](/usb-wifi/wifi-lang-cn.png)

### 教程结束
