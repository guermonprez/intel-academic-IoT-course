echo 28 > /sys/class/gpio/export
echo 27 > /sys/class/gpio/export
echo 204 > /sys/class/gpio/export
echo 205 > /sys/class/gpio/export
echo 236 > /sys/class/gpio/export
echo 237 > /sys/class/gpio/export
echo 14 > /sys/class/gpio/export
echo 165 > /sys/class/gpio/export
echo 212 > /sys/class/gpio/export
echo 213 > /sys/class/gpio/export
if [ ! -d /sys/class/gpio/gpio214 ]; then
	echo 214 > /sys/class/gpio/export
fi
echo high > /sys/class/gpio/gpio214/direction
echo low > /sys/class/gpio/gpio204/direction
echo low > /sys/class/gpio/gpio205/direction
echo in > /sys/class/gpio/gpio14/direction
echo in > /sys/class/gpio/gpio165/direction
echo low > /sys/class/gpio/gpio236/direction
echo low > /sys/class/gpio/gpio237/direction
echo in > /sys/class/gpio/gpio212/direction
echo in > /sys/class/gpio/gpio213/direction
echo mode2 > /sys/kernel/debug/gpio_debug/gpio28/current_pinmux
echo mode2 > /sys/kernel/debug/gpio_debug/gpio27/current_pinmux
