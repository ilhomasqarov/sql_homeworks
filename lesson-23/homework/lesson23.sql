SELECT Id, Dt, 
       RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;

SELECT COUNT(DISTINCT Id) AS Distinct_Ids, 
       rID, 
       SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) AS MaxValsPerId
GROUP BY rID;


SELECT Id, Vals
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;

WITH MaxVals AS (
    SELECT ID, Item, Vals,
           RANK() OVER (PARTITION BY ID ORDER BY Vals DESC) AS Rank
    FROM TestMaximum
)
SELECT ID, Item, Vals
FROM MaxVals
WHERE Rank = 1;


WITH MaxVals AS (
    SELECT Id, MAX(Vals) AS MaxVals
    FROM SumOfMax
    GROUP BY Id
)
SELECT Id, SUM(MaxVals) AS SumofMax
FROM MaxVals
GROUP BY Id;


SELECT Id, a, b,
       CASE WHEN (a - b) != 0 THEN (a - b) ELSE NULL END AS OUTPUT
FROM TheZeroPuzzle;


SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
SELECT AVG(UnitPrice) AS AverageUnitPrice
FROM Sales;

SELECT COUNT(*) AS TotalTransactions
FROM Sales;

SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;

SELECT Category, SUM(QuantitySold) AS TotalQuantitySold
FROM Sales
GROUP BY Category;

SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;

SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

SELECT SaleDate, Product, (QuantitySold * UnitPrice) AS Revenue,
       SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningTotal
FROM Sales;

SELECT Category, 
       SUM(QuantitySold * UnitPrice) AS TotalRevenue,
       (SUM(QuantitySold * UnitPrice) * 100.0 / (SELECT SUM(QuantitySold * UnitPrice) FROM Sales)) AS PercentageOfTotal
FROM Sales
GROUP BY Category;

SELECT S.SaleID, S.Product, S.QuantitySold, S.UnitPrice, S.SaleDate, S.Region, C.CustomerName
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID;


SELECT C.CustomerName, SUM(S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
GROUP BY C.CustomerName;


SELECT TOP 1 C.CustomerName, SUM(S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalRevenue DESC;

SELECT C.CustomerName, COUNT(*) AS TotalSales
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
GROUP BY C.CustomerName;

SELECT DISTINCT P.ProductName
FROM Products P
JOIN Sales S ON P.ProductID = S.ProductID;
