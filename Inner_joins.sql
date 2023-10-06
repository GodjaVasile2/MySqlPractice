USE sql_store;


SELECT 
	o.order_id,
    o.customer_id,
    o.order_date,
    os.name AS order_status 
FROM orders o
JOIN order_statuses os
	ON o.status = os.order_status_id
    

 
