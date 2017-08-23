#!/bin/bash -x

apt update
apt upgrade -y
apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    ntp \
    ntpdate \
    open-vm-tools
service ntp stop
ntpdate -s mickey.lss.emc.com
service ntp start
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
apt update
apt install -y docker-ce
sed '/^ExecStart=/ s/$/ -H tcp://0.0.0.0:4243/' /lib/systemd/system/docker.service
service docker restart
curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)"
chmod +x /usr/local/bin/docker-compose
