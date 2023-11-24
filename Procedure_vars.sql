DELIMITER $$ 

DROP PROCEDURE IF EXISTS buy_products$$
CREATE PROCEDURE buy_products(
    p_customer_id INT,
    p_product_id INT,
    p_quantity INT
)
BEGIN 
    DECLARE v_quantity_in_stock INT; 

    SELECT quantity_in_stock INTO v_quantity_in_stock
    FROM products
    WHERE product_id = p_product_id;

    IF v_quantity_in_stock >= p_quantity THEN  
        INSERT INTO orders (customer_id, order_date, status)
        VALUES (p_customer_id, NOW(), 1); -- 1 means processed

        UPDATE products 
        SET quantity_in_stock = (quantity_in_stock - p_quantity)
        WHERE product_id = p_product_id;

    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The selected quantity exceeds the available quantity in stock';
    END IF;
END$$

DELIMITER ;
