#!/bin/bash

if [[ -n $1 ]]; then
cmd=$@
else
cmd=jps
fi


for host in hadoop100 hadoop101 hadoop102 ; do
 echo ------------------- $host ---------------
 ssh $host "source /etc/profile; $*"
done
