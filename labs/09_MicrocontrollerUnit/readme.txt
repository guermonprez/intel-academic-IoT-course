# DOCS :
# https://software.intel.com/en-us/node/557354

# download "Microcontroller (MCU) SDK"
# for linux 32 bit.
# remember : it's for edison, not your laptop
# and edison is linux 32bit
# https://software.intel.com/en-us/iot/hardware/edison/downloads

# unpack and transfer on edison the required files
mkdir mcu-sdk
cd mcu-sdk
unzip ../edison-mcusdk-linux32-1.0.10.zip
ssh root@192.168.2.15 mkdir mcu-sdk
# we only copy the toolchain and firmware, nothing else
scp -pr toolchain root@192.168.2.15:~/mcu-sdk/
scp src/mcu_fw.zip root@192.168.2.15:~/mcu-sdk/

# ssh on edison now
ssh root@192.168.2.15

# make sure you have gnu dd from the coreutils pakage,
# not busybox dd provided by default
opkg install coreutils
dd --version

cd labs/09_MicrocontrollerUnit

# update headers and libs from the SDK
unzip -o /home/root/mcu-sdk/mcu_fw.zip
chmod a+x internal_tools/* scripts/*
# edit ./internal_tools/generate_mcu_bin.sh :
# edit LIBDIR and set as lib/ not ../lib/
make clean
make
# the firmware file intel_mcu.bin is now ready

# note : will overwrite default MCU firmware !
# you may want to make a backup from /lib/firmware
make install



# in /etc/intel_mcu/mcu_fw_loader.sh add 2 lines :
# 1. enable pwm power management on linux for the MCU
echo "on" > /sys/devices/pci0000\:00/0000\:00\:17.0/power/control
# 2. launch GPIO config for MCU PWM automatically :
/home/root/labs/09_MicrocontrollerUnit/scripts/init_mcu_PWM.sh

# reboot to reload the MCU firmware

# check the serial comm between linux and the MCU,
# you should see messages about the PWM duty cycle sent
cat /dev/ttymcu1
# if you connect THE POWER SUPPLY
# and a servo on PWM-0, DIGITAL-3,
# the servo should go from minimum to maximum in increments




