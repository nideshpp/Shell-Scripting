#!/bin/bash

<<comment
Version:V1
Author:Nidesh
Script for file backup script
Goals: Archive and Compress Src file to other destination
comment

set -e

#variable
src=/etc/passwd
dest=/tmp/backup
mkdir -p $dest   
timestamp=$(date +%F-%H-%M-%S )
filename="data-backup-$timestamp.tar.gz"

#commands
tar -czf $dest/$filename $src 2>>/dev/null
echo -e "Backup completed at $timestamp " >> $dest/backup.log
