drop table if exists dwt_coupon_topic;
create external table dwt_coupon_topic
(
    `coupon_id` string  COMMENT '优惠券ID',
    `get_day_count` bigint COMMENT '当日领用次数',
    `using_day_count` bigint COMMENT '当日使用(下单)次数',
    `used_day_count` bigint COMMENT '当日使用(支付)次数',
    `get_count` bigint COMMENT '累积领用次数',
    `using_count` bigint COMMENT '累积使用(下单)次数',
    `used_count` bigint COMMENT '累积使用(支付)次数'
)COMMENT '购物券主题宽表'
stored as parquet
location '/warehouse/gmall/dwt/dwt_coupon_topic/'
tblproperties ("parquet.compression"="lzo");