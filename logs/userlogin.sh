#!/bin/bash

<<comment
Script for Track and Log when users log into the system
Version: V1
Author: Nidesh
Features: Uses last command,Filters current date logins,output to daily file
comment

set -e
set -o pipefail

#Variables
logstamp=$(date '+%Y-%m-%d_%H-%M-%S')
log_dir=/var/log/userlogin
mkdir -p $log_dir
log_file="$log_dir/${logstamp}.log"

#command
{

echo -e "------Login Report on $(date '+%Y-%m-%d_%H-%M-%S')-------"
echo "Hostname: $(hostname)"
journalctl --since today | grep "session opened for user"

#Below command is another method to find login details
#last | grep "$(date +'%b %_d')"   
} > $log_file

#Compresses logs older than 7 days.
find $log_dir -type f -mtime +7 -name "*.log" -exec gzip {} +

#Delete compressed file older than 30 days.
find $log_dir -type f -mtime +30 -name ".gz" -exec rm -rf {} +
