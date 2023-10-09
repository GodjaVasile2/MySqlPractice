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
FROM orders;


-- Both queries are retriving order_id, order_date, and status (categorized as 'Active' or 'Archived').
-- But the second CASE query evaluates the order date and assigns the appropriate status dynamically based on the specified condition.
-- This approach allows for flexible and dynamic categorization without hardcoding the status values in the SELECT statement.

USE sql_invoicing;

SELECT 
	'First Half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION 
SELECT 
	'Second Half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION 
SELECT 
	'Total' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31'

-- In this query, UNION is used to combine results from different date ranges (first half of 2019, second half of 2019, and total for the year).
-- UNION is suitable when you want to stack results vertically, appending rows from each SELECT statement one after the other.
-- This approach works well for dividing the data into specific date ranges and calculating the total sales, payments, and expected values for each period.

-- On the other hand, the CASE statement, demonstrated in a previous example with orders, is useful when you need to dynamically evaluate each row
-- and conditionally assign values based on specific criteria. In the context of these invoices, using CASE might not be suitable for categorizing
-- invoices into date ranges as it does not directly address the need to split the data into distinct periods before processing.

-- Therefore, the choice between using UNION and CASE depends on the specific requirements of the task at hand.


