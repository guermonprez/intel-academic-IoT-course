#!/bin/sh
#author:Jiujin Hong (Jiujinx.hong@intel.com)
#
#this script setup Edison/Arduino board to use DIG0/DIG1 as UART1 RX/UART1 TX
#
#

export_gpio() {
	if [ $# -ne 1 ]; then
		echo "erreur appel fonction $0"
		exit 2
	fi
	if [ ! -d /sys/class/gpio/gpio$1 ]; then
		echo $1 > /sys/class/gpio/export
	fi
}

#config DIG0 UART1 RX mode and level shiffter
export_gpio 248
echo mode1 > /sys/kernel/debug/gpio_debug/gpio130/current_pinmux
echo low > /sys/class/gpio/gpio248/direction #config as input
echo in > /sys/class/gpio/gpio130/direction

#config DIG1 UART1 RX mode and level shiffter
export_gpio 249
echo mode1 > /sys/kernel/debug/gpio_debug/gpio131/current_pinmux
echo high > /sys/class/gpio/gpio249/direction #config as output
echo out > /sys/class/gpio/gpio131/direction
