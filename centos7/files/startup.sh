#!/bin/bash
# Put this file in /usr/local/bin/
ip route | awk '/default/ {print $3;}' | xargs ping -c 4
