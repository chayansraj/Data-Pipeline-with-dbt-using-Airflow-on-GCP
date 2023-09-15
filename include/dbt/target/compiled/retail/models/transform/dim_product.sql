-- dim_product.sql
-- StockCode isn't unique, a product with the same id can have different and prices
-- Create the dimension table
SELECT DISTINCT
    to_hex(md5(cast(coalesce(cast(StockCode as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Description as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Price as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) as product_id,
		StockCode AS stock_code,
    Description AS description,
    Price AS price
FROM `articulate-case-398313`.`retail`.`raw_online_retail`
WHERE StockCode IS NOT NULL
AND Price > 0