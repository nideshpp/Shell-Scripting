#!/bin/bash

<<comment
Script to verify Apache service is running
Version: V1
Author: Nidesh
comment

#command
service=$(netstat -tulnp | grep apache2 | wc -l)
#service=$(netstat -tulnp | grep -c apache2)


if [[ $service -ge 1 ]]
then
	echo "------Apache is running fine----"
else
	systemctl restart apache2
	echo "Apache service is restarted successfully"
fi

