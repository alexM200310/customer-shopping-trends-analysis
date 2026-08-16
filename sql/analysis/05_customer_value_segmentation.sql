/* ============================================================
   CUSTOMER VALUE SEGMENTATION & CATEGORY PERFORMANCE
   Goal: produce the exact aggregates dashboard will consume.
   Test for "do I need this query": can you picture the chart or
   KPI card it feeds?
   ============================================================ */


/* ---------- GROUP A: CUSTOMER VALUE SEGMENTATION ---------- */

/* 19. What does each value_segment look like on its own?
   Group by value_segment and compute count, total revenue,
   avg purchase_amount, and avg review_rating.

- Are VIP customers actually spending more, or just rated as "VIP" by score construction?
- Is there a meaningful revenue gap between segments, or is it mostly flat? */

select value_segment,
       count(*)                       as total_customers,
       sum(purchase_amount)           as total_revenue,
       round(avg(purchase_amount), 2) as avg_purchase_amount,
       round(avg(review_rating), 2)   as avg_review_rating
from customer
group by value_segment
order by avg_purchase_amount desc;

/* there are notable difference among each class across all sections, with vip leading in all columns
   by a significant amount when compared to the runner-up. although being last for total customers
   there isn't a significant difference between the classes with the ranges being 973-977. */

/**************************************************************************************/

/* 20. Does value_segment skew toward subscribers or discount users?
   Group by value_segment and is_subscriber (or discount_flag) together —
   two-dimension GROUP BY, same pattern as Question 18.

- Are your VIPs organically high-value, or are they VIP mostly because they're subscribers/non-discounters?
- Is the value_score double-counting something (e.g., penalizing discount users twice)? */

select value_segment,
       count(*)                                                                                             as total_segments,
       sum(case when discount_applied = 'Yes' then 1 else 0 end)                                            as discounted_orders,
       round((sum(case when discount_applied = 'Yes' then 1 else 0 end) * 100.0) / nullif(count(*), 0), 2)  as diss_rate_pct,
       sum(case when is_subscriber = 1 then 1 else 0 end)                                                   as total_subscriber,
       round((sum(case when is_subscriber = 1 then 1 else 0 end) * 100.0) / nullif(count(*), 0), 2)         as sub_rate_pct
from customer
group by value_segment
order by total_segments desc;

/**************************************************************************************/

/* 21. Who are the top customers within each value_segment?
   Rank customers by value_score within each segment.

- Who would a "VIP customer list" export actually contain?
- Is there a meaningful score gap between the top and bottom of each segment? */

select c.value_segment,
       c.customer_id,
       c.value_score
from customer c
where (select count(*)
       from customer c2
       where c2.value_segment = c.value_segment
         and c2.value_score > c.value_score) < 3
order by c.value_segment, c.value_score desc;

/* ---------- GROUP B: CATEGORY PERFORMANCE (REVISITED) ---------- */

/* 22. Which categories do high-value customers actually buy?
   Group by category and value_segment together.

Use this to answer:
- Do VIPs concentrate in a specific category, or are they spread evenly?
- Does the "top revenue category" from Day 3 hold up once you filter to just VIP customers?

Builds on earlier? Yes, heavily — this connects Day 3's category revenue findings
   (Questions 6-8) to Day 4's segmentation work.

When to stop: stop once you can name which category, if any, over-indexes on VIP customers. */

select value_segment,
       category,
       count(*)                                                                     as total_items,
       sum(purchase_amount)                                                         as total_revenue,
       round(100.0 * count(*) / sum(count(*)) over (partition by value_segment), 1) as pct_of_segment
from customer
group by value_segment, category
order by value_segment, pct_of_segment desc;

/**************************************************************************************/

/* 23. Which categories perform best on a per-customer basis, not just total revenue?
   Group by category, compute total revenue AND revenue divided by
   count(*) (or by distinct customer_id if that differs) — i.e., revenue-per-customer.

Use this to answer:
- Is there a "small but mighty" category that looks unimpressive by total
  revenue but strong per customer?
- Does this change the ranking from Question 6 (total revenue by category)?

Builds on earlier? Yes — this is a deliberate reframing of Question 6 using
   a different lens (efficiency vs. scale).

When to stop: stop once you've compared the total-revenue ranking to the
   per-customer ranking and named any category that moves significantly. */

select category,
       count(distinct customer_id)                     as distint_customers,
       sum(purchase_amount)                            as total_revenue,
       round(sum(purchase_amount) * 1.0 / count(*), 2) as revenue_per_customer

from customer
group by category
order by revenue_per_customer desc;


/* ---------- GROUP C: DASHBOARD-PREP CROSS-CUTS ---------- */

/* 24. How does value_segment vary by [age_group OR location] — pick one.
   Group by value_segment and your chosen dimension.

Use this to answer:
- Is there a demographic or geographic story worth putting on the dashboard,
  or is value_segment evenly distributed everywhere?

Builds on earlier? Yes — ties value_segment back to Day 3's demographic work.

When to stop: stop once you've picked ONE dimension (not both) and can say
   whether it produces a chart-worthy pattern or a flat, uninteresting result. */

select age_group, value_segment,
       count(*)                                                                  as total_customers,
       round(100.0 * count(*) / sum(count(*)) over (partition by age_group), 1)  as pct_of_age_group
from customer
group by age_group, value_segment
order by age_group, pct_of_age_group desc;

