--1. Average price by neighbourhood 
--Business Question: Which neighbourhood have highest average price?

SELECT neighbourhood, ROUND(AVG(price),2)
FROM airbnb_cleaned
GROUP BY neighbourhood;

--2. Total listings by neighbourhood
SELECT neighbourhood, COUNT(*) AS total_listings
FROM airbnb_cleaned
GROUP BY neighbourhood
ORDER BY total_listings DESC;

-- 3. Average price by room type

SELECT room_type, AVG(price) AS avg_price
FROM airbnb_cleaned
GROUP BY room_type
ORDER BY avg_price DESC;


-- 4. Top 10 most expensive listings

SELECT name, neighbourhood, price
FROM airbnb_cleaned
ORDER BY price DESC
LIMIT 10;


-- 5. Availability distribution

SELECT availability_365, COUNT(*) AS total_listings
FROM airbnb_cleaned
GROUP BY availability_365
ORDER BY availability_365;


-- 6. Total revenue estimation by neighbourhood
-- (Approximate: price * number of listings)

SELECT neighbourhood, SUM(price) AS total_revenue
FROM airbnb_cleaned
GROUP BY neighbourhood
ORDER BY total_revenue DESC;


-- 7. Price vs minimum nights

SELECT 
CASE 
WHEN minimum_nights <= 3 THEN 'Short Stay'
WHEN minimum_nights BETWEEN 4 AND 30 THEN 'Medium Stay'
ELSE 'Long Stay'
END AS stay_type,
COUNT(*) AS listings_count,
ROUND(AVG(price),2) AS avg_price
FROM airbnb_cleaned
GROUP BY stay_type;


-- 8. Detect high price outliers

SELECT *
FROM airbnb_cleaned
WHERE price > 500
ORDER BY price DESC;


-- 9. Top 5 neighbourhoods with most listings

SELECT neighbourhood, COUNT(*) AS total_listings
FROM airbnb_cleaned
GROUP BY neighbourhood
ORDER BY total_listings DESC
LIMIT 5;


-- 10. Listings with minimum nights > 30

SELECT *
FROM airbnb_cleaned
WHERE minimum_nights > 30
ORDER BY minimum_nights DESC;


-- 11. Average price per availability category

SELECT 
    CASE 
        WHEN availability_365 < 50 THEN 'Low Availability'
        WHEN availability_365 BETWEEN 50 AND 200 THEN 'Medium Availability'
        ELSE 'High Availability'
    END AS availability_category,
    AVG(price) AS avg_price
FROM airbnb_cleaned
GROUP BY availability_category;