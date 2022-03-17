#!/bin/bash

HN=$(uname -n||echo 'uname command not found')
OS=$(egrep -w "NAME|VERSION" /etc/os-release|awk -F= '{ print $2 }'|sed 's/"//g'||echo '/etc/os-release command not found')
KERNEL=$(uname -ri||echo 'uname command not found')
LBT=$(uptime -s||echo 'uptime command not found')
CPU=$(which top >/dev/null 2>&1 && (top -b -n 2 | grep 'Cpu(s)' | tail -n 1 | awk '{print $2}'| awk -F. '{print $1}')||echo 'top command not found')
MEM=$(free | grep Mem | awk '{print $3/$2 * 100.0}'||echo 'free command not found')
CPUS=$(nproc||echo 'nproc command not found')
TMEM=$(free -m | grep Mem | awk '{print $2}'||echo 'free command not found')
SWAP=$(free | grep 'Swap' | awk '{t = $2; f = $4; print (f/t)}'||echo 'free command not found')
FS=$(df -TPh -x squashfs -x tmpfs -x devtmpfs | awk 'BEGIN {ORS=","} NR>1{print "{\"Mount\":\""$7"\", \"UsedPercent\":\""$6"\"}"}'||echo 'df command not found,')

STDOUTPUT="\"Hostname\": \""$HN"\", \"OS\": \""$OS"\", \"Cores\": \""$CPUS"\", \"MemoryMB\": \""$TMEM"\", \"Kernel\": \""$KERNEL"\", \"LastBootUpTime\":\""$LBT"\", \"CPULoadPercent\": "$CPU", \"MemoryLoadPercent\": "$MEM", \"SWAPLoadPercent\": "$SWAP", \"Filesystems\": ["${FS::-1}"]"

ER="not found"
if [[ $STDOUTPUT =~ $ER ]];
then
    echo "{ \"changed\": false, \"failed\": true, \"rc\": 1, \"msg\": \"\", \"stderr\": {"$STDOUTPUT"}, \"stderr_lines\": {"$STDOUTPUT"}, \"stdout\": \"\", \"stdout_lines\": \"\" }"
    exit 1
else
    echo "{ \"changed\": false, \"failed\": false, \"rc\": 0, \"msg\": \"\", \"stderr\": \"\", \"stderr_lines\": \"\", \"stdout\": {"$STDOUTPUT"}, \"stdout_lines\": {"$STDOUTPUT"} }"
    exit 0
fi
