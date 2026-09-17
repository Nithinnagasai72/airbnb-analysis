# Making the Dashboard More Insight-Driven

## A quick honest note first

I can't open or edit your `.pbix` file directly — it's a proprietary binary format that only Power BI Desktop (or paid add-ons like Tabular Editor) can read, and I don't have Power BI Desktop available in this environment. Everything below is written so you can paste it straight into `powerbi/airbnb_analysis.pbix` yourself. It's about 20-30 minutes of work in Power BI Desktop, laid out step by step.

## 1. One data check worth doing first

Every neighbourhood average price you've pulled lands roughly between $370 and $715/night, and the dashboard's overall average is $625.30. That's well above where NYC Airbnb price benchmarks usually sit, so before you present this, it's worth a quick sanity check on the raw import:

```sql
SELECT MIN(price), MAX(price), AVG(price) FROM airbnb_data;
```

If that confirms the numbers, great — now you can speak to it confidently if an interviewer asks. If it looks off, it's usually a unit/currency issue from the original CSV import.

## 2. Fix the "Total Listings" KPI

102.59K total listings is high for a single-city dataset (the well-known NYC Airbnb dataset has roughly 48K rows). If the card is built on a plain `COUNT` or `SUM` and there's any relationship fan-out from the Metric Selector field-parameter table, it can double- or triple-count rows. Fix it with a measure that de-duplicates by listing id:

```DAX
Total Listings = DISTINCTCOUNT(airbnb_cleaned[id])
```

## 3. New DAX measures to add

```DAX
Avg Price = AVERAGE(airbnb_cleaned[price])

Median Price = MEDIAN(airbnb_cleaned[price])

Total Listings = DISTINCTCOUNT(airbnb_cleaned[id])

Est. Occupancy % = AVERAGE(365 - airbnb_cleaned[availability_365]) / 365
```

Dynamic "top neighbourhood" insight — this updates itself on every refresh instead of being typed into a static text box:

```DAX
Top Neighbourhood =
VAR RankedNbhd =
    TOPN(1, VALUES(airbnb_cleaned[neighbourhood]), [Total Listings], DESC)
RETURN
    CONCATENATEX(RankedNbhd, airbnb_cleaned[neighbourhood])

Insight - Top Neighbourhood =
"The busiest neighbourhood is " & [Top Neighbourhood] &
" with " & FORMAT([Total Listings], "#,0") & " listings."
```

## 4. New visuals worth adding

- **Price distribution histogram** (built from the `price_bucket` query in `sql/dashboard_insight_queries.sql`) — shows whether the high averages come from a few extreme listings or the whole dataset. Directly answers the data-quality question in step 1.
- **Top 10 priciest neighbourhoods**, sorted descending — you currently show a "count of listings" bar but not its price counterpart.
- **Room type distribution** (donut), placed next to the existing avg-price-by-room-type bar, so viewers see volume and price together.
- **Reviews per month vs. price** (scatter) — tests whether pricier listings actually see less demand.
- **Borough-level breakdown**, if your raw data has a `neighbourhood_group` column (the classic NYC dataset does) — 225 individual neighbourhoods is too granular for a first glance; show 5 boroughs, let people drill down.
- **Map visual colored by price**, if `latitude`/`longitude` exist — this is the single highest-impact visual for a portfolio screenshot.

## 5. Filters/slicers to add

- Room type
- Price range (slider)
- Neighbourhood or borough

## 6. Rewrite the insights panel

Swap the static text box for the dynamic measures from step 3 (as card visuals, or referenced inside one text box) so the takeaways can never go stale after a data refresh. Once wired up, insight lines like these write themselves:

- "[Top Neighbourhood] leads all 225 neighbourhoods in listing volume."
- "Hotel Room is the priciest category — about 7% above Private Room and Entire Home/Apt."
- "Estimated occupancy is highest in [neighbourhood] at [X]%."

## 7. Suggested layout

```
Row 1:  [Avg Price] [Median Price] [Total Listings] [Est. Occupancy %]
Row 2:  [Price distribution histogram]     [Top 10 priciest neighbourhoods]
Row 3:  [Map or borough breakdown]         [Reviews vs. price scatter]
Row 4:  [Dynamic insights panel]           [Slicers: room type, price, borough]
```

## Where the supporting queries live

All the SQL behind these new visuals is in `sql/dashboard_insight_queries.sql` — it's written against the standard NYC Airbnb Open Data column names, with a couple of blocks commented out (borough, host) in case your table doesn't have those columns.
