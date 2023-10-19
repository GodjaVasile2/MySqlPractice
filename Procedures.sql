DELIMITER $$

-- Procedure 1: Get Invoices with Positive Balance
-- This procedure retrieves invoices from the 'invoices_with_balance' view where the balance (calculated as invoice_total - payment_total) is greater than 0.
DROP PROCEDURE IF EXISTS get_invoices_with_balance;
CREATE PROCEDURE get_invoices_with_balance()
BEGIN 
	SELECT * 
    FROM invoices_with_balance  -- 'invoices_with_balance' is a view containing invoices with calculated balances.
    WHERE balance > 0 ;
END$$


-- Procedure 2: Get Clients by State
-- This procedure returns clients based on a specified state. If no state is specified (null), it returns all clients.
DROP PROCEDURE IF EXISTS get_clients_by_state;
CREATE PROCEDURE get_clients_by_state
(
	p_state CHAR(2) 
)
BEGIN
    IF p_state IS NULL THEN  
		SELECT * FROM clients; 
	ELSE
		SELECT * 
		FROM clients
		WHERE p_state = state;  
	END IF ;
END$$
-- Alternatively, the IF statement could be replaced with an IFNULL statement as follows:
-- SELECT * FROM clients WHERE state = IFNULL(p_state, state);


-- Procedure 3: Update Invoices with User Input
-- This procedure updates invoice records based on user input for invoice ID, payment amount, and payment date. It validates the payment amount parameter.
DROP PROCEDURE IF EXISTS update_invoices;
CREATE PROCEDURE update_invoices
(
	p_invoice_id INT, 
    p_payment_amount DECIMAL(9,2), 
    p_payment_date DATE 
)
BEGIN 
	IF p_payment_amount <= 0 THEN 
		SIGNAL SQLSTATE '22003' -- get the specific message from  https://www.ibm.com/docs/en/db2-for-zos/11?topic=codes-sqlstate-values-common-error
			SET MESSAGE_TEXT =  'The numeric value is out of range';
    END IF;
	
	UPDATE invoices 
    SET 
		payment_total = (payment_total + p_payment_amount),
        payment_date = p_payment_date
	WHERE invoice_id = p_invoice_id; 
END$$

-- Procedure 4: Get Unpaid Invoices and Total Sum for a Client
-- This procedure calculates the number of unpaid invoices and their total sum for a given client, using output parameters.
DROP PROCEDURE IF EXISTS get_unpaid_invoices_for_client;
CREATE PROCEDURE get_unpaid_invoices_for_client
(
	p_client_id INT, 
    OUT invoices_count INT,
    OUT unpaid_sum DECIMAL(9, 2) 
)
BEGIN 
	SELECT 
		COUNT(*),
        SUM(invoice_total)
    INTO 
		invoices_count,
        unpaid_sum
	FROM invoices 
    WHERE client_id = p_client_id 
		AND payment_total = 0; 
END $$

DELIMITER ;
