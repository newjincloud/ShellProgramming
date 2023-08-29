#!/bin/bash

cat << EOF
====================================================
  (1). who      (2). date     (3). pwd              
====================================================
EOF
echo -n "당신의 선택은? : "
read CHOICE

case $CHOICE in
    1) who ;;
    2) date ;;
    3) pwd ;;
    *) echo "[ FAIL ] 잘못된 선택을 했습니다."
        exit 1 ;;
esac
