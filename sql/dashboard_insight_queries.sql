--Airbnb Analytics Project
--Additional Queries for a More Insight-Driven Dashboard
--Author: Nithin Naga Sai
--
--Written against the classic NYC Airbnb Open Data schema:
--id, name, host_id, host_name, neighbourhood_group, neighbourhood,
--latitude, longitude, room_type, price, minimum_nights, number_of_reviews,
--last_review, reviews_per_month, calculated_host_listings_count, availability_365
--
--If your raw table is missing a column referenced in a block below, skip
--that block — the rest of the file doesn't depend on it. Commented-out
--blocks (5 and 6) are for columns not used anywhere else in this repo, so
--confirm they exist in your data before uncommenting.

--1. Price distribution buckets (for a histogram — shows whether the high
--   averages you're seeing come from a few extreme listings or the whole
--   dataset)
SELECT
    CASE
        WHEN price < 100 THEN '$0-99'
        WHEN price < 250 THEN '$100-249'
        WHEN price < 500 THEN '$250-499'
        WHEN price < 1000 THEN '$500-999'
        ELSE '$1000+'
    END AS price_bucket,
    COUNT(*) AS total_listings
FROM airbnb_cleaned
GROUP BY price_bucket
ORDER BY MIN(price);

--2. Median price (robust to outliers — worth showing next to the average)
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM airbnb_cleaned;

--3. Estimated occupancy rate by neighbourhood
--   (booked-nights proxy = 365 - availability_365; a better "how in-demand
--   is this neighbourhood" measure than raw listing counts)
SELECT neighbourhood,
       ROUND(AVG(365 - availability_365) / 365.0 * 100, 1) AS est_occupancy_pct
FROM airbnb_cleaned
GROUP BY neighbourhood
ORDER BY est_occupancy_pct DESC
LIMIT 10;

--4. Demand vs. price: do pricier listings get fewer reviews (less demand)?
SELECT
    CASE
        WHEN price < 250 THEN 'Budget (<$250)'
        WHEN price < 500 THEN 'Mid ($250-499)'
        ELSE 'Premium ($500+)'
    END AS price_tier,
    ROUND(AVG(reviews_per_month), 2) AS avg_reviews_per_month
FROM airbnb_cleaned
GROUP BY price_tier
ORDER BY avg_reviews_per_month DESC;

--5. Borough-level summary (only if your table has neighbourhood_group)
-- SELECT neighbourhood_group, COUNT(*) AS total_listings,
--        ROUND(AVG(price),2) AS avg_price
-- FROM airbnb_cleaned
-- GROUP BY neighbourhood_group
-- ORDER BY total_listings DESC;

--6. Top hosts by number of listings (only if your table has host_id/host_name)
-- SELECT host_id, host_name, COUNT(*) AS listings_owned
-- FROM airbnb_cleaned
-- GROUP BY host_id, host_name
-- ORDER BY listings_owned DESC
-- LIMIT 10;
