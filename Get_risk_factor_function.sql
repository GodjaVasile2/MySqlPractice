--  The function, get_risk_factor_for_client, takes a client's ID as input and computes a personalized risk factor based on their invoice history.
--  By analyzing the client's invoice totals and count, the system accurately determines their financial behavior. 

DELIMITER $$
DROP FUNCTION IF EXISTS get_risk_factor_for_client;
CREATE FUNCTION get_risk_factor_for_client
(
	p_client_id INT 
)
RETURNS INTEGER
READS SQL DATA
BEGIN 
	DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
	DECLARE invoices_count INT;
    
    SELECT count(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices
    WHERE client_id = p_client_id;
    
    SET risk_factor = invoices_total / invoices_count * 5;
RETURN IFNULL(risk_factor, 0);
END $$

DELIMITER ;

SELECT 
	client_id,
    name,
    get_risk_factor_for_client(client_id) AS risk_factor
FROM clients
WHERE client_id = 1;