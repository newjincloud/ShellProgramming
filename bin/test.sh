#!/bin/bash

while true
do
	echo -n "192.168.10.10> "
	read CMD
	[ ! -z $CMD ] && ssh 192.168.10.10 $CMD
done


