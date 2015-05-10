# Reset all gpios value to 0
# and unexport then

for NUMBER in {0..60}
do
	echo -n "0" > /sys/class/gpio/gpio$NUMBER/value
	echo -n "$NUMBER" > /sys/class/gpio/unexport
done



