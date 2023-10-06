USE sql_store;

-- Scenario:
-- In an e-commerce platform, there is a need to categorize orders as active or archived
-- based on their order dates. Active orders are those placed within the last 4 years,
-- while archived orders are those placed more than 4 years ago.

SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE YEAR(order_date) >= YEAR(DATE_SUB(NOW(),INTERVAL 4 YEAR))
UNION 
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE YEAR(order_date) < YEAR(DATE_SUB(NOW(),INTERVAL 4 YEAR));


SELECT 
	order_id,
    order_date,
    CASE 
		WHEN 	YEAR(order_date) >= YEAR(DATE_SUB(NOW(),INTERVAL 4 YEAR)) THEN 'Active'
        ELSE 'Archived'
	END AS status
FROM orders


-- Both queries are retriving order_id, order_date, and status (categorized as 'Active' or 'Archived').
-- But the second CASE query evaluates the order date and assigns the appropriate status dynamically based on the specified condition.
-- This approach allows for flexible and dynamic categorization without hardcoding the status values in the SELECT statement.
