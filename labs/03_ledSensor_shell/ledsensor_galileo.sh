#! /bin/bash

# Initializing digital output pin number 7
echo -n "27" > /sys/class/gpio/export
echo -n "out" > /sys/class/gpio/gpio27/direction
echo -n "strong" > /sys/class/gpio/gpio27/drive
echo -n "0" > /sys/class/gpio/gpio27/value

# Initializing analog input A0
echo -n "37" > /sys/class/gpio/export
echo -n "out" > /sys/class/gpio/gpio37/direction
echo -n "0" > /sys/class/gpio/gpio37/value

# Reads the value on A0
sensorvalue=`cat /sys/bus/iio/devices/iio\:device0/in_voltage0_raw`

#Infinite loop
while [ $sensorvalue -ge 0 ]
do
	#Print values
	echo "sensorvalue $sensorvalue "

	#if value > 600 do LED on
	if [ $sensorvalue -le 2000 ] 
		then echo -n "0" > /sys/class/gpio/gpio27/value 
		else  echo -n "1" > /sys/class/gpio/gpio27/value
	fi

	sensorvalue=`cat /sys/bus/iio/devices/iio\:device0/in_voltage0_raw`

	#Wait 200ms
	usleep 200000 
done 

echo -n "26" > /sys/class/gpio/unexport 
echo -n "37" > /sys/class/gpio/unexport 



