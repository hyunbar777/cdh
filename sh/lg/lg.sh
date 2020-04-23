#!/bin/bash

for host in hadoop100 hadoop101 ; do
    ssh $host "source /etc/profile;nohup java -classpath /opt/module/lib/log-collector-1.0-SNAPSHOT-jar-with-dependencies.jar com.duoduo.appclient.AppMain $1 $2 1>/opt/module/lg.log 2>&1 &"
done
