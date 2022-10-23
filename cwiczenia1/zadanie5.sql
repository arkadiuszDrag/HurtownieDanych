SELECT 
    COUNT(order_id) as count_orders,
	date,
	datepart(hour, time) as hour
FROM orders
WHERE date = '2015-01-01'
GROUP BY date, datepart(hour, time);


