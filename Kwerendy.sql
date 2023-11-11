
SELECT OrderDate, COUNT(OrderQuantity) as Orders_cnt  
FROM dbo.FactInternetSales 
GROUP BY OrderDate 
HAVING COUNT(OrderQuantity) < 100 
ORDER BY Orders_cnt DESC;



WITH ranked AS (
    SELECT
        ProductKey,
        UnitPrice,
		OrderDate,
		OrderQuantity,
        ROW_NUMBER() OVER (PARTITION BY OrderDate ORDER BY UnitPrice DESC) AS RowNumber
    FROM
        dbo.FactInternetSales
)
SELECT
	ProductKey,
    OrderDate,
    UnitPrice
FROM
    ranked
WHERE
    RowNumber <= 3
ORDER BY OrderDate;