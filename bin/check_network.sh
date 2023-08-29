#!/bin/bash
# 네트워크 점검 스크립트
# 1) ping 192.168.10.2
# 2) ping 8.8.8.8
# 3) ping www.google.com

. /root/bin/functions.sh

IP1=192.168.10.2
IP2=8.8.8.8
IP3=www.google.com

# 네트워크 점검 스크립트
# (1) ping 192.168.10.2
print_info "(1) # ping $IP1"
ping -c 1 -W 1 $IP1 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "[  OK  ] Local Network Connection"
else
    print_error "[ FAIL ] Local Network Connection"
    cat << EOF
    (ㄱ) # ip addr (# ifconfig)
    (ㄴ) VMware > Edit > Virtual Network Editor > VMnet0
    (ㄷ) VMware > Edit > Virtual Network Editor > VMnet8
        * Network number
        * Gateway IP address
    (ㄹ) services.msc > VMware* 서비스 동작
EOF
fi

# (2) ping 8.8.8.8
print_info "(2) # ping $IP2"
ping -c 1 -W 1 $IP2 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "[  OK  ] External Network Connection"
else
    print_error "[ FAIL ] External Network Connection"
    cat << EOF
    (ㄱ) # ip route (# netstat -nr, # route -n)
EOF
fi

# 3) ping www.google.com
print_info "(3) # dig +noanswer +timeout=1 $IP3"
# ping -c 1 -W 1 $IP3 >/dev/null 2>&1
dig +noanswer +timeout=1 $IP3 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "[  OK  ] DNS Client Configuration"
else
    print_error "[ FAIL ] DNS Client Configuration"
    cat << EOF
    (ㄱ) # cat /etc/resolv.conf
EOF
fi
