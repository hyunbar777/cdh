use gmall;
DROP TABLE IF EXISTS `dwd_dim_base_province`;
CREATE EXTERNAL TABLE `dwd_dim_base_province` (
    `id` string COMMENT 'id',
    `province_name` string COMMENT '省市名称',
    `area_code` string COMMENT '地区编码',
    `iso_code` string COMMENT 'ISO编码',
    `region_id` string COMMENT '地区id',
    `region_name` string COMMENT '地区名称'
)
COMMENT '地区省市表'
location '/warehouse/gmall/dwd/dwd_dim_base_province/';
--------------------------导入数据---------------------------------
insert overwrite table dwd_dim_base_province
select
    bp.id,
    bp.name,
    bp.area_code,
    bp.iso_code,
    bp.region_id,
    br.region_name
from ods_base_province bp
join ods_base_region br
on bp.region_id=br.id;