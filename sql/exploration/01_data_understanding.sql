-- 01_data_understanding.sql
-- Initial exploration: schema, row counts, null checks

SELECT * FROM customer_shopping_trends LIMIT 100;

SELECT COUNT(*) AS total_rows FROM customer_shopping_trends;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'customer_shopping_trends';
