--  This script implements two triggers, that are created to update the 'invoices' table automatically
--  when a new payment is inserted or an existing payment is deleted from the 'payments' table.
--  Additionally, an 'payments_audit' table is created to maintain an audit trail of payment changes. (check Create_audit_payments_table scrript).


-- After inserting a new payment record into the 'payments' table, this trigger updates the corresponding invoice's payment total. 
DELIMITER $$
DROP TRIGGER IF EXISTS payment_after_insert;
CREATE TRIGGER payment_after_insert
	AFTER INSERT ON payments 
    FOR EACH ROW 
    BEGIN 
			UPDATE invoices 
			SET payment_total = payment_total + NEW.amount
            WHERE invoice_id = NEW.invoice_id;
            
			INSERT INTO payments_audit 
			VALUES (NEW.client_id, NEW.date, NEW.amount, 'Insert', NOW());
    END$$
    
-- After deleting a payment record from the 'payments' table, this trigger updates the corresponding invoice's payment total by subtracting  the deleted payment amount. 
    
DROP TRIGGER IF EXISTS payment_after_delete;
CREATE TRIGGER payment_after_delete 
	AFTER DELETE ON payments 
    FOR EACH ROW 
    BEGIN 
			UPDATE invoices 
			SET payment_total = payment_total - OLD.amount
            WHERE invoice_id = OLD.invoice_id;
            
            INSERT INTO payments_audit 
            VALUES (OLD.client_id, OLD.date, OLD.amount, 'Delete', NOW());
            
    END$$
    
    
DELIMITER ;


-- Testing the triggers
-- Inserting a new payment record
INSERT INTO payments 
VALUES (DEFAULT, 5, 3, '2019-08-06', 80, 1);

-- Deleting a payment record
DELETE FROM payments
WHERE payment_id = 15;



