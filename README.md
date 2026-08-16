# Retail Revenue Quality & Customer Value Analysis

An end-to-end data analytics project exploring customer shopping trends using SQL, Python, and Power BI. This project covers data cleaning, exploratory analysis, customer value segmentation, and dashboard visualization.

## Business Objective

This project evaluates retail purchasing behavior to identify customer segments, product categories, and patterns that can improve revenue quality and guide targeted marketing decisions.

## Key Questions

- Which product categories drive revenue by volume vs. by price?
- Does purchase history or frequency predict order size?
- Is subscription status a meaningful indicator of customer value?
- Are payment method and shipping choice useful segmentation variables?

## Key Findings

- **Clothing drives revenue by volume, Footwear drives it by price.** These are two different growth levers.
- **Purchase history does not predict order size.** Average order value stays flat regardless of purchase frequency.
- **Non-subscribers generate most revenue mainly due to population size**, not higher per-customer value.
- **VIP customers lead in revenue and rating, with a caveat** — the value score partly bakes in purchase amount, so the signal is partially circular.
- **Payment method and shipping choice are not meaningful differentiators** of revenue or discount behavior.

See `docs/executive_summary.md` for full findings and recommendations.

## Dashboard Preview

![Dashboard Overview](dashboard/screenshots/dashboard_overview.png)

## Project Structure

```
customer-shopping-trends-analysis/
├── dashboard/          # Power BI dashboard file and screenshots
├── data/
│   ├── raw/            # Original raw dataset
│   └── cleaned/        # Cleaned dataset ready for analysis
├── notebooks/          # Jupyter notebooks for data cleaning
├── sql/
│   ├── exploration/    # Exploratory SQL queries
│   └── analysis/       # Customer value segmentation analysis
└── docs/               # Executive summary and documentation
```

## Tools Used

- SQL (data exploration and analysis)
- Python / Jupyter (data cleaning)
- Power BI (dashboard visualization)

## Getting Started

1. Review the raw dataset in `data/raw/`.
2. Run `notebooks/data_cleaning.ipynb` to produce the cleaned dataset.
3. Execute the SQL scripts in `sql/exploration/` and `sql/analysis/` to explore trends and segment customers.
4. Open `dashboard/Customer Shopping Trends KPI Dashboard.pbix` in Power BI to explore the interactive dashboard.
5. See `docs/executive_summary.md` for a summary of findings and recommendations.

## Limitations

Each row in this dataset represents one unique customer rather than a full transaction history, so this analysis is a snapshot rather than a trend line. Future iterations should incorporate time-stamped transaction data to answer repeat-purchase or seasonality-over-time questions with confidence.
