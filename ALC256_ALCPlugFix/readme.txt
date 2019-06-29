1.如果遇到外放有声,耳机无声，双击ALCPluginFix中的install双击自动安装.command
2.最后记得重建缓存：
sudo rm -rf /System/Library/Caches/com.apple.kext.caches/Startup/kernelcache
sudo rm -rf /System/Library/PrelinkedKernels/prelinkedkernel
sudo touch /System/Library/Extensions/ && sudo kextcache -u /