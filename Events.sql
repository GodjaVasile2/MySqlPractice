SHOW variables LIKE 'event%'; 
    -- Checks the current state of the event_scheduler variable to see if automated events are enabled or disabled
SET GLOBAL event_scheduler = ON; 
	-- If the event_scheduler variable is turned OFF by default, this command sets it to ON, enabling automated events


-- This event is designed to reduce the loyalty points of customers who haven't placed any orders within the last year. 
-- The event runs every 1 year, starting from '2018-01-01' and ending on '2028-01-01'and updates
-- the 'points' column in the 'customers' table, setting the points to 0 for customers who do not have any orders within the last year.


DELIMITER $$

DROP EVENT IF EXISTS delete_point_for_inactivity;
CREATE EVENT delete_point_for_inactivity
ON SCHEDULE
	EVERY 1 YEAR STARTS '2018-01-01' ENDS '2028-01-01'
DO BEGIN
	UPDATE customers 
    SET points = 0 
    WHERE customer_id NOT IN (SELECT customer_id 
			FROM orders 
            WHERE order_date >= NOW() - INTERVAL 1 YEAR);
END$$


DELIMITER ;