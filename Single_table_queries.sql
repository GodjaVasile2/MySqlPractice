USE sql_store;

-- Retrieving high-value customers for a loyalty program promotion
-- For a loyalty program promotion, we want to target customers with a certain range of points (between 2000 and 3000).
SELECT * 
FROM customers 
WHERE points BETWEEN 2000 AND 3000;

-- Retrieving top 5 customers with the highest points 
-- For a special VIP event, we want to invite our top 5 customers based on their loyalty points.
SELECT * 
FROM customers
ORDER BY points DESC
LIMIT 5;

-- Selecting customers with missing contact information 
-- In order to update our customer database, we need to identify customers with missing phone numbers.
SELECT *
FROM customers 
WHERE phone IS NULL;

-- Retrieving rows that match a specific pattern in names 
-- To send personalized promotional materials, we want to target customers with specific names like 'Marry', 'Barwn', or 'Tina'.
SELECT *
FROM customers
WHERE CONCAT(first_name,' ',last_name) REGEXP 'Marry|Barwn|Tina';


