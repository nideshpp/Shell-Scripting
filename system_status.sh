#!/bin/bash

#Script to fetch System information
set -e 
set -o pipefail

echo "####################################"
echo "      System Information "
echo "HostName: $(hostname)"
echo "Kernal_Version: $(uname -r)"
echo "OS Name: $(awk -F '"' '/PRETTY_NAME=/{print $2}' /etc/os-release)"
echo -e "Uptime: \t $(uptime -p)"
echo -e "Memory: \t $(free -h | awk 'NR==2 {print "Total: "$2 "  Used:" $3}')"
echo -e "Disk in /: \t $(df -h / | awk 'NR==2 {print "Total:"$2 " Used:"$3}')"
echo -e "Today is: \t $(date)"
