# Huawei Matebook 14 黑苹果教程
>记录Matebook14 黑苹果过程，实现单硬盘MAC和Windows双系统

### 机型配置信息
| 项目 | 详细参数|
| :--: | :-------------------- |
| 型号 | Matebook 14    |
| CPU  | Whiskey Lake i5 8265u |
|内存| DDR3L 8G|
| 显卡 | UHD620@MX250|
| 硬盘 | 西数 SN720 512G|
| 声卡 | Realtek ALC256 |
|LCD| 2160*1440|

### 已经驱动
```
CPU睿频
睡眠/盒盖一晚测试掉电0%
唤醒
录音
扬声器/耳机可自动切换
触摸板/手势
USB3.0/2.0
HiDIP 1340*894
```
###  目前不完善
```
蓝牙无法关闭，不能连接华为赠送的鼠标
开启HiDIP分辨率最高设置1340*894
亮度调节按键无效，但可以通过修改显示器快捷键，设置 - 键盘 - 快捷键 - 显示器 修改快捷键为F1 F2
HDMI未测试
Camera
```
### 无法驱动：
```
WIFI
MX250
```
### 补充说明
1、耳机扬声器切换有底噪或遭遇的请自行打去底噪补丁，设置方法见下
2、HiDIP 用RDM切换,设置方法见下面
3、config.plis默认机型为 Macbookpro15,2 额外提供了 Macbookpro14,3 睿频文件和config.plis，切换自行替换CLVOER - kexts - Other内CPUFriendDataProvider.kext
4、Macbookpro14,3 配置文件跑分比Macbookpro14,3 配置文件高600左右，因为CPU最低工作主频为1.2G功耗略高Macbookpro15,2配置文件
5、Macbookpro15,2 CPU最低工作主频为800M，两个高频无差异

### 准备工具
* 8G U盘
* [WePE](http://www.wepe.com.cn/)
* [苹果镜像](blog.daliansky.net)
### 安装过程
* 调整硬盘分区，U盘刻录WePE，关机进PE系统对进行硬盘调整，Matebook14原厂硬盘分为EFI 100M,MSR 16M，Windows 80G。目标EFI 200M,MSR 16M,Windows保持不变，新建苹果HFS+ 分区分配120G
* 回Window10，U盘刻录苹果安装镜像，镜像使用黑果小兵最新打包镜像
* 挂载U盘EFI分区，替换CLOVER，WIN+R 打开命令行，按下命令操作挂载分区，替换掉U盘原CLOVER文件夹，不用原镜像CLOVER(缺少驱动或者config.plis配置不对)省掉跑代码直接进入安装，安装过程参照 黑果小兵 小新Air安装过程 [LINK](https://blog.daliansky.net/Lenovo-Xiaoxin-Air-13-macOS-Mojave-installation-tutorial.html)
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
* 安装完成，重复上述步骤3，将CLOVER复制到硬盘EFI分区
* 设置HiDIP，完善还未驱动的硬件
* 教程结束

### HiDIP 设置方法
* 使用HiDIP脚本进行设置 [Github](https://github.com/xzhih/one-key-hidpi)<br>
* 复制 **DisplayVendorID-dae** 和 **Icons.plist** 到 **[/系统/资源库/Displays/Contents/Resources/Overrides/]()**<br>
* 使用DRM切换到1340*894分辨率
![img](/HiDPI/01.png)
![img](/HiDPI/02.png)
![img](/HiDPI/03.png)
![img](/HiDPI/04.png)

### 声卡切换底噪，睡眠唤醒有噪音解决
给声卡打ALCPlugFix
![img](/ALC256修复耳机切换底噪问题/01.png)