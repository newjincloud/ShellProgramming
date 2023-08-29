WorkMenu() {
    cat << EOF

---------- 작업 목록 ----------
1) 출력 내용
2) 파티션 작업
3) 파일시스템 작업
4) 마운트 작업
5) 종료

EOF
}

PrintOutput() {
    cat << EOF

---------- 출력 내용 ----------
$(lsblk -o NAME,TYPE,SIZE,FSTYPE,MOUNTPOINT -p)

EOF
}

DiskWork() {
    while true
    do
        echo -n "* 디스크 선택(ex: /dev/sdb) : "
        read DISK1
        echo -n "* 파티션 형식(msdos|gpt) : " 
        read PARTITIONTYPE
        echo -n "* 파티션 용량(ex: 50%|100%) : "
        read PARTITIONSIZE
        cat << EOF

    ** 디스크 선택: $DISK1
    ** 파티션 형식: $PARTITIONTYPE
    ** 파티션 용량: $PARTITIONSIZE

EOF
        echo -n "선택이 맞습니까? (y/n) : "
        read YESNO
        case $YESNO in
            y|Y|yes|Yes|YES) break ;;
            n|N|no|No|No)    : ;;
            *) echo "y 또는 n을 입력해야 합니다." ;;
        esac
    done
    
    echo "[  OK  ] 파티션 작업 중 ...."
    parted $DISK1 mklabel $PARTITIONTYPE
    parted $DISK1 mkpart primary 2048s $PARTITIONSIZE
    sleep 2
    echo "[  OK  ] 파티션 작업 완료"
}

FSWork() {
    while true
    do
        echo -n "* 파일시스템 종류 선택? (xfs|ext4) : "
        read FSTYPE
        echo -n "* 작업할 파티션 이름? (ex: /dev/sdb1) : "
        read PARTIONNAME
        cat << EOF

    ** 파일시스템 종류: $FSTYPE
    ** 파티션 이름: $PARTIONNAME

EOF
        echo -n "선택이 맞습니까? (y/n) : "
        read YESNO
        case $YESNO in
            y|Y|yes|Yes|YES) break ;;
            n|N|no|No|No)    : ;;
            *) echo "y 또는 n을 입력해야 합니다." ;;
        esac
    done
    echo "[  OK  ] 파일시스템 작업 중 ...."
    mkfs -t $FSTYPE -f $PARTIONNAME
    sleep 2
    echo "[  OK  ] 파일시스템 작업 완료"
}

FSMount() {
    export FSTAB=/etc/fstab
    while true
    do
        echo -n "* 마운트 포인터 선택? (ex: /oracle) : "
        read MOUNTPOINT
        echo -n "* 마운트할 장치 이름? (ex: /dev/sdb1) : "
        read MOUNTPARTIONNAME
        echo -n "* 마운트할 파일시스템 종류? (xfs|ext4) : "
        read MOUNTFSTYPE
        cat << EOF

    ** 마운트 포인터: $MOUNTPOINT
    ** 마운트 장치 이름: $MOUNTPARTIONNAME
    ** 마운트 파일시스템 종류: $MOUNTFSTYPE

EOF
        echo -n "선택이 맞습니까? (y/n) : "
        read YESNO
        case $YESNO in
            y|Y|yes|Yes|YES) break ;;
            n|N|no|No|No)    : ;;
            *) echo "y 또는 n을 입력해야 합니다." ;;
        esac
    done
    echo "[  OK  ] 파일시스템 작업 중 ...."
    mkdir -p $MOUNTPOINT

    grep -w "$MOUNTPOINT" "$FSTAB" >/dev/null 2>&1
    [ $? -ne 0 ] && echo "$MOUNTPARTIONNAME  $MOUNTPOINT  $MOUNTFSTYPE  defaults 0 2" >> $FSTAB

    mount -a 
    sleep 2
    echo "[  OK  ] 파일시스템 작업 완료"    
}
