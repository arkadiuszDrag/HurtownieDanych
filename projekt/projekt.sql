--1 

WITH cte1 AS (
	SELECT DIMCarrier.carrier_name, cast(Sales_fact.amount as decimal) as amount, year(date) as year_date
	FROM DIMCarrier
	LEFT JOIN Sales_fact on DIMCarrier.carrier_id = Sales_fact.carrier_id_key
	),

cte2 as (
	SELECT carrier_name, year_date, SUM(amount) as sum_amount
	FROM cte1
	GROUP BY  year_date, carrier_name
)
SELECT *,  RANK() OVER( ORDER BY sum_amount DESC) AS AmountRank FROM cte2


-- 2

WITH cte3 AS (
	SELECT DIMCarrier.carrier_name, cast(Sales_fact.amount as decimal) as amount, year(date) as year_date, month(date) as month_date
	FROM DIMCarrier
	LEFT JOIN Sales_fact on DIMCarrier.carrier_id = Sales_fact.carrier_id_key
	),

cte4 as (
	SELECT carrier_name, year_date, month_date, SUM(amount) as sum_amount
	FROM cte3
	GROUP BY  year_date, month_date, carrier_name
)
SELECT *,  PERCENT_RANK() OVER( ORDER BY sum_amount DESC) AS AmountRank FROM cte4


-- 3)
WITH cte5 AS (
	SELECT city, sum(cast(amount as decimal)) AS sum_amount, year(date) AS year_date
	FROM Sales_fact
	LEFT JOIN DIMCustomers on Sales_fact.customer_id_key = DIMCustomers.id_key
	GROUP BY date, city
	),

cte6 AS (
	SELECT city, year_date, sum(sum_amount) AS sum_amount 
	FROM cte5
	GROUP BY city, year_date
	)
SELECT rank() over( order by sum_amount desc) AS AmountRank, city, year_date, sum_amount
FROM cte6;
