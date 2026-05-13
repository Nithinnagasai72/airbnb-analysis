--Create cleaned table
CREATE TABLE airbnb_cleaned AS
SELECT * FROM airbnb_data;

--handle null review values
UPDATE airbnb_cleaned 
SET reviews_per_month = 0
WHERE reviews_per_month IS NULL:

--Remove extra spaces
UPDATE airbnb_cleaned
SET neighbourhood =
TRIM(neighbourhood);

--Check duplicates
SELECT id, COUNT(*)
FROM airbnb_cleaned
GROUP BY id
HAVING COUNT(*) > 1;