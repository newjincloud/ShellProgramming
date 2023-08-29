#!/bin/bash
# ex) copy.sh file1.txt /tmp
#       -> scp file1.txt 192.168.10.10:/tmp
#       -> scp file1.txt 192.168.10.20:/tmp
#       -> scp file1.txt 192.168.10.30:/tmp

if [ $# -ne 2 ]; then
    echo "Usage: $0 <src file> <dst file>"
    exit 1
fi
SRC=$1
DST=$2

SERVERLIST=/root/bin/server.list
for HOST1 in $(cat $SERVERLIST)
do  
    echo "----- $HOST1 -----"
    scp $SRC $HOST1:$DST
    echo
done
