-- Get invoices exceeding average amount per client: valuable for targeted marketing and identifying VIP customers in e-commerce.

USE sql_invoicing;

SELECT * 
FROM invoices i
WHERE invoice_total > (
    SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
);

-- Advantage: Correlated subqueries can compare values within the context of each row being processed, allowing for more precise and context-aware filtering.

-- Disadvantages Correlated subqueries can be computationally expensive, especially with large datasets, as they require nested iterations over the same table.
-- This can impact query performance significantly.

