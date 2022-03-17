#!/bin/bash

hn = "$(uname -n||echo 'uname not found')"
os = "$(egrep -w "NAME|VERSION" /etc/os-release|awk -F= '{ print $2 }'|sed 's/"//g'||echo '/etc/os-release not found')"
kernel = "$(uname -ri||echo 'uname not found')"
lbt = "$(uptime -s||echo 'uptime not found')"
cpu = "$(which top >/dev/null 2>&1 && (top -b -n 2 | grep 'Cpu(s)' | tail -n 1 | awk '{print $2}'| awk -F. '{print $1}')||echo 'top command not found')"
mem = "$(free | grep Mem | awk '{print $3/$2 * 100.0}'||echo 'free command not found')"
swap = "$(free | grep 'Swap' | awk '{t = $2; f = $4; print (f/t)}'||echo 'free command not found')"
fs = "$(df -TPh -x squashfs -x tmpfs -x devtmpfs | awk 'BEGIN {ORS=","} NR>1{print "[Mount:"$7", UsedPercent:"$6"]"}'||echo 'df command not found')"

stdoutput = "Hostname:" $hn ", OS:" $os ", Kernel:" $kernel ", LastBootUpTime:" $lbt ", CPULoadPercent:" $cpu ", MemoryLoadPercent:" $mem ", SWAPLoadPercent:" $swap ", Filesystems:" $fs
echo "{ \"changed\": false, \"failed\": false, \"rc\": 0, \"msg\": \"\", \"stderr\": \"\", \"stdout\": \"$stdoutput\" }"