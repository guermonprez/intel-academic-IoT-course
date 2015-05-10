#!/bin/bash -e

if [ $1 = "uninstall" ]; then
	if [ -z $SSH_PASSWORD ]; then
		ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $SSH_USER@$SSH_IP_ADDR rm -f /lib/firmware/intel_mcu.bin
	else
		if [ $MCUSDK_OS = "cygwin32" -o $MCUSDK_OS = "cygwin64" ]; then
			path="`pwd`/internal_tools"
			jar_path=`cygpath -w "$path"`
		else
			jar_path=./internal_tools
		fi
		java -jar "$jar_path/javassh.jar" $SSH_USER $SSH_IP_ADDR $SSH_PASSWORD "rm -f /lib/firmware/intel_mcu.bin"
	fi	
else
	if [ -z $SSH_PASSWORD ]; then
		ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $SSH_USER@$SSH_IP_ADDR rm -f /lib/firmware/intel_mcu.bin
		scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$2/intel_mcu.bin" $SSH_USER@$SSH_IP_ADDR:/lib/firmware/
	else
		src="$2"
		if [ $MCUSDK_OS = "cygwin32" -o $MCUSDK_OS = "cygwin64" ]; then
			path="`pwd`/internal_tools"
			jar_path=`cygpath -w "$path"`
			src=`cygpath -w "$src"`
		else
			jar_path=./internal_tools
		fi
		java -jar "$jar_path/javassh.jar" $SSH_USER $SSH_IP_ADDR $SSH_PASSWORD "rm -f /lib/firmware/intel_mcu.bin"
		java -jar "$jar_path/javassh.jar" $SSH_USER $SSH_IP_ADDR $SSH_PASSWORD download "$src/intel_mcu.bin" /lib/firmware/
	fi
fi
