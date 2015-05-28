# Custom setup procedure for Intel Galileo v1/v2

## Before you start

### Video

A video recording of the setup procedure is available, with additional comments. Check this youtube playlist : https://www.youtube.com/playlist?list=PLFBM-eCNdj6A5VSmOEjpn8XoiM88398B7

### Command line vs IDEs

The goal of this procedure is to use Intel Edison as a linux board directly, using command line without any other IDE. But you don't have to. It's advanced mode if you're familiar with linux and love command line.

Instead of command line, you can also use the graphical user interfaces from :
* Intel IoT SDK : https://software.intel.com/en-us/iot/downloads
* Intel XDK for IoT Edition : https://software.intel.com/en-us/html5/xdk-iot
* 
You have a similar procedure for Intel Edison in the same folder.

### OS for setup, OS for development
In this setup procedure, we'll use a linux PC with ubuntu 15.04. But you can work from MS Windows, OSX or any other linux distro for the setup.

After the initial setup procedure, we'll be able to connect to the board over the network very easily from any OS for software development.

### glibc 

Most binaries of a typical linux distribution are compiled with glibc.
In the embedded world, there's also eglibc (embedded) and uclibc (small embedded).

That's why you know which library was used to compile the distribution
you use in order to know which binaries and repositories you can install later.

For Galileo, you have the choice between :
* "SD card" official image from Intel.
*  Library : uclibc.
*  Repository : http://repo.opkg.net/galileo/ (community)
* "ubilinux" image from emutex.
*  Library : glibc.
*  Repository : regular i586 Debian repositories.
* "IoT DdevKit" image from Intel Software.
*  Library : eblibc.
*  Repository : http://storage.tokor.org/pub/galileo (managed by Tokoro. Domo arigato Tokoro !)

For this setup, we will use the IoT DevKit image, but without using the dev kit itself.

### Download the image

http://iotdk.intel.com/images/iot-devkit-latest-mmcblkp0.direct.bz2

### Get a SD card

Get a micro SD card, 2Go minimum.

An adapter to read the SD card from your laptop is required. The SD card adapter is best. The USB adapter also works.

### Get a DHCP server

In my case, I'll use a simple home router with DHCP server included.
You need to be able to read the IP addresses assignated from the DHCP server.
Home routers have this option in the admin page.

## Flash the SD card

On your PC :
```
bunzip2 -c iot-devkit-latest-mmcblkp0.direct.bz2
file iot-devkit-latest-mmcblkp0.direct
```
Result : it's a disk dump ! We'll use dd to create the micro SD card.
Be careful with dd : if you dump from the image file to the wrong device, like your hard disk instead of the SD card, you'll wipe your disk.
```
sudo su
fdisk -l
umount /dev/my_device_partition
dd bs=1M if=iot-devkit-latest-mmcblkp0.direct of=/dev/my_device
```
On my PC, I used the SD card port.
The ```/dev/my_device_partition`` was ```/dev/mmcblk0p1```
and ```/dev/my_device``` was ```/dev/mmcblk0```.

## Resize

### Boot your Intel Galileo with the SD card

Boot your galileo with the SD card, check your router DHCP table to get the IP address of your board, then ssh.
```
ssh root@X.X.X.X
```
You're on the board, running linux.

### Resize partition

The image was created with a small partition, but we need to install a lot of packages.
That's why we need to resize the partition and filesystem.
```
df
fdisk /dev/mmcblk0
# in fdisk, delete partition 1
# create new partition starting at 106496 (like the old one), size +2G
# save, quit fdisk, reboot your galileo
```

### Resize partition
The size depends on your SD card. I had a 4G card.
```
resize2fs /dev/mmcblk0p2 2000M
df
```
Freeee space is now available.


## Initial Setup

### Add third party repo with more packages
This one is for eglibc !
```
wget http://storage.tokor.org/pub/galileo/packages/opkg.conf -O /etc/opkg/opkg.conf
rm /etc/opkg/base-feeds.conf
opkg update
```
### Set the date
```
opkg install ntpdate
ntpdate -s fr.pool.ntp.org
date
```
No coin battery is installed on my galileo (you can),
so I need to get the time from a NTP server
each time I boot, or ask a manual update with ntpdate.

### Add packages

```
opkg install nano vim
opkg install libmraa0 upm
opkg install packagegroup-core-buildessential
opkg install libusb-1.0-dev bluez5-dev bluez5 opencv opencv-dev opencv-apps libopencv-core-dev libopencv-core2.4 libopencv-calib3d-dev libopencv-calib3d2.4 libopencv-contrib-dev libopencv-contrib2.4 libopencv-features2d-dev libopencv-features2d2.4 libopencv-flann-dev libopencv-flann2.4 libopencv-gpu-dev libopencv-gpu2.4 libopencv-imgproc-dev libopencv-imgproc2.4 libopencv-legacy-dev libopencv-legacy2.4 libopencv-ml-dev libopencv-ml2.4 libopencv-nonfree-dev libopencv-nonfree2.4 libopencv-photo-dev libopencv-photo2.4 libopencv-stitching-dev libopencv-stitching2.4 libopencv-superres-dev libopencv-superres2.4 libopencv-video-dev libopencv-video2.4 libopencv-videostab-dev libopencv-videostab2.4  libopencv-highgui-dev  libopencv-highgui2.4 libopencv-objdetect2.4 libopencv-objdetect-dev opencv-staticdev libopencv-ts-dev libopencv-ts2.4 alsa-server alsa-lib-dev alsa-dev alsa-utils-aconnect alsa-utils-speakertest alsa-utils-midi alsa-dev libsndfile-bin libsndfile-dev flex bison git espeak i2c-tools libsqlite3-0 sqlite3 apache2 apache2-scripts modphp lirc lirc-dev rsync v4l-utils 
opkg install alsa-dev --force-overwrite alsa-lib-dev
opkg install nodejs
```

### Add NodeJS packages
It may take hours to install everything (npm works with sources), but you don't have to install all the packages if you don't want to wait.
You can also write the commands in a script and launch this script to avoid waiting.
```
npm cache clear
npm install -g mraa
npm install -g cylon-intel-iot cylon cylon-gpio cylon-i2c
npm install -g cylon-mqtt cylon-api-mqtt cylon-neurosky
npm install -g cylon-ble bluetooth-obd
npm install -g bleno
npm install -g midi
npm install -g smoothie browserify 
npm install -g cylon-api-socketio cylon-api-http
npm install -g cylon-opencv
npm install -g cylon-joystick rolling-spider temporal cli
npm install -g sleep
```

### WiFi and bluetooth - Optionnal

If you have a Wifi-BT adapter :
Shutdown, plug the Wifi-BT adapter in the pci express port and boot.
```
systemctl status connman
connmanctl
> enable wifi
> scan wifi
> services
*AO Wired                ethernet_984fee002ec7_cable
```

As we are running galileo over the network,
the wired network is already live and set as autoconnect.
You should see the wifi networks available in the list.
```
> agent on
> connect wifi_c8f7332a01bb_494e54454c5f34_managed_psk
> config wifi_c8f7332a01bb_494e54454c5f34_managed_psk --autoconnect yes --ipv4 dhcp
> services
*AO Wired                ethernet_984fee002ec7_cable
*AR INTEL_4              wifi_c8f7332a01bb_494e54454c5f34_managed_psk
```
Quick connman and check the status :
```
iwconfig
```
The wifi is a backup for the wired network, and the balance is managed by connman.
Unplug the ethernet cable and the wifi will be online. Check router DHCP table for IP address of the Wifi card.

You can now go to the labs section.
