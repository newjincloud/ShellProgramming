#!/bin/bash

# # crontab -e
# 0 8 * * 1-5 /root/bin/check_file >/var/log/file.log 2>&1

# # cat /root/bin/check_list.txt
# /etc/passwd
# /etc/group
# /etc/hosts
# ...

# 1) 파일 초기화
# 2) 백업 or 파일 비교 작업 -> result_0824.txt
# 3) 결과 점검 -> 메일 전송

# 1) 파일 초기화
RESULT=result_$(date +%m%d).txt
> $RESULT

# 2) 백업 or 파일 비교 작업 -> result_0824.txt
BACKUPDIR=/backup
FILE_LIST=/root/bin/file_list.txt
TMP1=/tmp/tmp1

[ ! -d /backup ] && mkdir -p /backup
for FILE1 in $(cat $FILE_LIST)
do
    FILEPATH=$(dirname $FILE1)
    FILENAME=$(basename $FILE1)
    BACKUPFILE=$BACKUPDIR/$FILENAME.OLD
    if [ -f $BACKUPFILE ]; then
        diff $FILE1 $BACKUPFILE > $TMP1
        if [ -s $TMP1 ]; then
            echo "[ WARN ] $FILE1" >> $RESULT
            cp -p $FILE1 $BACKUPFILE
        else
            echo "[  OK  ] $FILE1" >> $RESULT
        fi
    else
        cp -p $FILE1 $BACKUPFILE
    fi
done

# 3) 결과 점검 -> 메일 전송
EMAIL=root
grep -w WARN $RESULT >/dev/null 2>&1
if [ $? -eq 0 ]; then
    mailx -s "[ WARN ] 중요한 파일 내용 변경" $EMAIL < $RESULT
else
    mailx -s "[  OK  ] 오늘도 안전" $EMAIL < $RESULT
fi
