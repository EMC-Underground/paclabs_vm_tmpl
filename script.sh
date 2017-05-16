#!/bin/bash

apt update --assume-yes
apt upgrade --assume-yes
apt install docker.io --assume-yes
apt install ansible --assume-yes
ansible-galaxy install debops.dhcpd

