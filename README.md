# Airbnb Listings Analysis — NYC (SQL + Power BI)

End-to-end data analysis project on NYC Airbnb listings: raw data is cleaned and queried in PostgreSQL, then visualized in an interactive Power BI dashboard to surface pricing, availability, and supply patterns across neighbourhoods.

## Objective

Analyze Airbnb listings data to understand pricing trends, availability patterns, and the key factors that drive listing prices — and turn that into a dashboard a host or analyst could actually use to benchmark pricing.

## Tools Used

- **SQL (PostgreSQL)** — data cleaning and business-question queries, including window functions and CTEs
- **Power BI** — interactive dashboard with KPI cards, a metric selector, and drill-through

## Project Structure

```
airbnb_analysis/
├── data/                          # Raw dataset (not included — see Dataset section)
├── sql/
│   ├── data_cleaning.sql              # Deduplication, null handling, text cleanup
│   ├── analysis_queries.sql           # Core business-question queries
│   ├── advanced_queries.sql           # Window functions, CTEs, ranking
│   └── dashboard_insight_queries.sql  # Price distribution, occupancy, demand-vs-price
├── powerbi/
│   └── airbnb_analysis.pbix       # Power BI dashboard
├── screenshots/
│   ├── power_bi dashboard/        # Dashboard export
│   └── sql_queries_analysis_otput/ # Query results from pgAdmin
└── README.md
```

## Dataset

NYC Airbnb listings data covering **225 distinct neighbourhoods**. The raw file is not committed to this repo due to size — download an NYC Airbnb listings dataset (e.g. Inside Airbnb or the Kaggle "NYC Airbnb" datasets), save it as `data/airbnb_data.csv`, and load it into PostgreSQL as `airbnb_data` before running the scripts below.

## Data Cleaning (`sql/data_cleaning.sql`)

- Created a working table (`airbnb_cleaned`) separate from the raw import
- Filled missing `reviews_per_month` values with `0`
- Trimmed whitespace from the `neighbourhood` field
- Checked for duplicate listing IDs

## Analysis Performed

**Core queries** (`sql/analysis_queries.sql`):
- Average price and total listings by neighbourhood
- Average price by room type
- Top 10 most expensive listings
- Availability distribution and availability-based price segmentation
- Estimated revenue by neighbourhood
- Price behavior by stay length (short / medium / long stay)
- High-price outlier detection (>$500/night)

**Advanced queries** (`sql/advanced_queries.sql`):
- Top 5 priciest and top 10 highest-supply neighbourhoods
- Room type distribution and average reviews by room type
- Listings ranked by price using `RANK() OVER (...)`
- Above-average and above-threshold pricing using subqueries and CTEs

**Insight queries** (`sql/dashboard_insight_queries.sql`):
- Price distribution buckets (for a histogram)
- Median price (robust to outliers)
- Estimated occupancy rate by neighbourhood
- Demand (reviews per month) vs. price tier

## Key Insights

- **Supply is concentrated**: across 225 neighbourhoods, Bedford-Stuyvesant (7,937 listings) and Williamsburg (7,775) lead by a wide margin over the next-largest markets like Harlem (5,466) and Bushwick (4,982).
- **Hotel Room is the priciest category**, averaging $668/night, versus ~$625/night for Private Room and Entire Home/Apt — a smaller gap than expected between the "budget" and "premium" room types.
- **Stay length barely moves price**: short-, medium-, and long-stay listings average $627, $623, and $619/night respectively, suggesting minimum-night requirements aren't a major pricing lever.
- **Portfolio-wide average price is $625.30/night** across the dataset.

## Power BI Dashboard

![Airbnb Dashboard](screenshots/power_bi%20dashboard/dashboard.png)

The dashboard (single page) includes:
- **Count of listings by neighbourhood** — top 6 neighbourhoods by supply
- **Avg price & total revenue by stay type** — short/medium/long stay comparison
- **Avg price by room type** — bar chart across the four room types
- **KPI cards** for average price and total listings, with a metric-selector field parameter to toggle the summary metric
- **An insights panel** summarizing the three takeaways above directly on the dashboard

## How to Reproduce

1. Load the raw CSV into PostgreSQL as a table named `airbnb_data`
2. Run `sql/data_cleaning.sql` to produce the cleaned `airbnb_cleaned` table
3. Run `sql/analysis_queries.sql` and `sql/advanced_queries.sql` to reproduce the analysis
4. Open `powerbi/airbnb_analysis.pbix` in Power BI Desktop, point the data source at your PostgreSQL database, and refresh

## Planned Dashboard Enhancements

The current dashboard covers listing counts, room-type pricing, and stay-type pricing. `dashboard-improvement-guide.md` (repo root) lays out the next iteration: a de-duplicated Total Listings measure, a price-distribution histogram, a top-priced-neighbourhoods chart, an occupancy-rate view, and dynamic (auto-updating) insight text driven by DAX instead of hardcoded copy.

## Author

Nithin Naga Sai
