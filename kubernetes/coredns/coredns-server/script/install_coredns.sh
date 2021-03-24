#!/bin/bash

CORE_DNS_VERSION=1.8.0
# Fetch coredns files
wget https://github.com/coredns/coredns/releases/download/v${CORE_DNS_VERSION}/coredns_${CORE_DNS_VERSION}_linux_amd64.tgz
wget https://github.com/coredns/coredns/releases/download/v${CORE_DNS_VERSION}/coredns_${CORE_DNS_VERSION}_linux_amd64.tgz.sha256

# Print checksum
sha256sum -c coredns_${CORE_DNS_VERSION}_linux_amd64.tgz.sha256

if test $? -eq 0
then
    # Untar and move binary to path
    tar -zxvf coredns_${CORE_DNS_VERSION}_linux_amd64.tgz
    sudo mv coredns /usr/local/bin/coredns

    # Copy zone file
    sudo mkdir -p /etc/coredns/zones
    cd /home/ubuntu/
    sudo cp db.opsschool.example /etc/coredns/zones
else
    echo "SHA256 for coredns_${CORE_DNS_VERSION}_linux_amd64.tgz not verified"
fi
