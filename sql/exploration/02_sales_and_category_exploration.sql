-- 02_sales_and_category_exploration.sql
-- Explore sales performance by category

SELECT category, SUM(purchase_amount_usd) AS total_sales, COUNT(*) AS num_purchases
FROM customer_shopping_trends
GROUP BY category
ORDER BY total_sales DESC;

SELECT season, category, AVG(purchase_amount_usd) AS avg_spend
FROM customer_shopping_trends
GROUP BY season, category
ORDER BY season, avg_spend DESC;
