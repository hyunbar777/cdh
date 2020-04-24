use gmall;
DROP TABLE IF EXISTS `dwd_dim_sku_info`;
CREATE EXTERNAL TABLE `dwd_dim_sku_info` (
    `id` string COMMENT '商品id',
    `spu_id` string COMMENT 'spuid',
    `price` double COMMENT '商品价格',
    `sku_name` string COMMENT '商品名称',
    `sku_desc` string COMMENT '商品描述',
    `weight` double COMMENT '重量',
    `tm_id` string COMMENT '品牌id',
    `tm_name` string COMMENT '品牌名称',
    `category3_id` string COMMENT '三级分类id',
    `category2_id` string COMMENT '二级分类id',
    `category1_id` string COMMENT '一级分类id',
    `category3_name` string COMMENT '三级分类名称',
    `category2_name` string COMMENT '二级分类名称',
    `category1_name` string COMMENT '一级分类名称',
    `spu_name` string COMMENT 'spu名称',
    `create_time` string COMMENT '创建时间'
)
COMMENT '商品维度表'
PARTITIONED BY (`dt` string)
stored as parquet
location '/warehouse/gmall/dwd/dwd_dim_sku_info/'
tblproperties ("parquet.compression"="lzo");
--------------------------导入数据---------------------------------
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table dwd_dim_sku_info partition(dt='2020-03-10')
select
    sku.id,
    sku.spu_id,
    sku.price,
    sku.sku_name,
    sku.sku_desc,
    sku.weight,
    sku.tm_id,
    ob.tm_name,
    sku.category3_id,
    c2.id category2_id,
    c1.id category1_id,
    c3.name category3_name,
    c2.name category2_name,
    c1.name category1_name,
    spu.spu_name,
    sku.create_time
from
(
    select * from ods_sku_info where dt='2020-03-10'
)sku
join
(
    select * from ods_base_trademark where dt='2020-03-10'
)ob on sku.tm_id=ob.tm_id
join
(
    select * from ods_spu_info where dt='2020-03-10'
)spu on spu.id = sku.spu_id
join
(
    select * from ods_base_category3 where dt='2020-03-10'
)c3 on sku.category3_id=c3.id
join
(
    select * from ods_base_category2 where dt='2020-03-10'
)c2 on c3.category2_id=c2.id
join
(
    select * from ods_base_category1 where dt='2020-03-10'
)c1 on c2.category1_id=c1.id;