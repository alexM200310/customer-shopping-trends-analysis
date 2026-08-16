-- 03_customer_behavior.sql
-- Explore customer demographics and purchasing behavior

SELECT gender, AVG(age) AS avg_age, COUNT(*) AS num_customers
FROM customer_shopping_trends
GROUP BY gender;

SELECT subscription_status, AVG(purchase_amount_usd) AS avg_spend, AVG(previous_purchases) AS avg_previous_purchases
FROM customer_shopping_trends
GROUP BY subscription_status;

SELECT location, COUNT(*) AS num_customers, SUM(purchase_amount_usd) AS total_spend
FROM customer_shopping_trends
GROUP BY location
ORDER BY total_spend DESC;
