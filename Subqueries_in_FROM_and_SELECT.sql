-- Calculate total sales, average invoice amount, and difference for each client using Subqueries in the SELECT clause 
-- This can be usefull  can be useful in situations where you want to obtain specific aggregated information for each 
-- client and compare these values with global averages or other universal metrics.

USE sql_invoicing;
SELECT 
	client_id,
    name,
    (SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT total_sales) - (SELECT average) AS difference
FROM clients c ; 


-- This query is purely demonstrative, showing that we can use SELECT statements in the FROM clause. 
-- However, the better solution would be to use views for this analysis.


SELECT *
 FROM (
		SELECT 
			client_id,
			name,
			(SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) AS total_sales,
			(SELECT AVG(invoice_total) FROM invoices) AS average,
			(SELECT total_sales) - (SELECT average) AS difference
		FROM clients c )AS sales_summary
WHERE total_sales IS NOT NULL ;     


