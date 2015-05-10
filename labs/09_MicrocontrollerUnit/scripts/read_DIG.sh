#!/bin/sh
#author: David Pierret (davidx.pierret@intel.com)
#this script setup Edison/Arduino board to use DIG0 to DIG13 as GPIOs

DIG=""
VAL=""

usage() {
echo "usage $0 -o [num]" >&2
echo "init_DIG.sh must be called before"
echo "num : number of the digital input 0->13" >&2
exit 1
}

## set_output [mux] [gpio]
## [mux] gpio to check to control level switcher
## [gpio] gpio number to read
read_input() {
	if [ $# -ne 2 ]; then
		echo "erreur appel fonction $0"
		exit 2
	fi
	if [ ! -d /sys/class/gpio/gpio$1 ]; then
		usage
	fi
	if [ ! $(cat /sys/class/gpio/gpio$1/direction) == "out" ]; then
		usage
	fi
#	cat /sys/kernel/debug/gpio_debug/gpio$2/current_value
	cat /sys/class/gpio/gpio$2/value
}

while getopts "o:(output)" optname
	do
		case "$optname" in
        "o")
			DIG=$OPTARG
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

# check the dig number var
if [ ! "$DIG" -ge 0 -a "$DIG" -le 13 ]; then
	usage
fi

if [ ! -d /sys/class/gpio/gpio214 ]; then
	echo 214 > /sys/class/gpio/export
fi
echo high > /sys/class/gpio/gpio214/direction

case $DIG in
#gp130 to DIG0
0)
	read_input 248 130
;;
#gp131 to DIG1
1)
	read_input 249 131

;;

#gp128 to DIG2
2)
	read_input 250 128
;;

#gp12 to DIG3
3)
	read_input 251 12
;;

#gp129 to DIG4
4)
	read_input 252 129
;;

#gp13 to DIG5
5)
	read_input 253 13
;;

#gp182 to DIG6
6)
	read_input 254 182

;;

#gp48 to DIG7
7)
	read_input 255 48
;;

#gp49 to DIG8
8)
	read_input 256 49
;;

#gp183 to DIG9
9)
	read_input 257 183
;;

#gp41 to DIG10
10)
	read_input 258 41
;;

#gp43 to DIG11
11)
	read_input 259 43
;;

#gp42 to DIG12
12)
	read_input 260 42
;;

#gp40 to DIG13
13)
	read_input 261 40
;;

*) 
	usage
;;

esac

echo low > /sys/class/gpio/gpio214/direction

