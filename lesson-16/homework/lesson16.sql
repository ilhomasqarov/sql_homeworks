WITH Numbers AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1
    FROM Numbers
    WHERE Number < 1000
)
SELECT * FROM Numbers
OPTION (MAXRECURSION 1000);


SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    SalesSummary.TotalSales
FROM Employees E
JOIN (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS SalesSummary
    ON E.EmployeeID = SalesSummary.EmployeeID;

WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT * FROM AvgSalaryCTE;


SELECT 
    P.ProductID,
    P.ProductName,
    MaxSalesPerProduct.MaxSaleAmount
FROM Products P
JOIN (
    SELECT 
        ProductID,
        MAX(SalesAmount) AS MaxSaleAmount
    FROM Sales
    GROUP BY ProductID
) AS MaxSalesPerProduct
    ON P.ProductID = MaxSalesPerProduct.ProductID;

WITH Doubled AS (
    SELECT 1 AS Value
    UNION ALL
    SELECT Value * 2
    FROM Doubled
    WHERE Value * 2 < 1000000
)
SELECT * FROM Doubled
OPTION (MAXRECURSION 100);

WITH SalesCount AS (
    SELECT 
        EmployeeID,
        COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
)
SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    SC.SaleCount
FROM SalesCount SC
JOIN Employees E ON E.EmployeeID = SC.EmployeeID
WHERE SC.SaleCount > 5;


WITH HighSales AS (
    SELECT 
        ProductID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
    HAVING SUM(SalesAmount) > 500
)
SELECT 
    P.ProductID,
    P.ProductName,
    HS.TotalSales
FROM HighSales HS
JOIN Products P ON HS.ProductID = P.ProductID;



WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    E.Salary
FROM Employees E
CROSS JOIN AvgSalaryCTE A
WHERE E.Salary > A.AvgSalary;



SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    OrderCounts.OrderCount
FROM (
    SELECT 
        EmployeeID,
        COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) AS OrderCounts
JOIN Employees E ON E.EmployeeID = OrderCounts.EmployeeID
ORDER BY OrderCounts.OrderCount DESC
FETCH FIRST 5 ROWS ONLY;



SELECT 
    P.CategoryID,
    SUM(SalesPerProduct.SalesAmount) AS TotalCategorySales
FROM (
    SELECT 
        ProductID,
        SalesAmount
    FROM Sales
) AS SalesPerProduct
JOIN Products P ON P.ProductID = SalesPerProduct.ProductID
GROUP BY P.CategoryID;



WITH FactorialCTE AS (
    SELECT 
        Number,
        1 AS Factorial,
        Number AS Current
    FROM Numbers1
    WHERE Number >= 0

    UNION ALL

    SELECT 
        f.Number,
        f.Factorial * f.Current AS Factorial,
        f.Current - 1
    FROM FactorialCTE f
    WHERE f.Current > 1
)
SELECT 
    Number,
    MAX(Factorial) AS FactorialResult
FROM FactorialCTE
GROUP BY Number
ORDER BY Number;


WITH RecursiveSplit AS (
    SELECT 
        Id,
        CAST(SUBSTRING(String, 1, 1) AS VARCHAR(1)) AS Character,
        1 AS Position,
        LEN(String) AS StringLength,
        String
    FROM Example

    UNION ALL

    SELECT 
        Id,
        CAST(SUBSTRING(String, Position + 1, 1) AS VARCHAR(1)),
        Position + 1,
        StringLength,
        String
    FROM RecursiveSplit
    WHERE Position < StringLength
)
SELECT Id, Character, Position
FROM RecursiveSplit
ORDER BY Id, Position;


WITH RecursiveSplit AS (
    SELECT 
        Id,
        CAST(SUBSTRING(String, 1, 1) AS VARCHAR(1)) AS Character,
        1 AS Position,
        LEN(String) AS StringLength,
        String
    FROM Example

    UNION ALL

    SELECT 
        Id,
        CAST(SUBSTRING(String, Position + 1, 1) AS VARCHAR(1)),
        Position + 1,
        StringLength,
        String
    FROM RecursiveSplit
    WHERE Position < StringLength
)
SELECT Id, Character, Position
FROM RecursiveSplit
ORDER BY Id, Position;



WITH MonthlySales AS (
    SELECT
        YEAR(SaleDate) AS SaleYear,
        MONTH(SaleDate) AS SaleMonth,
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate), EmployeeID
),
SalesDiff AS (
    SELECT
        curr.SaleYear,
        curr.SaleMonth,
        curr.EmployeeID,
        curr.TotalSales AS CurrentMonthSales,
        prev.TotalSales AS PreviousMonthSales,
        (curr.TotalSales - ISNULL(prev.TotalSales, 0)) AS SalesDifference
    FROM MonthlySales curr
    LEFT JOIN MonthlySales prev
      ON curr.EmployeeID = prev.EmployeeID
      AND (
        (curr.SaleYear = prev.SaleYear AND curr.SaleMonth = prev.SaleMonth + 1)
        OR (curr.SaleYear = prev.SaleYear + 1 AND curr.SaleMonth = 1 AND prev.SaleMonth = 12)
      )
)
SELECT *
FROM SalesDiff
ORDER BY EmployeeID, SaleYear, SaleMonth;




SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    QuarterlySales.Quarter,
    QuarterlySales.Year,
    QuarterlySales.TotalSales
FROM (
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        YEAR(SaleDate) AS Year,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate), YEAR(SaleDate)
    HAVING SUM(SalesAmount) > 45000
) AS QuarterlySales
JOIN Employees E ON E.EmployeeID = QuarterlySales.EmployeeID
ORDER BY E.EmployeeID, QuarterlySales.Year, QuarterlySales.Quarter;


WITH Fibonacci AS (
    SELECT 1 AS Position, 0 AS Value
    UNION ALL
    SELECT 2, 1
    UNION ALL
    SELECT Position + 1, 
           (SELECT Value FROM Fibonacci f1 WHERE f1.Position = Fibonacci.Position) 
           + Fibonacci.Value
    FROM Fibonacci
    WHERE Position < 20
)
SELECT Position, Value
FROM Fibonacci
ORDER BY Position;



SELECT *
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND Vals IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM STRING_SPLIT(Vals, '')
      WHERE value <> LEFT(Vals, 1)
  );



DECLARE @n INT = 5;

WITH NumbersCTE AS (
    SELECT 1 AS Num, CAST('1' AS VARCHAR(100)) AS Sequence
    UNION ALL
    SELECT Num + 1, Sequence + CAST(Num + 1 AS VARCHAR(10))
    FROM NumbersCTE
    WHERE Num + 1 <= @n
)
SELECT Sequence
FROM NumbersCTE
OPTION (MAXRECURSION 1000);




WITH Last6MonthsSales AS (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
),
MaxSales AS (
    SELECT MAX(TotalSales) AS MaxTotal
    FROM Last6MonthsSales
)
SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    S.TotalSales
FROM Last6MonthsSales S
JOIN MaxSales M ON S.TotalSales = M.MaxTotal
JOIN Employees E ON E.EmployeeID = S.EmployeeID;

