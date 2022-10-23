
with cte as(
    SELECT od.[order_details_id]
        ,od.[order_id]
        ,od.[pizza_id]
        ,od.[quantity]
        ,p.price * od.quantity summarized_amount
        ,o.[date] as order_date
    FROM [cwiczenia1].[dbo].[order_details] od
    JOIN pizzas p on p.pizza_id = od.pizza_id
    JOIN orders o on o.order_id = od.order_id
    WHERE o.date = '2015-02-18'
    )

select avg(summarized_amount), order_date
from cte
group by order_date
