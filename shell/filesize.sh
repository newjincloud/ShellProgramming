#!/bin/bash
# ./filesize.sh /etc/hosts

if [ $# -ne 1 ]; then
    echo "Usage: $0 filename"
    exit 1
fi
FILE1=$1

# echo $FILE1
FILESIZE=$(wc -c < $FILE1)
# echo $FILESIZE

if [ $FILESIZE -ge 5120 ] ; then
    echo "[  OK  ] Big file($FILESIZE bytes)."
else
    echo "[  OK  ] Small file($FILESIZE bytes)."
fi
