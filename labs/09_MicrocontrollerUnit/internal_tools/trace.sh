#!/bin/bash -e

if [ -z $SSH_PASSWORD ]; then
	while [ 1 ]; do
		ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $SSH_USER@$SSH_IP_ADDR cat /dev/ttymcu1
		sleep 0.05
	done
else
	while [ 1 ]; do
		if [ $MCUSDK_OS = "cygwin32" -o $MCUSDK_OS = "cygwin64" ]; then
			path="`pwd`/internal_tools"
			jar_path=`cygpath -w "$path"`
		else
			jar_path=./internal_tools
		fi
		java -jar "$jar_path/javassh.jar" $SSH_USER $SSH_IP_ADDR $SSH_PASSWORD "cat /dev/ttymcu1"
 
		sleep 0.05
   done 
fi
