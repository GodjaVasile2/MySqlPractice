--  Scenario: This business aims to maintain a consistent inventory by ensuring that we always have in stock at least the quantity of products sold in the last 30 days.
--  This function analyzes the total quantity of the product sold in the last 30 days. It then compares this value with the current stock quantity for the specified product.
--  If the quantity sold is less than or equal to the current stock, the function returns 'In Stock'; otherwise, it indicates 'Out of Stock'.
USE sql_store;

DELIMITER $$
DROP FUNCTION IF EXISTS check_stock_availability;
CREATE FUNCTION check_stock_availability
(
	p_product_id INT
)
RETURNS VARCHAR(20)
BEGIN
    DECLARE stock_indicator VARCHAR(20);
    DECLARE total_sold INT;
    DECLARE current_stock INT;
    
    
    SELECT SUM(quantity) INTO total_sold
    FROM order_items oi
    JOIN orders o USING(order_id)
    WHERE product_id = p_product_id
		  AND o.order_date >= NOW() - INTERVAL 30 DAY;
    

    SELECT quantity_in_stock INTO current_stock
    FROM products
    WHERE product_id = p_product_id;
    
    -- Check if there are enough products in stock
    IF total_sold <= current_stock THEN
        SET stock_indicator = 'In Stock';
    ELSE
        SET stock_indicator = 'Out of Stock';
    END IF;
    
    RETURN stock_indicator;
END $$

DELIMITER ;

SELECT 
	product_id,
    name, 
    check_stock_availability(product_id) AS stock_check
FROM products