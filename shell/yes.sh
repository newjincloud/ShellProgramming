#!/bin/bash

echo -n "당신의 선택은? (yes|no) : "
read YESNO

case $YESNO in
    yes|YES|Yes|y|Y) echo "[ YES ]" ;;
    no|NO|No|n|N)    echo "[ NO ]" ;;
    *) echo "잘못된 선택입니다."
        exit 1 ;;
esac