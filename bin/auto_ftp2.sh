#!/bin/bash

SERVERLIST=/root/bin/server.txt
PORT=21
UNAME=root
UPASS=soldesk1.
UPLOADFILE=main.txt
cat server.txt | while read SERVER
do
    # echo $SERVER
    ftp -n $SERVER $PORT << EOF
    user $UNAME $UPASS
    cd /tmp
    lcd /test
    bin
    hash
    prompt 
    mput $UPLOADFILE
    quit
EOF
done
