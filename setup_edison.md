# Custom setup procedure for Intel Edison

## Before you start

### Video

A video recording of the setup procedure is available, with additional comments. check this youtube playlist :
https://www.youtube.com/playlist?list=PLFBM-eCNdj6A5VSmOEjpn8XoiM88398B7

### Command line vs IDEs

The goal of this procedure is to use Intel Edison as a linux board directly, using command line without any other IDE. But you don't have to. It's advanced mode if you're familiar with linux and love command line.

Instead of command line, you can also use the graphical user interfaces from :
* Intel IoT SDK : https://software.intel.com/en-us/iot/downloads
* Intel XDK for IoT Edition : https://software.intel.com/en-us/html5/xdk-iot

You have a similar procedure for Intel Galileo in the same folder.

### OS for setup, OS for development

In this setup procedure, we'll use a linux PC with ubuntu 15.04. But you can work from MS Windows, OSX or any other linux distro for the setup.

After the initial setup procedure, we'll be able to connect to the board over the network very easily from any OS for software development.

### Download the Intel Edison firmware

Intel Edison® Board Firmware Software Release 2.1
http://www.intel.com/support/edison/sb/CS-035180.htm

## PC setup and flash

### PC setup

On your linux PC, launch a terminal ```with ctrl-alt-T```
then login as root, update the packages and install dfu-util :
```
sudo so
cd
apt-get update
apt-get upgrade
apt-get install dfu-util
```

### Unpack the Intel Edison image and start flashing

(replace XX-XX with your specific filename).
```
mkdir edison-image
cd edison-image
unzip /home/paul/Downloads/edison-image-wwXX-XX.zip
./flashall.sh
```

### Plug the board 

* plug the board as described in the video
* see progress of the flash script
* notice the "edison" disk appearing.

### Serial PC-Edison connection

For your information, we have a new serial-over-USB port appearing, we could use screen to open a connection :
```
ls /dev/tty*
apt-get install screen
screen /dev/ttyUSB0 115200
```
* type enter twice
* Ctrl-D to logoff
* Ctrl-A Ctrl-A to break serial link

### Serial PC-Edison connection

We won't use the serial link, and focus on the faster network-over-USB instead :
```
ifconfig
ifconfig usb0 192.168.2.1/24
ssh 192.168.2.15
```

## Edison initial configuration

### configure_edison script

Set the password and connect to your WiFi network.
```
configure_edison --setup
ifconfig
```
Note the IP address.
You can ask for a clean shutdown with ```shutdown now```
(If it's rebooting instead of a clean shutdown, just unplug the USB cables in the middle of the reboot procedure).

### ssh

As a regular user (root is not required) on your laptop, make sure you are connected to the same wifi network as Edison and ssh to your board :
```ssh root@X.X.X.X```
The IP address was given by the previous script. (or your wifi router DHCP table).

Answer yes, notice the password was asked this time

Check version with ```configure_edison --version```

### Install package sources and update
On Ubuntu we have apt-get, and on Yocto we have opkg.
```
echo "src/gz all http://repo.opkg.net/edison/repo/all" > /etc/opkg/base-feeds.conf
echo "src/gz edison http://repo.opkg.net/edison/repo/edison" >> /etc/opkg/base-feeds.conf
echo "src/gz core2-32 http://repo.opkg.net/edison/repo/core2-32" >> /etc/opkg/base-feeds.conf
echo "src mraa-upm http://iotdk.intel.com/repos/2.0/intelgalactic" > /etc/opkg/mraa-upm.conf
opkg update
```
Please do NOT run ```opkg upgrade``` as it would try to update the kernel and probably fail.

### install packages from the repository
```
opkg install nano vim screen diffutils
opkg install mraa upm
opkg install libusb-1.0-dev flex bison git
opkg install opencv opencv-dev opencv-apps
opkg install libopencv-core-dev libopencv-core2.4 libopencv-calib3d-dev libopencv-calib3d2.4 libopencv-contrib-dev libopencv-contrib2.4 libopencv-features2d-dev libopencv-features2d2.4 libopencv-flann-dev libopencv-flann2.4 libopencv-gpu-dev libopencv-gpu2.4 libopencv-imgproc-dev libopencv-imgproc2.4 libopencv-legacy-dev libopencv-legacy2.4 libopencv-ml-dev libopencv-ml2.4 libopencv-nonfree-dev libopencv-nonfree2.4 libopencv-photo-dev libopencv-photo2.4 libopencv-stitching-dev libopencv-stitching2.4 libopencv-superres-dev libopencv-superres2.4 libopencv-video-dev libopencv-video2.4 libopencv-videostab-dev libopencv-videostab2.4  libopencv-highgui-dev  libopencv-highgui2.4 libopencv-objdetect2.4 libopencv-objdetect-dev opencv-staticdev
opkg install alsa-server alsa-lib-dev alsa-dev alsa-utils-aconnect alsa-utils-speakertest alsa-utils-midi libsndfile-bin libsndfile-dev
```

## NodeJS configuration

### install NodeJS packages
NodeJS has a special package management tool called npm.
It's slow compared to opkg, as everything is compiled from sources.
You don't need to install everything, only the first 6 lines are required for the first labs.
```
npm cache clear
npm update
npm install -g mraa
npm install -g iotkit iotkit-agent iotkit-comm
npm install -g sleep
npm install -g cylon
npm install -g cylon-intel-iot
npm install -g cylon-intel-iot-analytics
npm install -g cylon-api-http
npm install -g cylon-api-mqtt
npm install -g cylon-api-socketio
npm install -g cylon-ble
npm install -g cylon-gpio
npm install -g cylon-i2c
npm install -g cylon-joystick
npm install -g cylon-keyboard
npm install -g cylon-leapmotion
npm install -g cylon-mqtt
npm install -g cylon-neurosky
npm install -g cylon-opencv
npm install -g cylon-speech
npm install -g midi
npm install -g smoothie
npm install -g temporal
npm install -g bleno
npm install -g noble
npm install -g bluetooth-obd
npm install -g browserify
npm install -g cli
npm install -g rolling-spider
npm install -g sleep
```

AFTER you installed your packages, you can upgrade nodejs :
```
opkg install nodejs nodejs-npm nodejs-dev
```

## Advanced settings

### Password less login

From your workstation :
```
ssh-keygen
cat .ssh/id_rsa.pub
```
Copy to edison :
```
ssh root@X.X.X.X
mkdir .ssh
chmod go-rwx .ssh
nano .ssh/authorized_keys2
```
Paste, save, exit, retry ssh and notice the lack of password

You can now go to the labs.











