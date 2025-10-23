#!/bin/bash

<<comment
Script Name: conf_change_file.sh
Author: Nidesh
Version: V1

Purpose & usecase: Script to find the configuration changes in the config file
and its very usefull to rollback when the changes became service stop
comment

src_file=/etc/apache2/sites-available/000-default.conf
dest_file=/home/ubuntu/conf_tracking/apache2/000-default_changed.conf
mkdir -p /home/ubuntu/conf_tracking/apache2/

log_file=/var/log/changes_logs.txt
#Copy the Latest version 

cp $src_file $dest_file

echo "Checking changes in configuration file"

{
echo "----------verify changes on $(date '+%Y-%m-%d_%H-%M-%S')-------"
cd /home/ubuntu/conf_tracking/apache2/
#if [[ -n "$(git diff)" || -n "$(git diff --cached)" ]]; then
if ! git diff --quiet || ! git diff --cached --quiet ; then
echo " Chaneges detected in the configuration file "
git add $dest_file
echo "Added to git Local repo"
git commit -m "updated at $(date '+%Y-%m-%d_%H-%M-%S')" 
echo "Changes committed to local git repo"
git log -1
#git diff
else
echo " No changes detected "
fi

} >$log_file

echo "Logs save to $log_file ,please find "


