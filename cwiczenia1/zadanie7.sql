WITH etc AS(
    SELECT 
        p.pizza_id
        ,p.size
        ,o.date
        ,od.order_id
        ,od.quantity
    FROM [cwiczenia1].[dbo].[order_details] od
    JOIN pizzas p ON p.pizza_id = od.pizza_id
    JOIN orders o ON o.order_id = od.order_id
    WHERE o.date LIKE '2015-02%' or o.date LIKE '2015-03%'
)
SELECT size, SUM(quantity) as count 
FROM etc
GROUP BY size
ORDER BY count DESC