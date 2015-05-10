#!/bin/sh
#author: David Pierret (davidx.pierret@intel.com)
#this script setup Edison/Arduino board to use DIG0 to DIG13 as GPIOs

DIG=""
VAL=""

usage() {
echo "usage $0 -o [num] -v [value]" >&2
echo "init_DIG.sh must be called before"
echo "num : number of the digital output 0->13" >&2
echo "value : 'low' or 'high'" >&2
exit 1
}

## set_output [mux] [gpio] [value]
## [mux] gpio to check to control level switcher
## [gpio] gpio number to read
## [value] value to apply
set_output() {
	if [ $# -ne 3 ]; then
		echo "erreur appel fonction $0"
		exit 2
	fi
	if [ ! -d /sys/class/gpio/gpio$1 ]; then
		usage
	fi
	if [ ! $(cat /sys/class/gpio/gpio$1/direction) == "out" ]; then
		usage
	fi
#	echo $VAL > /sys/kernel/debug/gpio_debug/gpio130/current_value
	echo $3 > /sys/class/gpio/gpio$2/direction
}

while getopts "o:(output)v:(value)" optname
	do
		case "$optname" in
        "o")
			DIG=$OPTARG
          ;;
        "v")
			VAL=$OPTARG
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
echo "VAL = $VAL"
# check the dig number var
if [ ! "$DIG" -ge 0 -a "$DIG" -le 13 ]; then
	usage
fi
# check the direction var
if [ "$VAL" != "high" -a "$VAL" != "low" ]; then
	usage
fi

if [ ! -d /sys/class/gpio/gpio214 ]; then
	echo 214 > /sys/class/gpio/export
fi
echo low > /sys/class/gpio/gpio214/direction

case $DIG in
#gp130 to DIG0
0)
	set_output 248 130 $VAL
;;
#gp131 to DIG1
1)
	set_output 249 131 $VAL

;;

#gp128 to DIG2
2)
	set_output 250 128 $VAL
;;

#gp12 to DIG3
3)
	set_output 251 12 $VAL
;;

#gp129 to DIG4
4)
	set_output 252 129 $VAL
;;

#gp13 to DIG5
5)
	set_output 253 13 $VAL
;;

#gp182 to DIG6
6)
	set_output 254 182 $VAL

;;

#gp48 to DIG7
7)
	set_output 255 48 $VAL
;;

#gp49 to DIG8
8)
	set_output 256 49 $VAL
;;

#gp183 to DIG9
9)
	set_output 257 183 $VAL
;;

#gp41 to DIG10
10)
	set_output 258 41 $VAL
;;

#gp43 to DIG11
11)
	set_output 259 43 $VAL
;;

#gp42 to DIG12
12)
	set_output 260 42 $VAL
;;

#gp40 to DIG13
13)
	set_output 261 40 $VAL
;;

*) 
	usage
;;

esac

echo high > /sys/class/gpio/gpio214/direction

