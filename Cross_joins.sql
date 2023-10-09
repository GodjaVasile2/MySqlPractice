USE sql_store;
-- This query is provided purely as an example and does not have any real-life application. 
-- It demonstrates the concept of a cross join between the "shippers" and "products" tables for educational purposes, showcasing the syntax and structure without serving a practical business use case.

-- Explicit Syntax (with JOIN keyword and ON clause)

SELECT 
	s.name AS Shipper,
    p.name AS Product
FROM shippers s
CROSS JOIN products p 
ORDER BY s.name;

-- Implicit Syntax (using comma for joining tables)
SELECT 
	s.name AS Shipper,
    p.name AS Product
FROM shippers s, products p
ORDER BY s.name;