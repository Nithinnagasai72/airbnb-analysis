# Resume Content — Airbnb Listings Analysis (SQL + Power BI)

## Project title line
**Airbnb Listings Analysis Dashboard** | SQL (PostgreSQL), Power BI | [GitHub link]

## Bullet points

Pick 2–4 depending on how much space you have. Each is self-contained, so mix and match.

- Cleaned and analyzed a 100K+ record NYC Airbnb listings dataset in PostgreSQL, writing 15+ SQL queries — including window functions and CTEs — to answer pricing, availability, and supply questions across 225 neighbourhoods.

- Built an interactive Power BI dashboard with KPI cards, a dynamic metric selector, and drill-through filtering to visualize pricing and availability trends for NYC Airbnb listings.

- Identified that listing supply is concentrated in just a few neighbourhoods (Bedford-Stuyvesant and Williamsburg account for ~15% of all listings) and that minimum-stay requirements have minimal effect on nightly price, surfacing both findings directly in the dashboard's insights panel.

- Designed a SQL data-cleaning pipeline (null handling, deduplication, text normalization) to prepare raw listings data for analysis, ensuring consistent neighbourhood-level aggregation.

- Applied window functions (`RANK()`) and CTEs to segment and rank listings by price, room type, and stay duration, translating raw query output into three business-ready insights.

## One-line summary (for a projects list / portfolio index)

Analyzed 100K+ NYC Airbnb listings using PostgreSQL and Power BI to uncover pricing and supply trends across 225 neighbourhoods, presented through an interactive dashboard with KPI cards and drill-through insights.

## Notes

- Swap "100K+" for the exact row count if you know it precisely — the dashboard's Total Listings card reads 102.59K, so "100K+" is a safe, honest rounding.
- If asked in an interview "why did hotel rooms only cost slightly more than private rooms," that's a genuinely interesting finding to be ready to discuss — it's a good sign you understand your own data rather than just running queries.
