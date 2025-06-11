CREATE PROCEDURE GetEmployeeBonus
AS
BEGIN

    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10, 2),
        BonusAmount DECIMAL(10, 2)
    );

 
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * d.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus d ON e.Department = d.Department;

   CREATE PROCEDURE UpdateEmployeeSalary
    @Department NVARCHAR(50),
    @IncreasePercentage DECIMAL(5, 2)
AS
BEGIN
    UPDATE e
    SET e.Salary = e.Salary * (1 + @IncreasePercentage / 100)
    FROM Employees e
    WHERE e.Department = @Department;


    SELECT * FROM Employees WHERE Department = @Department;
END;


MERGE INTO Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

SELECT 
    t.id,
    CASE 
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN NOT EXISTS (SELECT 1 FROM Tree WHERE p_id = t.id) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree t;


SELECT 
    s.user_id,
    COALESCE(COUNT(c.action) * 1.0 / COUNT(s.user_id), 0) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id AND c.action = 'confirmed'
GROUP BY s.user_id

SELECT * 
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);


CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        COALESCE(SUM(s.Quantity), 0) AS TotalQuantitySold,
        COALESCE(SUM(s.Quantity * p.Price), 0) AS TotalSalesAmount,
        COALESCE(MIN(s.SaleDate), NULL) AS FirstSaleDate,
        COALESCE(MAX(s.SaleDate), NULL) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID AND p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;




  
