/* 1. How many total rows and distinct customers are in the dataset?
   This tells you whether each row likely represents a transaction and gives you a first sense of scale.
   It does not depend on any earlier question, so this should be your first one. */

SELECT count(*)                    as total_rows,
       count(distinct customer_id) as distinct_customers
FROM customer;

/* total rows: 3900, distinct_customer: 3900
   We have 3900 rows of data with the same amount of distinict customers, which leds me to believe that each
   purchase is unquie and when moving on to more constructive scripts about the data we won't have any repeats
   &/or misleading data */

/**************************************************************************************/

/* 2. How many unique values exist for the main categorical columns?
   Check distinct counts for category, location, payment_method, shipping_type, season, gender,
   and frequency_of_purchases. This also stands alone, but it complements Question 1 by showing how much
   variety exists in the dataset. */

SELECT count(distinct category)               as num_of_categorys,
       count(distinct location)               as num_of_locations,
       count(distinct payment_method)         as num_of_payment_methods,
       count(distinct shipping_type)          as num_of_shipping_type,
       count(distinct season)                 as num_of_season,
       count(distinct gender)                 as num_of_gender,
       count(distinct frequency_of_purchases) as num_of_frequency_of_purchases
FROM customer;

/**************************************************************************************/

/* 3. What are the minimum, maximum, and average values for the main numeric columns?
   Focus on purchase_amount, review_rating, previous_purchases, and frequency_purchases_days.
   This starts to build slightly on Questions 1 and 2 because you now know what columns are important. */

SELECT
    /*  purchase amount */
    min(purchase_amount)                   as min_purchase_amount,
    max(purchase_amount)                   as max_purchase_amount,
    round(avg(purchase_amount), 2)         as avg_purchase_amount,
    /* review_rating */
    min(review_rating)                     as min_review_rating,
    max(review_rating)                     as max_review_rating,
    round(avg(review_rating), 2)           as avg_review_rating,
    /* previous_purchases */
    min(previous_purchases)                as min_previous_purchases,
    max(previous_purchases)                as max_previous_purchases,
    round(avg(previous_purchases), 2)      as avg_previous_purchases,
    /* purchase_frequency_days */
    min(purchase_frequency_days)           as min_purchase_frequency_days,
    max(purchase_frequency_days)           as max_purchase_frequency_days,
    round(avg(purchase_frequency_days), 2) as avg_purchase_frequency_days
FROM customer;

/**************************************************************************************/

/* 4. Which categories appear most often in the dataset?
   Group by category and count rows. This is your first true
   grouping query and helps establish the product mix. */

SELECT category,
       count(category) as category_count
FROM customer
group by category
order by category_count desc;

/**************************************************************************************/

/* 5. Which locations appear most often in the dataset?–-
   Group by location and count rows. This is parallel to Question 4, not dependent on it. */

SELECT location,
       count(location) as location_count
FROM customer
group by location
order by location_count desc;
