# Executive Summary

## Project Overview
This project analyzes customer shopping trends to identify purchasing patterns, high-value customer segments, and seasonal sales behavior using SQL and Power BI.

## Key Objectives
- Understand customer demographics and purchasing behavior
- Identify top-performing product categories and seasons
- Segment customers by value for targeted marketing
- Visualize insights through an interactive dashboard

## Methodology
Raw data was cleaned using Python (see `notebooks/data_cleaning.ipynb`), then explored and analyzed using SQL scripts in the `sql/` directory. Final insights were visualized in a Power BI dashboard located in `dashboard/`.

## Key Findings
- **Clothing drives revenue by volume, Footwear drives it by price.** Clothing generates the most total revenue of the four categories, outselling Accessories by a meaningful margin — but Footwear has the highest average purchase amount despite lower transaction volume. These are two different growth levers and shouldn't be read as the same signal.
- **Purchase history does not predict order size.** Average purchase amount stays essentially flat (~$59–61) regardless of how many previous purchases a customer has or how frequently they buy. Engagement and ticket size are independent of each other in this dataset.
- **Non-subscribers generate the majority of revenue — but mostly because there are more of them.** Non-subscribers (2,847 of 3,900 customers) account for roughly 3x subscriber revenue, with a comparable average order value. Subscription status is a population-size story here, not a per-customer value story.
- **VIP customers outperform every other value segment, with one caveat.** VIPs lead in total revenue, average purchase amount, and average rating. However, `value_score` weights `purchase_amount` at 40% of its formula, so part of the revenue gap between segments is circular by construction — VIPs spend more in part *because* spending helped define them as VIP. The cleaner, non-circular signal is subscriber and discount-usage rate by segment, since those weren't used to build the score.
- **Payment method and shipping choice are not meaningful differentiators.** Revenue splits almost evenly across all six payment methods (15.7%–17.3% each), and discount usage rates hold in a tight 40–45% band regardless of payment or shipping type.

## Recommendations
- **Set category strategy by lever, not just by revenue rank.** Grow Clothing through volume tactics (traffic, bundling, repeat purchase incentives); grow Footwear through price/margin tactics (premium positioning, upsells) rather than applying the same playbook to both.
- **Don't use subscription status as a proxy for customer value.** Since subscribers and non-subscribers spend similarly per order, marketing spend aimed at "converting to subscriber" should be justified by retention or frequency goals, not by an assumed order-value lift.
- **Rebuild `value_score` before using it for external reporting.** Because purchase_amount is baked into the formula, remove or down-weight it (or report subscriber/discount rate by segment instead) before using this score to justify VIP-tier marketing spend, so the "VIPs are valuable" claim isn't just restating the formula.
- **Deprioritize payment- and shipping-based segmentation for now.** These dimensions show no meaningful spread in revenue or discount behavior and aren't worth building targeted campaigns around based on this dataset.
- **Treat this as a snapshot, not a trend line.** Each row represents one unique customer rather than a transaction history, so any future iteration of this analysis should pull time-stamped transaction data if the business wants to answer repeat-purchase or seasonality-over-time questions with confidence.
