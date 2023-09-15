
  
    

    create or replace table `articulate-case-398313`.`retail`.`dim_datetime`
      
    
    

    OPTIONS()
    as (
      -- dim_datetime.sql

-- Create a CTE to extract date and time components
WITH datetime_cte AS (  
  SELECT DISTINCT
    InvoiceDate AS datetime_id,
    CASE
      WHEN LENGTH(InvoiceDate) = 16 THEN
        -- Date format: "DD/MM/YYYY HH:MM"
        PARSE_DATETIME('%m/%d/%Y %H:%M', InvoiceDate)
      WHEN LENGTH(InvoiceDate) <= 14 THEN
        -- Date format: "MM/DD/YY HH:MM"
        PARSE_DATETIME('%m/%d/%y %H:%M', InvoiceDate)
      ELSE
        NULL
    END AS date_part,
  FROM `articulate-case-398313`.`retail`.`raw_online_retail`
  WHERE InvoiceDate IS NOT NULL
)
SELECT
  datetime_id,
  date_part as datetime,
  EXTRACT(YEAR FROM date_part) AS year,
  EXTRACT(MONTH FROM date_part) AS month,
  EXTRACT(DAY FROM date_part) AS day,
  EXTRACT(HOUR FROM date_part) AS hour,
  EXTRACT(MINUTE FROM date_part) AS minute,
  EXTRACT(DAYOFWEEK FROM date_part) AS weekday
FROM datetime_cte
    );
  