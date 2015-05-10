#! /bin/sh

# Demo Pololu Servo controller connected via USB to Intel Galileo
# Pololu Micro Maestro 6 servos controller
# Nicolas Vailliet
# 01/12/2014
# Pierre Collet
# 10/10/2014

echo "Servo motor demo on Intel Galileo, using channel 0 and 5"

while : 
do
echo "Set target to 4000 on channel 0 and 5"
./bin/set_target 0 992
sleep 1s
./bin/set_target 5 992
sleep 1s
echo "Set target to 8000 on channel 0 and 5"
./bin/set_target 0 2000
sleep 1s
./bin/set_target 5 2000
sleep 1s
done


