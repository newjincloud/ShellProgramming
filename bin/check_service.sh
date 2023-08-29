#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <IP1> <IP2>"
    exit 1
fi

HOST1=$1
HOST2=$2

# Variable definitions
export LANG=en_US.UTF-8
MYHOST=$HOST1
PEERHOST=$HOST2

ssh $MYHOST systemctl -t service \
    | sed -n '2,/^LOAD/p' \
    | sed '$d' \
    | awk '{print $1}' > $MYHOST.txt

ssh $PEERHOST systemctl -t service \
    | sed -n '2,/^LOAD/p' \
    | sed '$d' \
    | awk '{print $1}' > $PEERHOST.txt

cat << EOF
==== $MYHOST ====
$(diff $MYHOST.txt $PEERHOST.txt | fgrep '<' | cut -c 3-)

==== $PEERHOST =====
$(diff $MYHOST.txt $PEERHOST.txt | fgrep '>' | cut -c 3-)

EOF