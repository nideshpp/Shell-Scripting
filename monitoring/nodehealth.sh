#!/bin/bash

<<comment
Version:V1
Author: Nidesh
Script to Monitor System Health
Features
Logs System Metrics to a file
Alert if Disk,Cpu,Ram reaches SLA
comment

set -e
set -o pipefail

##################################################
#Variables
log_dir=/var/log/daily_health
mkdir -p $log_dir
logfile="$log_dir/daily_health_$(date '+%Y-%m-%d_%H-%M-%S').log"
cpu=$(top -bn1 | grep Cpu | awk '{print 100 - $8 "%"}')
memory=$(free -m | awk 'NR==2 {print $3 / $2 *100}')
disk=$(df -h / | awk 'NR==2 {print $5}' | tr -d "%")
avail=$(uptime -p | awk '{print $4}')
#########################################################3
{

echo "------Date Fetch on $(date)-------" 
echo -e " Below are the Parameters of CPU  Memory Disk  "
echo -e "Cpu_Usage:  \t ${cpu}% "   
echo -e "Memory_Usage: \t ${memory}% " 
echo -e "Disk_Usage: \t ${disk}% " 
echo -e "Availbilty since: ${avail}minutes "
echo "--------------------------------" 

#Alert Condition Checking
if [[ ${cpu%.*} -ge 70 ]]; then
	echo "Alert: CPU Usage reached SLA: ${cpu}%" 
fi

if [[ ${memory%.*} -ge 70 ]]; then
	echo "Alert: Memory Usage reache SLA: ${memory}%" 
fi
if [[ $disk  -ge 70 ]]; then
	echo "Alert: Disk Usage reached SLA: ${disk}%" 
fi
if [[ $avail -le 5 ]]; then
	echo "Alert: System Availabilty less than 5 minutes: ${avail}minutes"
fi

} >>$logfile
