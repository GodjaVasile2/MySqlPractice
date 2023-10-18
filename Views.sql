-- Scenario: Automating payment reminders based on the balance and the time left until the due_date,
-- streamlining accounts receivable processes and improving cash flow by prompting clients to settle outstanding balances promptly.

CREATE OR REPLACE VIEW invoices_with_balance AS 
SELECT 
	i.invoice_id,
    i.invoice_total,
    i.payment_total,
    i.due_date,
    i.invoice_total - i.payment_total AS balance,
    c.name,
    c.phone
FROM invoices i 
JOIN clients c USING(client_id)
WHERE (i.invoice_total - i.payment_total) > 0
