#!/bin/bash

# 0) 점검
# (ㄱ) 인자 점검
if [ $# -ne 1 ]; then
    echo "[ FAIL ] 사용법: $0 {com|example.com|test.com}"
fi
DOMAIN=$1
case "$1" in 
    'com'        ) IP1=192.168.10.10 ; com.sh     ;;
    'example.com') IP1=192.168.10.20 ; example.sh ;;
    'test.com'   ) IP1=192.168.10.30 ; test.sh    ;;
    *) echo "[ FAIL ] 사용법: $0 {com|example.com|test.com}" && exit 1 ;;
easc

. functions.sh

# (ㄴ) IP 점검
# (ㄷ) 호스트 이름 점검

# 1) 패키지 설치
# 2) 서비스 설정
# 3) 서비스 기동
# 4) 방화벽 기동
# 5) DNS 클라이언트 설정

# 1) 패키지 설치(yum install bind bind-utils)
PkgInstall $DNS_PKG

# 2) 서비스 설정
# * /etc/named.{conf,rfc1912.zones}
# * /var/named/named.ca
# * /var/named/{F.zone,R.zon}
DNSServiceComConfig 

# 3) 서비스 기동(systemctl enable --now named)
DNSServiceStart named.service

# 4) 방화벽 기동(firewall-cmd --permanent --add-service=dns)
DNSFWConfig

# 5) DNS 클라이언트 설정
# * /etc/resolv.conf
DNSClientConfig "$DOMAIN" "$IP1"
