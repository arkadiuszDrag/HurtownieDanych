with cte as(
    SELECT 
        pt.ingredients
        ,od.order_id
        ,o.date as order_date
    FROM [cwiczenia1].[dbo].[pizzas] p
    JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON od.pizza_id = p.pizza_id
    JOIN orders o ON o.order_id = od.order_id
    WHERE o.date LIKE '2015-03%'
)
SELECT a.order_id FROM 
(
    SELECT string_agg(ingredients, ', ') as all_ingredients, order_id
    FROM cte
    WHERE cte.ingredients NOT LIKE '%Pineapple%'
    GROUP BY cte.order_id
) a

