#!/bin/bash

ServiceStart() {
    # input: $SRV
    # output: 
    # function:
    SERVICE=$1
    systemctl enable $SERVICE >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $SERVICE enabled."
    else
        echo "[ FAIL ] $SERVICE not enabled."
    fi
    systemctl restart $SERVICE >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $SERVICE started."
    else
        echo "[ FAIL ] $SERVICE not started."
    fi
}

ServiceStop() {
    SERVICE=$1
    systemctl stop $SERVICE >/dev/null 2>&1
    if [ $? -eq 0 ] ; then
        echo "[  OK  ] $SERVICE stopped."
    else
        echo "[ FAIL ] $SERVICE not stopped."
    fi
    systemctl disable $SERVICE >/dev/null 2>&1
    if [ $? -eq 0 ] ; then
        echo "[  OK  ] $SERVICE disabled."
    else
        echo "[ FAIL ] $SERVICE not disabled."
    fi
}

EvalLecture() {
    NUMBER=$1
    MESSAGE=$2

    ON=no
    while [ "$ON" = 'no' ] 
    do
        echo
        echo -n "$NUMBER. $MESSAGE (0점 ~ 100점): "
        read POINT
        echo 
        echo "당신이 선택한 점수: $POINT"

        echo -n "입력하신 점수가 맞나요? (yes/no): "
        read POINTYES
        case $POINTYES in
            yes|YES|Yes|y|Y) 
                ON=yes 
                echo "$NUMBER: $POINT" >> $RESULT
                ;;
            no|NO|No|n|N)    ON=no  ;;
            *) echo "잘못 입력했습니다. yes or no 만 입력해 주세요."
            ON=no ;;
        esac
    done
}