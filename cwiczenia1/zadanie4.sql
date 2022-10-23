WITH cte1 AS (
    SELECT
         o.order_id
        ,od.quantity as order_quantity
        ,o.date as order_date
        ,p.price
        ,p.price * od.quantity as full_price
        ,MONTH(o.date) as month_date
    FROM [cwiczenia1].[dbo].[order_details] od
    JOIN orders o ON o.order_id = od.order_id
    JOIN pizzas p ON p.pizza_id = od.pizza_id
),

cte2 AS (
    SELECT order_id, SUM(full_price) as order_amount
    FROM cte1
    GROUP BY order_id
),

cte3 AS (
    SELECT avg(cte2.order_amount) as average_month_amount, cte1.month_date
    FROM cte1
    JOIN cte2 ON cte2.order_id = cte1.order_id
    GROUP BY cte1.month_date
)
SELECT cte1.order_id, cte2.order_amount, cte1.order_date, cte3.average_month_amount
FROM cte3
JOIN cte1 ON cte1.month_date = cte3.month_date
JOIN cte2 ON cte2.order_id = cte1.order_id