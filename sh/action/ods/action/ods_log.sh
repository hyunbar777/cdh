#!/bin/bash

# 定义变量
APP=gmall
hive=/opt/module/hive-1.2.1/bin/hive

# 如果是输入的日期按照取输入日期；如果没输入日期取当前时间的前一天
if [ -n $1 ]; then
    do_date=$1
else
  # shellcheck disable=SC2006
  do_date=`date -d '-1 day' +%F`
fi

echo "======================== 日期 $do_date ========================"



sql="
load data inpath '/origin_data/gmall/log/topic_start/$do_date'
 into table "$APP".ods_start_log partition(dt='$do_date');

load data inpath '/origin_data/gmall/log/topic_event/$do_date'
 into table "$APP".ods_event_log partition(dt='$do_date');
    
"
beeline -u "jdbc:hive2://hadoop100:10000/" -n hive -e "$sql"
