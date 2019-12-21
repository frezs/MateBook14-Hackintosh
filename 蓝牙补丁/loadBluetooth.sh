#!/bin/sh
refw=`system_profiler SPBluetoothDataType | grep "Firmware Version"`

echo $refw
if [ -z "$refw" ] # 无固件$refw为空，判断$refw长度是否为0，为0即没有读取到蓝牙
then
	# 未检出到蓝牙固件，开启虚拟机上传固件
    echo "Bluetooth Firmware not present. Starting vm!"
    echo "未检出到蓝牙固件，开启虚拟机上传固件!!!"
    # 从此路径读取虚拟机以无窗口模式打开
    # 请自行根据虚拟机路径进行需改
    vmrun start "/Volumes/Data/Macintosh/VirtualMachines/TinyCoreLinux.vmwarevm" nogui
    # 等待4S
    sleep 4s
    # 挂起虚拟机
    # 请自行根据虚拟机路径进行需改
    vmrun suspend "/Volumes/Data/Macintosh/VirtualMachines/TinyCoreLinux.vmwarevm"
    echo "蓝牙固件上传完成"
    sleep 1s
    exit
else
	# 固件OK
    echo "Bluetooth Firmware present."
    echo "蓝牙固件正常，退出"
    sleep 1s
    exit
fi
