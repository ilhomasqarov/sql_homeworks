SELECT DISTINCT CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1
    FROM #Sales
    WHERE CustomerName = s.CustomerName AND MONTH(SaleDate) = 3 AND YEAR(SaleDate) = 2024
);


SELECT Product
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT SUM(Quantity * Price) AS TotalSales
        FROM #Sales
        GROUP BY Product
    ) AS Subquery
);


SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT DISTINCT Quantity * Price AS SaleAmount
    FROM #Sales
    ORDER BY SaleAmount DESC
    OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY
) AS Subquery;

SELECT 
    YEAR(SaleDate) AS Year,
    MONTH(SaleDate) AS Month,
    SUM(Quantity) AS TotalQuantitySold
FROM #Sales
GROUP BY YEAR(SaleDate), MONTH(SaleDate);

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.CustomerName != s2.CustomerName 
    AND s1.Product = s2.Product
);

SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

SELECT f1.ParentId AS PID, f1.ChildID AS CHID
FROM Family f1
JOIN Family f2 ON f1.ParentId = f2.ParentId
WHERE f1.ChildID != f2.ChildID;


SELECT o.CustomerID, o.OrderID, o.DeliveryState, o.Amount
FROM #Orders o
WHERE o.CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM #Orders
    WHERE DeliveryState = 'CA'
) AND o.DeliveryState = 'TX';

UPDATE #residents
SET fullname = 
    CASE 
        WHEN fullname NOT LIKE '%name=%' THEN fullname + ' name=' + SUBSTRING(address, CHARINDEX('name=', address) + 5, LEN(address))
        ELSE fullname 
    END
WHERE fullname NOT LIKE '%name=%';

SELECT ID, Vals, ROW_NUMBER() OVER (ORDER BY ID) AS Rank
FROM #RankingPuzzle;

SELECT e.EmployeeID, e.EmployeeName, e.Department, e.SalesAmount
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);


SELECT e.EmployeeID, e.EmployeeName, e.Department, e.SalesMonth, e.SalesYear
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales
    WHERE SalesMonth = e.SalesMonth 
    AND SalesYear = e.SalesYear 
    AND SalesAmount > e.SalesAmount
);

SELECT e.EmployeeID, e.EmployeeName, e.Department
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM #EmployeeSales
    WHERE

SELECT Name 
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

SELECT Name 
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);


SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');


SELECT Name
FROM Products
WHERE Price > (SELECT MIN(Price) FROM Products WHERE Category = 'Electronics');


SELECT p.Name
FROM Products p
WHERE p.Price > (
    SELECT AVG(Price) 
    FROM Products 
    WHERE Category = p.Category
);



SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders);

SELECT p.Name
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;
