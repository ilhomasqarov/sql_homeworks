SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;


SELECT 
    ProductName,
    SUM(Quantity) AS TotalQuantity,
    RANK() OVER (ORDER BY SUM(Quantity) DESC) AS Rank
FROM ProductSales
GROUP BY ProductName;


SELECT 
    CustomerID,
    ProductName,
    SaleAmount
FROM (
    SELECT 
        CustomerID,
        ProductName,
        SaleAmount,
        RANK() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS SaleRank
    FROM ProductSales
) AS RankedSales
WHERE SaleRank = 1;

SELECT 
    A.SaleID,
    A.SaleAmount AS CurrentSaleAmount,
    B.SaleAmount AS NextSaleAmount
FROM ProductSales A
LEFT JOIN ProductSales B ON A.SaleDate < B.SaleDate
WHERE NOT EXISTS (
    SELECT 1
    FROM ProductSales C
    WHERE C.SaleDate > A.SaleDate AND C.SaleDate < B.SaleDate
)
ORDER BY A.SaleDate;



SELECT 
    A.SaleID,
    A.SaleAmount AS CurrentSaleAmount,
    B.SaleAmount AS PreviousSaleAmount
FROM ProductSales A
LEFT JOIN ProductSales B ON A.SaleDate > B.SaleDate
WHERE NOT EXISTS (
    SELECT 1
    FROM ProductSales C
    WHERE C.SaleDate < A.SaleDate AND C.SaleDate > B.SaleDate
)
ORDER BY A.SaleDate;

SELECT 
    A.SaleID,
    A.SaleAmount,
    B.SaleAmount AS PreviousSaleAmount
FROM ProductSales A
JOIN ProductSales B ON A.SaleDate > B.SaleDate
WHERE A.SaleAmount > B.SaleAmount
ORDER BY A.SaleDate;


SELECT 
    A.SaleID,
    A.ProductName,
    A.SaleAmount,
    A.SaleAmount - COALESCE(B.SaleAmount, 0) AS AmountDifference
FROM ProductSales A
LEFT JOIN ProductSales B ON A.ProductName = B.ProductName AND A.SaleDate > B.SaleDate
ORDER BY A.SaleDate;


SELECT 
    A.SaleID,
    A.SaleAmount AS CurrentSaleAmount,
    B.SaleAmount AS NextSaleAmount,
    (B.SaleAmount - A.SaleAmount) / A.SaleAmount * 100 AS PercentageChange
FROM ProductSales A
JOIN ProductSales B ON A.SaleDate < B.SaleDate
ORDER BY A.SaleDate;


SELECT 
    A.SaleID,
    A.ProductName,
    A.SaleAmount,
    A.SaleAmount / COALESCE(B.SaleAmount, 1) AS AmountRatio
FROM ProductSales A
LEFT JOIN ProductSales B ON A.ProductName = B.ProductName AND A.SaleDate > B.SaleDate
ORDER BY A.SaleDate;


SELECT 
    A.SaleID,
    A.ProductName,
    A.SaleAmount,
    A.SaleAmount - (SELECT TOP 1 SaleAmount FROM ProductSales WHERE ProductName = A.ProductName ORDER BY SaleDate ASC) AS AmountDifferenceFromFirstSale
FROM ProductSales A
ORDER BY A.SaleDate;


SELECT 
    A.ProductName,
    A.SaleID,
    A.SaleAmount
FROM ProductSales A
WHERE NOT EXISTS (
    SELECT 1
    FROM ProductSales B
    WHERE B.ProductName = A.ProductName
    AND B.SaleDate < A.SaleDate
    AND B.SaleAmount >= A.SaleAmount
)
ORDER BY A.SaleDate;


SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SUM(SaleAmount) OVER (ORDER BY SaleDate) AS ClosingBalance
FROM ProductSales;


SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAverage
FROM ProductSales;


SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SaleAmount - (SELECT AVG(SaleAmount) FROM ProductSales) AS DifferenceFromAverage
FROM ProductSales;

SELECT 
    E1.Name,
    E1.Salary,
    RANK() OVER (ORDER BY E1.Salary DESC) AS Rank
FROM Employees1 E1
JOIN (
    SELECT 
        Salary,
        RANK() OVER (ORDER BY Salary DESC) AS Rank
    FROM Employees1
) AS Ranks ON E1.Salary = Ranks.Salary
ORDER BY Rank;


SELECT 
    Department,
    Name,
    Salary
FROM (
    SELECT 
        Department,
        Name,
        Salary,
        RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptRank
    FROM Employees1
) AS RankedSalaries
WHERE DeptRank <= 2;

SELECT 
    Department,
    Name,
    Salary
FROM (
    SELECT 
        Department,
        Name,
        Salary,
        RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS DeptRank
    FROM Employees1
) AS RankedSalaries
WHERE DeptRank = 1;

SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotalSalary
FROM Employees1;
