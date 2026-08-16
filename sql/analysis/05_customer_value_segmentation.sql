-- 05_customer_value_segmentation.sql
-- Segment customers by lifetime value (RFM-style approach)

WITH customer_value AS (
  SELECT
    customer_id,
    SUM(purchase_amount_usd) AS total_spend,
    COUNT(*) AS num_purchases,
    AVG(purchase_amount_usd) AS avg_order_value,
    MAX(previous_purchases) AS previous_purchases
  FROM customer_shopping_trends
  GROUP BY customer_id
)
SELECT
  customer_id,
  total_spend,
  num_purchases,
  avg_order_value,
  CASE
    WHEN total_spend >= 500 THEN 'High Value'
    WHEN total_spend >= 200 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS value_segment
FROM customer_value
ORDER BY total_spend DESC;
