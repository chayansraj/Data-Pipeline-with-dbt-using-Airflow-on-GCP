-- dim_product.sql
-- StockCode isn't unique, a product with the same id can have different and prices
-- Create the dimension table
SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['StockCode', 'Description', 'Price']) }} as product_id,
		StockCode AS stock_code,
    Description AS description,
    Price AS price
FROM {{ source('retail', 'raw_online_retail') }}
WHERE StockCode IS NOT NULL
AND Price > 0