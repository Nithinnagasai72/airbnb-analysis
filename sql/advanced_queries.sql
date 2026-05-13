--Airbnb Analytics Project
--Advanced SQL Queries
--Author: Nithin Naga Sai

--1.Top 5 most expensive neighbourhoods
SELECT neighbourhood ROUND(AVG(price),2)) AS avg_price
FROM airbnb_cleaned
GROUP BY neighbourhood
ORDER BY avg_price DESC
LIMIT 5;

--2.Room type distribution
SELECT room_type, COUNT(*) AS total_listings
FROM airbnb_cleaned
GROUP BY room_type
ORDER BY total_listings DESC;

--3.Lisitings with low availability
SELECT * FROM airbnb_cleaned
WHERE availability_365 < 50;

--4.Average availability by neighbourhood
SELECT neighbourhood,ROUND(AVG(availability),0) AS avg_availabilty
FROM airbnb_cleaned
GROUP BY neighbourhood
ORDER BY avg_availability DESC;

--5.Rank listings by price (Window Function)
SELECT name,neighbourhood,price,
RANK() OVER(ORDER BY price DESC) AS price_rank
FROM airbnb_cleaned

--6.Top neighbourhood with most lsitings
SELECT neighbourhood,
COUNT(*) AS total_lisitngs
FROM airbnb_cleaned
GROUP BY neighbourhood
ORDER BY total_lisitngs DESC
LIMIT 10;

--7.Average reviews by room type
SELECT room_type,ROUND(AVG(reviews),2) AS avg_reviews
FROM airbnb_cleaned
GROUP BY room_type
ORDER BY avg_reviews DESC;

--8 Lisitings above average price
SELECT name,neighbourhood,price FROM airbnbn_cleaned 
WHERE price > 
(
    SELECT AVG(price)
    FROM airbnb_cleaned
)

--Same with CTE
WITH expensive_listings AS (
    SELECT name,neighbourhood,price FROM airbnb_cleaned
    WHERE price > 500
)

SELECT * 
FROM expensive_lsitings

with avg_price_cte AS
(Select AVG(price) AS avg_price
FROM airbnbn_cleaned)

SELECT name,neighbourhood,room_type,price FROM airbnb_cleaned
WHERE price >
(
    SELECT avg_price
    FROM avg_price_cte
)
ORDER BY price DESC: