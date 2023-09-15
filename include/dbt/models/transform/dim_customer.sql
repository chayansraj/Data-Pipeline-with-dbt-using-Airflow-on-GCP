-- dim_customer.sql

-- Create the dimension table
WITH customer_cte AS (
	SELECT DISTINCT
	    {{ dbt_utils.generate_surrogate_key(['Customer_id', 'Country']) }} as customer_id,
	    Country AS country
	FROM {{ source('retail', 'raw_online_retail') }}
	WHERE Customer_id IS NOT NULL
)
SELECT
    t.*,
	cm.iso
FROM customer_cte t
LEFT JOIN {{ source('retail', 'country') }} cm ON t.country = cm.nicename