#!/bin/bash
# ex) nohup /root/shell/chklog.sh &

# Variable Definition
LOG=/var/log/messages
# TMP1=$(mktemp)
TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3

egrep -i 'warn|fail|error|crit|alert|emerg' $LOG > $TMP1
while true
do
    sleep 10
    egrep -i 'warn|fail|error|crit|alert|emerg' $LOG > $TMP2
    diff $TMP1 $TMP2 > $TMP3 && continue
    mailx -s "[ WARN ] Log check" root < $TMP3
    egrep -i 'warn|fail|error|crit|alert|emerg' $LOG > $TMP1
done


