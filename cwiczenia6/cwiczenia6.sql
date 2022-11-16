--zad1
with ct1 AS(
SELECT sum([SalesAmount]) AS sales
      ,ORDERDate
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
GROUP BY ORDERDate )
  
SELECT sales, avg(sales) OVER 
    (ORDER BY ORDERDate ROWS BETWEEN 3 PRECEDING AND current ROW)
    ,ORDERDate 
FROM ct1
ORDER BY ORDERDate


--zad2
with ct2 AS (
SELECT month([ORDERDate]) month_year
	  ,[SalesTerritoryKey]
      ,sum([SalesAmount]) AS sales
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
WHERE year(ORDERDate)='2011'
GROUP BY month([ORDERDate]), [SalesTerritoryKey] )

SELECT * FROM ct2


SELECT month_year, [1], [4], [6], [7], [8], [9], [10]
FROM (
  SELECT month([ORDERDate]) month_year, SalesAmount, [SalesTerritoryKey]
  FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
  WHERE year(ORDERDate) = '2011' 
) AS table_src
PIVOT
(
	sum(SalesAmount) FOR [SalesTerritoryKey] IN([1], [4], [6], [7], [8], [9], [10] )
) AS table1 ORDER BY month_year


--zad3
with ct3 AS(
SELECT [OrganizationKey]
      ,[DepartmentGROUPKey]
      ,[Amount]
FROM [AdventureWorksDW2019].[dbo].[FactFinance] )

SELECT [OrganizationKey]
      ,[DepartmentGROUPKey]
      ,sum([Amount]) AS amount FROM ct3
GROUP BY ROLLUP( [OrganizationKey]
                ,[DepartmentGROUPKey]) 
ORDER BY OrganizationKey

--zad4
with ct4 AS(
SELECT [OrganizationKey]
      ,[DepartmentGROUPKey]
      ,[Amount]
FROM [AdventureWorksDW2019].[dbo].[FactFinance] )

SELECT [OrganizationKey]
      ,[DepartmentGROUPKey]
      ,sum([Amount]) 
      AS amount FROM ct3
GROUP BY CUBE( [OrganizationKey]
              ,[DepartmentGROUPKey]) 
ORDER BY OrganizationKey


--zad5
with ct5 AS(
SELECT [OrganizationKey]
      ,sum([Amount]) AS amount_total
  FROM [AdventureWorksDW2019].[dbo].[FactFinance]
  WHERE year([Date]) = 2012
  GROUP BY OrganizationKey
)

SELECT do.OrganizationKey
      ,do.OrganizationName
      ,ct5.amount_total
      ,PERCENT_RANK() OVER (ORDER BY amount_total) AS percentile
FROM ct5
JOIN DimOrganization do ON do.OrganizationKey = ct5.OrganizationKey
ORDER BY OrganizationKey

--zad6
with ct6 AS(
SELECT [OrganizationKey]
      ,sum([Amount]) AS amount_total
FROM [AdventureWorksDW2019].[dbo].[FactFinance]
WHERE year([Date]) = 2012
GROUP BY OrganizationKey )

SELECT do.OrganizationKey
      ,do.OrganizationName
      ,ct6.amount_total
      ,PERCENT_RANK() OVER (ORDER BY amount_total) AS percentile
      ,STDEV(amount_total) OVER (ORDER BY do.OrganizationKey) AS std_ev
FROM ct6
JOIN DimOrganization do ON do.OrganizationKey = ct6.OrganizationKey
ORDER BY OrganizationKey