
/* 15. How does purchase frequency affect revenue and average spend?
   Use frequency_of_purchases or frequency_purchases_days, or your engineered frequency_band_days,
   to compare groups. This is one of the most important behavior questions in your dataset. */

select frequency_band_days,
       count(*)                       as total_num_purchases,
       sum(purchase_amount)           as total_revenue,
       round(avg(purchase_amount), 2) as avg_purchase_amount
from customer
group by frequency_band_days
order by total_num_purchases desc;

/* average purchase amount stays roughly flat (~$59-61) across all four frequency bands
   despite significant differences in revenue in each group. frequent customers led in
   total revenue by a big margin because of their large amount of customers not because they spend more and average */

/**************************************************************************************/

/* 16. Which payment methods are most common, and which are tied to higher spending?
   Group by payment_method and compute counts, total revenue, and average spend.
   This is a strong practical business query. */

select payment_method,
       count(*)                       as total_payment_method,
       sum(purchase_amount)           as total_revenue,
       round(avg(purchase_amount), 2) as avg_purchase_amount
from customer
group by payment_method
order by total_revenue desc;

/* average purchase amount stays roughly flat (~$59-61) across all forms of payment with credit card leading in total revenue
   but paypal leading in total amount of times used to pay but by only 6 counts. roughly cc, paypal, & cash all have similar numbers,
   across all categories, with the 3 of them being the most popular forms of payment.
   */

/**************************************************************************************/

/* 17. How do shipping types compare in terms of revenue and review rating?
   Group by shipping_type or shipping_speed and compare spend and satisfaction.
   This helps connect operations to customer experience. */

select shipping_type,
       count(*)                       as total_shipping_type,
       round(avg(review_rating), 2)   as avg_review,
       round(avg(purchase_amount), 2) as avg_revenue_amount
from customer
group by shipping_type
order by avg_revenue_amount desc;

/* standard shipping has the highest rating while having the lowest avg purchase amount, with 2-day shipping beating it
   with an amount of 60.73. also seeing how the top 3 have faster shipping they also boast the highest avg revenue amount */

/**************************************************************************************/

/* 18. Does discount behavior differ across payment or shipping groups?
   This is a two-dimension query, such as discount × payment method or discount × shipping type.
   It is more advanced than the earlier questions but still very doable with GROUP BY and aggregates. */

select payment_method,
       count(*)                                                                                            as total_count,
       sum(case when discount_applied = 'Yes' then 1 else 0 end)                                           as discounted_orders,
       round((sum(case when discount_applied = 'Yes' then 1 else 0 end) * 100.0) / nullif(count(*), 0), 2) as diss_rate_pct
from customer
group by payment_method
order by diss_rate_pct desc;

/* discount rate percentage stays in between 40-45 percent. with debit card & venmo having the highest percentage amongst the methods */

select shipping_type,
       count(*)                                                                                            as total_count,
       sum(case when discount_applied = 'Yes' then 1 else 0 end)                                           as discounted_orders,
       round((sum(case when discount_applied = 'Yes' then 1 else 0 end) * 100.0) / nullif(count(*), 0), 2) as diss_rate_pct
from customer
group by shipping_type
order by diss_rate_pct desc;

/* discount rate percentage stays in between 40-45 percent. there's no standout among them.