#!/bin/bash
echo "OS:" `uname -a`;
echo ";  Last Bootup Time:" `uptime`;
echo ";  CPU Utilization:" `which top >/dev/null 2>&1 && (top -b -n 2 | grep 'Cpu(s)' | tail -n 1 | awk '{print $2}'| awk -F. '{print $1}')||echo top command not installed`;
echo "%;  RAM Utilization:" `free | grep Mem | awk '{print $3/$2 * 100.0}'`;
echo "%;  SWAP Utilization:" `free | grep 'Swap' | awk '{t = $2; f = $4; print (f/t)}'`;
echo "%;  Filesystems:" `df -TPh | awk '{print $7" ""=>"" "$6}' | tr '\n' ';'`;