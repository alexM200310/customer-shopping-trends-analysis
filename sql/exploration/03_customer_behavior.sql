
/* 10. How does spending vary by age group?
   Group by age_group and calculate transaction count, total revenue, and average purchase_amount.
   Since age_group already exists in your data, this is a very natural first segmentation question. */

select age_group,
       count(*)                       as num_customers,
       sum(purchase_amount)           as total_revenue,
       round(avg(purchase_amount), 2) as avg_purchase_amount
from customer
group by age_group
order by total_revenue desc;

/* each age group has almost exactly the same row count by construction.

/**************************************************************************************/

/* 11. How does gender affect purchase behavior?
   Group by gender and compute counts, revenue, and average spend.
   This is a straightforward demographic cut. */

select gender,
       count(*)                  as num_customers,
       sum(purchase_amount)           as total_revenue,
       round(avg(purchase_amount), 2) as avg_purchase_amount
from customer
group by gender
order by total_revenue desc;

/* Males spend and bring more revenue while the avg purchase amount is slightly lower
   than women with women having less orders. */

/**************************************************************************************/

/* 12. How do previous purchases relate to current spending?
   Use previous_purchases or your engineered previous_purchases_band to
   compare revenue and average transaction value. This begins to move
   from demographics to actual customer history.  */

select previous_purchases_band,
       count(*)                       as num_customers,
       sum(purchase_amount)           as total_revenue,
       round(avg(purchase_amount), 2) as avg_purchase_amount
from customer
group by previous_purchases_band
order by avg_purchase_amount;

/* average purchase amount across all purchases band is roughly falt across all bands, ($59-$61).
   suggesting that purchase history doesn't predict value in this dataset. */

/**************************************************************************************/

/* 13. How do subscribers compare with non-subscribers?
   Group by subscription_status or is_subscriber and compare transaction count,
   total revenue, average spend, and average review rating. This is a great business-facing query. */

select discount_applied,
       count(*)                       as subscription_count,
       sum(purchase_amount)           as total_revenue,
       round(avg(purchase_amount), 2) as average_spend,
       round(avg(review_rating), 2)   as average_rating
from customer
group by discount_applied
order by total_revenue desc;

/* while making profit on people who are subscribed, we see that people who aren't
   are almost 3x the total revenue from people who are with their average spend being
   more as well but not by a large margin. */

/**************************************************************************************/

/* 14. How does discount usage relate to purchase amount and rating?
   Group by discount_applied or discount_flag and compare spend and rating.
   This is one of the strongest Day 3 questions because it moves toward pricing and margin thinking. */

select discount_applied,
       count(*)                     as total_discount,
       sum(purchase_amount)         as total_revenue,
       round(avg(review_rating), 2) as average_rating
from customer
group by discount_applied
order by total_revenue desc;

/* customers with no discount would clearly have a higher revenue,
   they also pose a high review rating but with it being only 0.02. */