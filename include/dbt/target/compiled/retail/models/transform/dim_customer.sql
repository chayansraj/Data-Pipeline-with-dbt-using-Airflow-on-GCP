-- dim_customer.sql

-- Create the dimension table
WITH customer_cte AS (
	SELECT DISTINCT
	    to_hex(md5(cast(coalesce(cast(Customer_id as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Country as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) as customer_id,
	    Country AS country
	FROM `articulate-case-398313`.`retail`.`raw_online_retail`
	WHERE Customer_id IS NOT NULL
)
SELECT
    t.*,
	cm.iso
FROM customer_cte t
LEFT JOIN `articulate-case-398313`.`retail`.`country` cm ON t.country = cm.nicename