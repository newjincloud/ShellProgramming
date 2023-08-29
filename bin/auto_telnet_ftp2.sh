#!/bin/bash

SERVERLIST=/root/bin/server_telnet.txt
cat $SERVERLIST | while read IP1 UNAME UPASS
do
    BACKUPFILE="home_${IP1}_$(date +%m%d_%H%M%S).tar.gz"
    CmdBackup() {
        sleep 1     ; echo "$UNAME"
        sleep 0.3   ; echo "$UPASS"
        sleep 0.3   ; echo "tar czf /tmp/$BACKUPFILE /home"
        sleep 0.3   ; echo 'exit'
    }
    CmdBackup | telnet $IP1 

# 2) 파일 전송 -> auto_ftp.sh
    ftp -n $IP1 << EOF
    user $UNAME $UPASS
    cd /tmp
    lcd /test
    bin
    hash
    prompt
    mget $BACKUPFILE
    quit
EOF
done
