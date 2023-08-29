#!/bin/bash
# ex) # cmd.sh CMD
#       -> ssh 192.168.10.10 CMD
#       -> ssh 192.168.10.20 CMD
#       -> ssh 192.168.10.30 CMD

if [ $# -eq 0 ]; then
    echo "Usage: $0 CMD"
    exit 1
fi
CMDS=$*

SERVERLIST=/root/bin/server.list
for HOST1 in $(cat $SERVERLIST)
do
    echo "----- $HOST1 -----"
    ssh $HOST1 $CMDS
    echo
done
