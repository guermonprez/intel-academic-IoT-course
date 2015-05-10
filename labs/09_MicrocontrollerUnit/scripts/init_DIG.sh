#!/bin/sh
#author: David Pierret (davidx.pierret@intel.com)
#this script setup Edison/Arduino board to use DIG0 to DIG13 as GPIOs
#
#history
#
# V1 : only use debugfs for SoC gpios
# V2 : only use sysfs for SoC gpios
# V3 : use both debugfs and sysfs for SoC gpios
# V4 : correction of bugs.

DIG=""
DIR=""

usage() {
echo "usage $0 -o [num] -d [direction]" >&2
echo "work only on build edison-latest-99-2014-07-16_14-39-50 and next"
echo "num : number of the digital output 0->13" >&2
echo "direction : 'input' or 'output'" >&2
exit 1
}

export_gpio() {
	if [ $# -ne 1 ]; then
		echo "erreur appel fonction $0"
		exit 2
	fi
	if [ ! -d /sys/class/gpio/gpio$1 ]; then
		echo $1 > /sys/class/gpio/export
	fi
}

while getopts "o:(output)d:(direction)" optname
	do
		case "$optname" in
        "o")
			DIG=$OPTARG
          ;;
        "d")
			DIR=$OPTARG
          ;;
        "?")
			usage
          ;;
        ":")
			usage
          ;;
        *)
        # Should not occur
          echo "Unknown error while processing options"
          ;;
		esac
	done

echo "DIG = $DIG"
echo "DIR = $DIR"
# check the dig number var
if [ ! "$DIG" -ge 0 -a "$DIG" -le 13 ]; then
	usage
fi
# check the direction var
if [ "$DIR" != "output" -a "$DIR" != "input" ]; then
	usage
fi

export_gpio 214

echo low > /sys/class/gpio/gpio214/direction

case $DIG in
#gp130 to DIG0
0)
	export_gpio 248
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio130/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio248/direction #config as output
		echo out > /sys/class/gpio/gpio130/direction
	else
		echo low > /sys/class/gpio/gpio248/direction #config as input
		echo in > /sys/class/gpio/gpio130/direction
	fi
;;

#gp131 to DIG1
1)
	export_gpio 249
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio131/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio249/direction #config as output
		echo out > /sys/class/gpio/gpio131/direction
	else
		echo low > /sys/class/gpio/gpio249/direction #config as input
		echo in > /sys/class/gpio/gpio131/direction
	fi
;;

#gp128 to DIG2
2)
	export_gpio 250
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio128/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio250/direction #config as output
		echo out > /sys/class/gpio/gpio128/direction
	else
		echo low > /sys/class/gpio/gpio250/direction #config as input
		echo in > /sys/class/gpio/gpio128/direction
	fi
;;

#gp12 to DIG3
3)
	export_gpio 251
	export_gpio 12
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio12/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio251/direction #config as output
		echo out > /sys/class/gpio/gpio12/direction
	else
		echo low > /sys/class/gpio/gpio251/direction #config as input
		echo in > /sys/class/gpio/gpio12/direction
	fi
;;

#gp129 to DIG4
4)
	export_gpio 252
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio129/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio252/direction #config as output
		echo out > /sys/class/gpio/gpio129/direction
	else
		echo low > /sys/class/gpio/gpio252/direction #config as input
		echo in > /sys/class/gpio/gpio129/direction
	fi
;;

#gp13 to DIG5
5)
	export_gpio 253
	export_gpio 13
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio13/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio253/direction #config as output
		echo out > /sys/class/gpio/gpio13/direction
	else
		echo low > /sys/class/gpio/gpio253/direction #config as input
		echo in > /sys/class/gpio/gpio13/direction
	fi
;;

#gp182 to DIG6
6)
	export_gpio 254
	export_gpio 182
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio182/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio254/direction #config as output
		echo out > /sys/class/gpio/gpio182/direction
	else
		echo low > /sys/class/gpio/gpio254/direction #config as input
		echo in > /sys/class/gpio/gpio182/direction
	fi
;;

#gp48 to DIG7
7)
	export_gpio 255
	export_gpio 48
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio48/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio255/direction #config as output
		echo out > /sys/class/gpio/gpio48/direction
	else
		echo low > /sys/class/gpio/gpio255/direction #config as input
		echo in > /sys/class/gpio/gpio48/direction
	fi
;;

#gp49 to DIG8
8)
	export_gpio 256
	export_gpio 49
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio49/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio256/direction #config as output
		echo out > /sys/class/gpio/gpio49/direction
	else
		echo low > /sys/class/gpio/gpio256/direction #config as input
		echo in > /sys/class/gpio/gpio49/direction
	fi
;;

#gp183 to DIG9
9)
	export_gpio 257
	export_gpio 183
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio183/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio257/direction #config as output
		echo out > /sys/class/gpio/gpio183/direction
	else
		echo low > /sys/class/gpio/gpio257/direction #config as input
		echo in > /sys/class/gpio/gpio183/direction
	fi
;;

#gp41 to DIG10
10)
	export_gpio 258
	export_gpio 240
	export_gpio 263
	echo low > /sys/class/gpio/gpio240/direction
	echo high > /sys/class/gpio/gpio263/direction

	if [ ! -d /sys/class/gpio/gpio41 ]; then
		echo 41 > /sys/class/gpio/export
	fi
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio41/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio258/direction #config as output
		echo out > /sys/class/gpio/gpio41/direction
	else
		echo low > /sys/class/gpio/gpio258/direction #config as input
		echo in > /sys/class/gpio/gpio41/direction
	fi
;;

#gp43 to DIG11
11)
	export_gpio 259
	export_gpio 241
	export_gpio 262
	export_gpio 43
	echo low > /sys/class/gpio/gpio241/direction
	echo high > /sys/class/gpio/gpio262/direction
	
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio43/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio259/direction #config as output
		echo out > /sys/class/gpio/gpio43/direction
	else
		echo low > /sys/class/gpio/gpio259/direction #config as input
		echo in > /sys/class/gpio/gpio43/direction
	fi
;;

#gp42 to DIG12
12)
	export_gpio 260
	export_gpio 242
	export_gpio 42
	echo low > /sys/class/gpio/gpio242/direction
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio42/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio260/direction #config as output
		echo out > /sys/class/gpio/gpio42/direction
	else
		echo low > /sys/class/gpio/gpio260/direction #config as input
		echo in > /sys/class/gpio/gpio42/direction
	fi
;;

#gp40 to DIG13
13)
	export_gpio 261
	export_gpio 243
	export_gpio 40
	echo low > /sys/class/gpio/gpio243/direction
	echo mode0 > /sys/kernel/debug/gpio_debug/gpio40/current_pinmux
	if [ $DIR == "output" ]; then
		echo high > /sys/class/gpio/gpio261/direction #config as output
		echo out > /sys/class/gpio/gpio40/direction
	else
		echo low > /sys/class/gpio/gpio261/direction #config as input
		echo in > /sys/class/gpio/gpio40/direction
	fi
;;
*) 
	usage
;;
esac

echo high > /sys/class/gpio/gpio214/direction

