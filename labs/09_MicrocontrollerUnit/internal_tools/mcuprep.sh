#!/bin/bash -e

if [ -z $SSH_PASSWORD ]; then
	file=`ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $SSH_USER@$SSH_IP_ADDR "find /lib/firmware -name intel_mcu.bin" | sed 's/^[ \t]*//;s/[ \t]*$//'`
	if [ "$file" != "/lib/firmware/intel_mcu.bin" ]; then
		echo "Connect to the device failed. Was the MCU application downloaded before connecting?"
		exit 1
	fi
	ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $SSH_USER@$SSH_IP_ADDR "echo debug > /sys/devices/platform/intel_mcu/log_level"
else
	if [ $MCUSDK_OS = "cygwin32" -o $MCUSDK_OS = "cygwin64" ]; then
		path="`pwd`/internal_tools"
		jar_path=`cygpath -w "$path"`
	else
		jar_path=./internal_tools
	fi

	file=`java -jar "$jar_path/javassh.jar" $SSH_USER $SSH_IP_ADDR $SSH_PASSWORD "find /lib/firmware -name intel_mcu.bin" | sed 's/^[ \t]*//;s/[ \t]*$//'`
	if [ "$file" != "/lib/firmware/intel_mcu.bin" ]; then
		echo "Connect to the device failed. Was the MCU application downloaded before connecting?"
		exit 1
	fi
	java -jar "$jar_path/javassh.jar" $SSH_USER $SSH_IP_ADDR $SSH_PASSWORD "echo debug > /sys/devices/platform/intel_mcu/log_level"
fi
