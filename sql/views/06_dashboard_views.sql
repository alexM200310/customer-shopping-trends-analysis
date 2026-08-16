-- 06_dashboard_views.sql
-- Views to power the Power BI dashboard

CREATE OR REPLACE VIEW vw_sales_by_category AS
SELECT category, SUM(purchase_amount_usd) AS total_sales, COUNT(*) AS num_purchases
FROM customer_shopping_trends
GROUP BY category;

CREATE OR REPLACE VIEW vw_customer_segments AS
SELECT
  customer_id,
  SUM(purchase_amount_usd) AS total_spend,
  CASE
    WHEN SUM(purchase_amount_usd) >= 500 THEN 'High Value'
    WHEN SUM(purchase_amount_usd) >= 200 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS value_segment
FROM customer_shopping_trends
GROUP BY customer_id;

CREATE OR REPLACE VIEW vw_seasonal_trends AS
SELECT season, category, SUM(purchase_amount_usd) AS total_sales
FROM customer_shopping_trends
GROUP BY season, category;
