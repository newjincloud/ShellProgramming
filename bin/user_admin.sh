#!/bin/bash

AdminList() {
    cat << EOF
(관리 목록)
------------------------------------
1) 사용자 추가
2) 사용자 확인
3) 사용자 삭제
4) 종료
------------------------------------
EOF
}

UserList() {
    cat << EOF
(사용자 확인)
------------------------------------
$(awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' /etc/passwd)
------------------------------------
EOF
}

UserDel() {
    echo "(사용자 삭제)"
    echo -n "삭제할 사용자 이름? : "
    read UNAME

    grep -w "$UNAME" /etc/passwd >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        userdel -r $UNAME \
            && echo "[  OK  ] $UNAME 사용자가 삭제 되었스므니다." \
            || echo "[ FAIL ] $UNAME 사용자가 삭제되지 않았스므니다."
    else
        echo "[ FAIL ] $UNAME 사용자가 없습니다."
    fi
}

UserAdd() {
    echo "(사용자 추가)"
    echo -n "추가할 사용자 이름? : "
    read UNAME

    useradd $UNAME >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $UNAME 사용자가 추가 되었습니다."
        echo $UNAME | passwd --stdin $UNAME >/dev/null 2>&1
        echo "[  OK  ] $UNAME 사용자 암호를 변경하였습니다."
    else
        echo "[ FAIL ] $UNAME 사용자가 추가되지 않았습니다."
    fi
}

while true
do
    echo
    AdminList
    echo -n "선택 번호? : "
    read NUM
    case $NUM in
        1) UserAdd ;;
        2) UserList ;;
        3) UserDel ;;
        4) break ;;
        *) echo "[ INFO ] 잘못된 번호를 선택하였습니다." ; echo ;;
    esac
done