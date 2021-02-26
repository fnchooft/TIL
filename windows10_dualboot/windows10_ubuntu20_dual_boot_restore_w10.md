# Installing Ubuntu 20.04 - next to Windows 10

*Date:* 20210225T2000

*Credits:* All authors of the links below

## Installation Steps
After receiving a new Dell laptop from the office, I installed Ubuntu 20.04.

0. Enter into windows - update all Dell drivers / BIOS etc
   * BTW: This takes forever.....

1. Windows 10 resize disk for linux

2. Turn off bit-defender

3. In bios (F2 on boot) turn off RAID -> Switch to AHCI

4. Install Linux on free space from Step1 ( Custom install)

5. Reboot machine - and run linux, all seems fine.

## Windows won't start
After the installation I wanted to check the pre-existing Windows10 installation
and selected Windows Boot Manager, only to see the 
infamous *INACCESSIBLE_BOOT_DEVICE* screen.


## How to fix
Following the instruction from the first link!

The issue I had was that in AHCI mode, Ubuntu booted and worked normally but 
Windows did not boot at all. 

Then I switched to RAID and noticed that Windows booted and worked normally 
but Ubuntu did not boot at all.

The problem was that I had switched from RAID to AHCI 
without safe mode in Windows. 

When I applied the same switch but in safe mode everything worked fine.

## Links
- https://gist.github.com/chenxiaolong/4beec93c464639a19ad82eeccc828c63
- https://superuser.com/questions/1280141/switch-raid-to-ahci-without-reinstalling-windows-10/1359471#1359471
- https://askubuntu.com/questions/1158175/windows-10-inaccessible-boot-device-after-dual-boot-ubuntu-18-04-installation


