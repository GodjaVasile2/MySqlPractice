USE sql_store;

-- Selecting order_id, product_id, and note from order_items and order_item_notes tables
SELECT 
	oi.order_id,
    oi.product_id,
    oin.note
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_Id 
    

