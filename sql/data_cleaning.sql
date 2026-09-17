--Airbnb Analytics Project
--Data Cleaning
--Author: Nithin Naga Sai

--Create cleaned table
CREATE TABLE airbnb_cleaned AS
SELECT * FROM airbnb_data;

--Handle null review values
UPDATE airbnb_cleaned
SET reviews_per_month = 0
WHERE reviews_per_month IS NULL;

--Remove extra spaces
UPDATE airbnb_cleaned
SET neighbourhood = TRIM(neighbourhood);

--Check for duplicate listing IDs
SELECT id, COUNT(*)
FROM airbnb_cleaned
GROUP BY id
HAVING COUNT(*) > 1;

--Remove duplicate listings, keeping one row per id
--(added: the check above only reported duplicates, it never removed them)
DELETE FROM airbnb_cleaned a
USING airbnb_cleaned b
WHERE a.ctid > b.ctid
AND a.id = b.id;

--Remove listings with an invalid (zero or negative) price
--(added: guards every downstream AVG/SUM against bad rows)
DELETE FROM airbnb_cleaned
WHERE price <= 0;
