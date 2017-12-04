#!/bin/bash

sed -i '/centos.pool/d' /etc/chrony.conf
sed -i '3s/^/server 10.254.140.21 iburst\n/' /etc/chrony.conf
systemctl restart chronyd

mv /tmp/startup.sh /usr/local/bin/
mv /tmp/startup.service /etc/systemd/system/
systemctl enable startup.service
systemctl start startup.service

sudo yum -y update

# Cleanup below

yum clean all
sudo yum -y clean all

rm -f /etc/udev/rules.d/70*

for filename in /etc/sysconfig/network-scripts/ifcfg-ens*; do
  echo "Editing $filename"
  sed -i'' -e '/UUID=/d' $filename
  sed -i'' -e '/HWADDR=/d' $filename
  sed -i'' -e '/DHCP_HOSTNAME=/d' $filename
  sed -i'' -e 's/NM_CONTROLLED=.*/NM_CONTROLLED="no"/' $filename
done

> /etc/machine-id

rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /etc/ssh/*key*

sync
