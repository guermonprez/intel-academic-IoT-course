#!/bin/sh
#based on exemple from GSG_GPIO_PinMux_Control_FabB.pdf Intel internal document.
#exporting TRI_STATE_ALL
if [ ! -d /sys/class/gpio/gpio214 ]; then
	echo 214 > /sys/class/gpio/export
fi
echo low > /sys/class/gpio/gpio214/direction
#PWM 0 to DIG3
echo 251 > /sys/class/gpio/export
echo 219 > /sys/class/gpio/export
echo high > /sys/class/gpio/gpio251/direction
echo in > /sys/class/gpio/gpio219/direction

#PWM 1 to DIG5
echo 253 > /sys/class/gpio/export
echo 221 > /sys/class/gpio/export
echo high > /sys/class/gpio/gpio253/direction
echo in > /sys/class/gpio/gpio221/direction

#PWM 2 to DIG6
echo 254 > /sys/class/gpio/export
echo 222 > /sys/class/gpio/export
echo high > /sys/class/gpio/gpio254/direction
echo in > /sys/class/gpio/gpio222/direction

#PWM 3 to DIG9
echo 257 > /sys/class/gpio/export
echo 225 > /sys/class/gpio/export
echo high > /sys/class/gpio/gpio257/direction
echo in > /sys/class/gpio/gpio225/direction

#PWM 4 to DIG10 (PWM2)
#echo 263 > /sys/class/gpio/export
#echo 258 > /sys/class/gpio/export
#echo 225 > /sys/class/gpio/export
#echo high > /sys/class/gpio/gpio214/direction
#echo high > /sys/class/gpio/gpio263/direction
#echo high > /sys/class/gpio/gpio258/direction
#echo in > /sys/class/gpio/gpio226/direction
#echo mode1 > /sys/kernel/debug/gpio_debug/gpio182/current_pinmux
#echo low > /sys/class/gpio/gpio214/direction
#echo 2 > /sys/class/pwm/pwmchip0/export

echo high > /sys/class/gpio/gpio214/direction
