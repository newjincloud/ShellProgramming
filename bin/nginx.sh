#!/bin/bash
# Nginx Web Server Configuration
# (ㄱ) 패키지 설치
# (ㄴ) (x)서비스 설정
# (ㄷ) 서비스 기동
# (ㄹ) (x)방화벽 등록
# (ㅂ) (x)SELINUX

. /root/bin/functions.sh

# 1) 패키지 설치
PkgInstall nginx

# 2) 서비스 기동
ServiceStart nginx

