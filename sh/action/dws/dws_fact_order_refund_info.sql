drop table if exists dws_fact_order_refund_info;
create external table dws_fact_order_refund_info(
    `sku_id` string COMMENT '商品ID',
    `refund_reason_type` string COMMENT '退款原因类型',
    `refund_count` bigint COMMENT '退款次数',
    `refund_amount` decimal(10,2) COMMENT '退款金额'
) COMMENT '商品退款原因表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/warehouse/gmall/dwd/dws_fact_order_refund_info/';