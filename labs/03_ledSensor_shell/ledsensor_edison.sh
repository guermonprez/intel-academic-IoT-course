#! /bin/bash

#
echo "214" > /sys/class/gpio/export


# Initializing analog input A0
echo "200" > /sys/class/gpio/export   
echo "232" > /sys/class/gpio/export   
echo "208" > /sys/class/gpio/export   
echo "low" > /sys/class/gpio/gpio214/direction   
echo "high" > /sys/class/gpio/gpio200/direction   
echo "low" > /sys/class/gpio/gpio232/direction   
echo "out" > /sys/class/gpio/gpio208/direction   
echo "261" > /sys/class/gpio/export 2>&1
echo "high" > /sys/class/gpio/gpio261/direction 2>&1
echo "1" > /sys/class/gpio/gpio261/value

# Initializing digital output pin number 7
echo "255" > /sys/class/gpio/export
echo "223" > /sys/class/gpio/export
echo "48" > /sys/class/gpio/export

echo "in" > /sys/class/gpio/gpio233/direction
echo "out" > /sys/class/gpio/gpio255/direction
echo "out" > /sys/class/gpio/gpio48/direction

echo "1" > /sys/class/gpio/gpio255/value
echo "0" > /sys/class/gpio/gpio48/value

#
echo "high" > /sys/class/gpio/gpio214/direction  

# Reads the value on A0
sensorvalue=`cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw`

#Infinite loop
echo "sensorvalue $sensorvalue "
while [ $sensorvalue -ge 0 ]
do
	#Print values
	echo "sensorvalue $sensorvalue "

	#if value > 600 do LED on
	if [ $sensorvalue -le 2000 ] 
		then echo -n "0" > /sys/class/gpio/gpio48/value 
		else  echo -n "1" > /sys/class/gpio/gpio48/value
	fi

	sensorvalue=`cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw`

	#Wait 200ms
	usleep 200000 
done 

echo "200" > /sys/class/gpio/unexport   
echo "232" > /sys/class/gpio/unexport   
echo "208" > /sys/class/gpio/unexport   
echo "255" > /sys/class/gpio/unexport
echo "223" > /sys/class/gpio/unexport
echo "48" > /sys/class/gpio/unexport



