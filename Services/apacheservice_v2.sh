#!/bin/bash

<<comment
Script to check apache service is running
Version: V2
Author: Nidesh
comment

service=$(systemctl is-active --quiet apache2)
output=$?
<<comment
output is 0 then apache2 is running
output is 3 then apche2 service is stopped
output is 4 then apache2 service not found
comment


if [[ $output -eq 0 ]]; then
	echo " Apache is running "
else
	echo " Apache is not running!Attempting to restarting"
	systemctl restart apache2
        restart_status=$?

	if [[ $restart_status -eq 0 ]]; then
		echo "Apache service Restarted successfully"
	else
		echo " Failed to restart Apache service"
	fi
fi

