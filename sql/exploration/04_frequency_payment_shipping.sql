-- 04_frequency_payment_shipping.sql
-- Explore purchase frequency, payment methods, and shipping preferences

SELECT frequency_of_purchases, COUNT(*) AS num_customers
FROM customer_shopping_trends
GROUP BY frequency_of_purchases
ORDER BY num_customers DESC;

SELECT payment_method, COUNT(*) AS num_transactions, SUM(purchase_amount_usd) AS total_spend
FROM customer_shopping_trends
GROUP BY payment_method
ORDER BY total_spend DESC;

SELECT shipping_type, AVG(review_rating) AS avg_rating
FROM customer_shopping_trends
GROUP BY shipping_type;
