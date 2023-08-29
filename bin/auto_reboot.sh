#!/bin/bash

# Variable definitions
SERVERLIST=/root/bin/server.list
ALIVESERVERLIST=/root/bin/alive_server.list
> $ALIVESERVERLIST

# 0) 서버 목록 파일 생성
cat << EOF > $SERVERLIST
192.168.10.20
192.168.10.30
192.168.10.40
192.168.10.50
EOF

# 1) 살아 있는 서버 목록 만들기

cat $SERVERLIST | while read HOST1
do
    # echo "$HOST1"
    ping -c 1 -W 1 "$HOST1" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $HOST1"
        echo "$HOST1" >> $ALIVESERVERLIST
    else
        echo "[ FAIL ] $HOST1"
    fi
done

cat $ALIVESERVERLIST | while read HOST2
do
    UNAME='root'
    UPASS='soldesk1.'
    CmdReboot() {
        sleep 1.5   ; echo "$UNAME"
        sleep 0.3   ; echo "$UPASS"
        sleep 0.3   ; echo 'reboot'
        sleep 0.3   ; echo 'exit'
    }
    CmdReboot | telnet $HOST2
done
