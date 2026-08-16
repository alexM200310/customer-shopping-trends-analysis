
/* 6. Which categories generate the most total revenue?
   Group by category and sum purchase_amount. This is more meaningful than just transaction
   count because it shows financial contribution.  */

Select category,
       sum(purchase_amount) as total_revenue
from customer
group by category
order by total_revenue desc;

/* we can see here that clothing is what is driving the sales more than any
 other category by more than $30,000 sold to accessories. */

/**************************************************************************************/

/* 7. Which categories have the highest average purchase amount?
Group by category and average purchase_amount. This complements Question 6.  */

Select category,
       round(avg(purchase_amount), 2) as avg_purchase_amount,
       count(category)                as category_count
from customer
group by category
order by avg_purchase_amount desc;

/* even now knowing that clothing is the most amount of items purchased,
   we can detail that footwear, on average, brings in more revenue due to its price. */

/**************************************************************************************/

/* 8. Which categories have both strong revenue and strong transaction volume?
   This is where you combine the logic of Questions 4, 6, and 7, often using a
   grouped result with revenue, count, and average purchase amount together.
   You are trying to find categories that are broadly strong, not just strong on one metric. */

select category,
    sum(purchase_amount)           as total_revenue,
    count(*)                       as category_count,
    round(avg(purchase_amount), 2) as avg_purchase_amount
from customer
group by category
order by total_revenue desc;

/* the more consistent categories purchased would be clothing & accessories with
   their high volume in item sales, & avg amount spent. while the opposite is for
   outerwear were it performs last when compared to the other 3 categories. */

/**************************************************************************************/

/* 9. How do item variations like color and size relate to average spend?
   Group by color or size and compute average purchase_amount. This adds product detail beyond category. */

/* color */
select color,
       round(avg(purchase_amount), 2) as avg_purchase_amount,
       count(*)                       as num_purchases
from customer
group by color
order by avg_purchase_amount desc;

/* size */
select size,
       round(avg(purchase_amount), 2) as avg_purchase_amount,
       count(*)                       as num_purchases
from customer
group by size
order by avg_purchase_amount desc;