#!/bin/bash

. /root/shell/functions.sh

if [ $# -ne 2 ]; then
    echo "Usage: $0 <UNIT> start|stop|restart"
    exit 1
fi
SRV=$1
ACTION=$2

case $ACTION in
    start|restart) ServiceStart $SRV ;;
    stop)          ServiceStop $SRV  ;;
    *) echo "Usage: $0 <UNIT> start|stop|restart" && exit 2 ;;
esac
