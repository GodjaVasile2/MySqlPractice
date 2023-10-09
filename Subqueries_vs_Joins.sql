-- Problem 1: Find the clients without invoices 
-- This approach is intuitive as it directly addresses the problem of finding clients without invoices.
USE sql_invoicing;

SELECT 
	name
FROM clients 
WHERE client_id NOT IN (
						SELECT DISTINCT client_id 
						FROM invoices);

-- This approach might be less intuitive to some readers due to its reliance on JOIN operations                  
SELECT 
	c.name
FROM clients c
LEFT JOIN invoices i 
	USING(client_id)
WHERE invoice_id IS NULL ;


                        
-- Problem 2: Find the customer who ordered lettuce (id=3) 
-- SELECT customer_id, first_name and last_name 

--  Approach 1: Using subquery with JOIN operations
USE sql_store;

SELECT 
	customer_id,
    first_name,
    last_name
FROM customers 
WHERE customer_id IN (
						SELECT customer_id 
                        FROM orders o 
                        JOIN order_items oi USING (order_id)
                        WHERE product_id = 3
					);
                    
-- Approach 2: Using JOIN operations directly
SELECT DISTINCT 
	c.customer_id,
    c.first_name,
    c.last_name
FROM customers  c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id = 3; 

-- In this case Approach 2, using JOIN operations directly, is more natural and easy to understand in this situation,
-- as it provides a clear path of how the tables are related and filtered to find the desired result.