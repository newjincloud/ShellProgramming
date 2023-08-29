#!/bin/bash

echo -n "파일 입력: "
read FILE1

if  [ -f $FILE1 ] ; then
    echo "[  OK  ] 일반 파일입니다."
elif [ -d $FILE1 ] ; then
    echo "[  OK  ] 디렉토리 파일입니다."
else
    echo "[ FAIL ] 파일 또는 디렉토리 파일이 아닙니다."
    exit 1
fi
