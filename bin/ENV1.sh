#!/bin/bash
# ENV1.sh : 서비스 기동
# * telnet: telnet-server, telnet
# * ftp   : vsftpd, ftp
# 서비스 기동 과정
# * 패키지 설치
# * 서비스 설정
# * 서비스 기동

. /root/bin/functions.sh

echo "===== [ Phase 1 : 서비스 기동 ] ====="

# (1) TELNET 패키지 설치 과정
# * 1) 패키지 설치
PkgInstall telnet-server telnet

# * 2) 서비스 설정


# * 3) 서비스 기동
ServiceStart telnet.socket

# (2) FTP 패키지 설치 과정
# * 1) 패키지 설치
PkgInstall vsftpd ftp

# * 2) 서비스 설정
FTPUSERS=/etc/vsftpd/ftpusers
USER_LIST=/etc/vsftpd/user_list
sed -i 's/^root/#root/' $FTPUSERS
sed -i 's/^root/#root/' $USER_LIST
for i in $FTPUSERS $USER_LIST
do
    cat $i | egrep -v '^#|^$' | grep root >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[ FAIL ] $i 설정 실패"
        exit 1
    else
        echo "[  OK  ] $i 설정 완료"
    fi
done

# * 3) 서비스 기동
ServiceStart telnet.socket