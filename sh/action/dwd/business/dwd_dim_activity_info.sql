use gmall;
drop table if exists dwd_dim_activity_info;
create external table dwd_dim_activity_info(
    `id` string COMMENT '编号',
    `activity_name` string  COMMENT '活动名称',
    `activity_type` string  COMMENT '活动类型',
    `condition_amount` string  COMMENT '满减金额',
    `condition_num` string  COMMENT '满减件数',
    `benefit_amount` string  COMMENT '优惠金额',
    `benefit_discount` string  COMMENT '优惠折扣',
    `benefit_level` string  COMMENT '优惠级别',
    `start_time` string  COMMENT '开始时间',
    `end_time` string  COMMENT '结束时间',
    `create_time` string  COMMENT '创建时间'
) COMMENT '活动信息表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/warehouse/gmall/dwd/dwd_dim_activity_info/';
--------------------------导入数据---------------------------------
set hive.exec.dynamic.partition.mode=nonstrict;
insert overwrite table dwd_dim_activity_info partition(dt='2020-03-10')
select
    info.id,
    info.activity_name,
    info.activity_type,
    rule.condition_amount,
    rule.condition_num,
    rule.benefit_amount,
    rule.benefit_discount,
    rule.benefit_level,
    info.start_time,
    info.end_time,
    info.create_time
from
(
    select * from ods_activity_info where dt='2020-03-10'
)info
left join
(
    select * from ods_activity_rule where dt='2020-03-10'
)rule on info.id = rule.activity_id;