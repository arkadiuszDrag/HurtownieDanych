WITH etc AS(
    SELECT 
        pt.pizza_type_id
        ,pt.name
        ,pt.category
        ,o.date
        ,od.order_id
        ,od.quantity
    FROM [cwiczenia1].[dbo].[order_details] od
    JOIN pizzas p ON p.pizza_id = od.pizza_id
    JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
    JOIN orders o ON o.order_id = od.order_id
    WHERE o.date LIKE '2015-01%'
)
SELECT category, name, SUM(quantity) as count 
FROM etc
GROUP BY name, category
ORDER BY count DESC