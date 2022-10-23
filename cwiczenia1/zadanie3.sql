with cte as
(
    SELECT 
         od.order_details_id
        ,od.order_id
        ,od.pizza_id
        ,od.quantity
        ,o.date
        ,p.price * od.quantity as full_price
    FROM [cwiczenia1].[dbo].[order_details] od
    JOIN pizzas p ON p.pizza_id = od.pizza_id
    JOIN orders o ON o.order_id = od.order_id
    WHERE o.date LIKE '%-02-%'
)
SELECT TOP (10) sum_price, order_id
FROM 
(
    SELECT b.sum_price, b.order_id, rank() over(ORDER BY b.sum_price DESC) rank
    FROM
    (
        SELECT SUM(full_price) as sum_price, order_id
        FROM cte
        GROUP BY order_id
    ) b
) a
ORDER BY rank

