drop table if exists dws_coupon_use_daycount;
create external table dws_coupon_use_daycount
(
    `coupon_id` string  COMMENT '优惠券ID',
    `coupon_name` string COMMENT '购物券名称',
    `coupon_type` string COMMENT '购物券类型 1 现金券 2 折扣券 3 满减券 4 满件打折券',
    `condition_amount` string COMMENT '满额数',
    `condition_num` string COMMENT '满件数',
    `activity_id` string COMMENT '活动编号',
    `benefit_amount` string COMMENT '减金额',
    `benefit_discount` string COMMENT '折扣',
    `create_time` string COMMENT '创建时间',
    `range_type` string COMMENT '范围类型 1、商品 2、品类 3、品牌',
    `spu_id` string COMMENT '商品id',
    `tm_id` string COMMENT '品牌id',
    `category3_id` string COMMENT '品类id',
    `limit_num` string COMMENT '最多领用次数',
    `get_count` bigint COMMENT '领用次数',
    `using_count` bigint COMMENT '使用(下单)次数',
    `used_count` bigint COMMENT '使用(支付)次数'
) COMMENT '每日优惠券统计'
PARTITIONED BY (`dt` string)
stored as parquet
location '/warehouse/gmall/dws/dws_coupon_use_daycount/'
tblproperties ("parquet.compression"="lzo");