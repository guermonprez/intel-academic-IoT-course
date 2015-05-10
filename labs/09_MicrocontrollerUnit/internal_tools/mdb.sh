#!/bin/bash

ssh_user=$SSH_USER
ip_addr=$SSH_IP_ADDR

if [ $MCUSDK_OS = "cygwin32" -o $MCUSDK_OS = "cygwin64" ]; then
	path="`pwd`/internal_tools"
	jar_path=`cygpath -w "$path"`
else
	jar_path=./internal_tools
fi

function ssh_check_device()
{
	java -jar "$jar_path/javassh.jar" $ip_addr check_device
	if [ $? -ne 0 ]; then
		exit
	fi
}

function ssh_shell()
{
	ssh_check_device
	if [ -z $SSH_PASSWORD ]; then
		ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $SSH_USER@$ip_addr $@
	else
		java -jar "$jar_path/javassh.jar" $ssh_user $ip_addr $SSH_PASSWORD $@
	fi
}

function ssh_devices()
{
	echo "List of devices attached"

	ssh_check_device
	if [ $? -eq 0 ]; then
		echo -e "edison\tdevice"
	else
		echo
	fi
}

function ssh_wait_for_device()
{
	while [ 1 ]; do
		ssh_check_device
		if [ $? -eq 0 ]; then
			break
		else
			sleep 1
		fi
	done
}

if [ "$1" = "devices" ]; then
	ssh_devices
elif [ "$1" = "wait-for-device" ]; then
	ssh_wait_for_device
elif [ "$1" = "shell" ]; then
	shift
	ssh_shell $@
fi
