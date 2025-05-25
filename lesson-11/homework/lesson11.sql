SELECT 
    o.OrderID, 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '2022-12-31';

SELECT 
    e.Name AS EmployeeName, 
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');

SELECT 
    d.DepartmentName, 
    MAX(e.Salary) AS MaxSalary
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND o.OrderDate BETWEEN '2023-01-01' AND '2023-12-31';

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, CustomerName;

SELECT 
    p.ProductName, 
    s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');


SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, CustomerName;


SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;

SELECT 
    p.ProductName,
    s.SaleDate,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;


SELECT 
    p.ProductName,
    SUM(s.SaleAmount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;


SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources' AND e.Salary > 60000;


SELECT 
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 100;



SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR e.HireDate > '2020-12-31';



SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(o.TotalAmount) AS TotalPurchase
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2023
GROUP BY c.CustomerID, CustomerName
ORDER BY TotalPurchase DESC
LIMIT 3;


SELECT 
    p.ProductName,
    cat.CategoryName,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE s.SaleAmount > (
    SELECT AVG(s2.SaleAmount)
    FROM Sales s2
    JOIN Products p2 ON s2.ProductID = p2.ProductID
    WHERE p2.CategoryID = p.CategoryID
);
