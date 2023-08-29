# Variable Definitions
DNS_PKG="bind bind-utils"
#DNS_PRIMARY_CONF="named.conf"
#DNS_SECONDARY_CONF="named.rfc1912.zones"
#DNS_ROOT_CONF="named.ca"
#DNS_FORWARD_ZONE="com.zone"
#DNS_REVERSE_ZONE="com.rev"
#DNS_NAMED="named.service"
FWD="firewalld.service"

# Function Definitions
PkgInstall() {
    PKG="$*"
    yum -q -y install $PKG 
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $PKG 패키지 설치 완료."
    else
        echo "[ FAIL ] $PKG 패키지 설치 실패."
        exit 5
    fi
}

DNSServiceComConfig() {
    /bin/cp -p com/named.conf /etc/named.conf
    /bin/cp -p com/named.rfc1912.zones /etc/named.rfc1912.zones
    /bin/cp -p com/named.ca /var/named/named.ca
    /bin/cp -p com/com.zone /var/named/com.zone
    /bin/cp -p com/com.rev /var/named/com.rev
}

DNSServiceExampleComConfig() {
    /bin/cp -p example.com/named.conf /etc/named.conf
    /bin/cp -p example.com/named.rfc1912.zones /etc/named.rfc1912.zones
    /bin/cp -p example.com/named.ca /var/named/named.ca
    /bin/cp -p example.com/example.zone /var/named/example.zone
    /bin/cp -p example.com/example.rev /var/named/example.rev
}

DNSServiceTestComConfig() {
    /bin/cp -p test.com/named.conf /etc/named.conf
    /bin/cp -p test.com/named.rfc1912.zones /etc/named.rfc1912.zones
    /bin/cp -p test.com/named.ca /var/named/named.ca
    /bin/cp -p test.com/test.zone /var/named/test.zone
    /bin/cp -p test.com/test.rev /var/named/test.rev
}

DNSServiceStart() {
    DNS_UNIT="$1"

    systemctl enable $DNS_UNIT
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $DNS_UNIT enabled."
    else
        echo "[ FAIL ] $DNS_UNIT not enabled."
        exit 1
    fi

    systemctl restart $DNS_UNIT
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $DNS_UNIT started."
    else
        echo "[ FAIL ] $DNS_UNIT not started."
        exit 1
    fi
}

DNSFWConfig() {
    RET=$(systemctl is-active $FWD)
    if [ $RET = 'active' ]; then
        firewall-cmd --permanent --add-service=dns >/dev/null 2>&1
        firewall-cmd --reload >/dev/null 2>&1
        echo "[  OK  ] Registered with the firewalld."
    else
        echo "[  OK  ] FirewallD is not running."
    fi
}

DNSClientConfig() {
    DOM="$1"
    IP1="$2"
    nmcli connection modify eth0 ipv4.dns $IP1 +ipv4.dns 168.126.63.1 ipv4.dns-search $DOM
    nmcli connection up eth0
}
