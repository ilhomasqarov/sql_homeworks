
WITH Regions AS (
  SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
  SELECT DISTINCT Distributor FROM #RegionSales
),
RegionDistributor AS (
  SELECT r.Region, d.Distributor
  FROM Regions r CROSS JOIN Distributors d
)
SELECT 
  rd.Region,
  rd.Distributor,
  ISNULL(rs.Sales, 0) AS Sales
FROM RegionDistributor rd
LEFT JOIN #RegionSales rs
  ON rd.Region = rs.Region AND rd.Distributor = rs.Distributor
ORDER BY rd.Region, rd.Distributor;


SELECT e.name
FROM Employee e
JOIN (
  SELECT managerId, COUNT(*) AS DirectReports
  FROM Employee
  WHERE managerId IS NOT NULL
  GROUP BY managerId
  HAVING COUNT(*) >= 5
) mgr ON e.id = mgr.managerId;


SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;


WITH VendorOrders AS (
  SELECT
    CustomerID,
    Vendor,
    SUM([Count]) AS TotalOrders,
    ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SUM([Count]) DESC) AS rn
  FROM Orders
  GROUP BY CustomerID, Vendor
)
SELECT CustomerID, Vendor
FROM VendorOrders
WHERE rn = 1;





WITH LocationCount AS (
  SELECT
    Device_id,
    Locations,
    COUNT(*) AS Signals
  FROM Device
  GROUP BY Device_id, Locations
),
MaxLocation AS (
  SELECT
    Device_id,
    Locations AS max_signal_location,
    Signals,
    ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY Signals DESC) AS rn
  FROM LocationCount
),
TotalSignals AS (
  SELECT
    Device_id,
    COUNT(DISTINCT Locations) AS no_of_location,
    SUM(Signals) AS no_of_signals
  FROM LocationCount
  GROUP BY Device_id
)
SELECT
  t.Device_id,
  t.no_of_location,
  m.max_signal_location,
  t.no_of_signals
FROM TotalSignals t
JOIN MaxLocation m ON t.Device_id = m.Device_id AND m.rn = 1;


SELECT EmpID, EmpName, Salary
FROM Employee e
WHERE Salary > (
  SELECT AVG(Salary) FROM Employee WHERE DeptID = e.DeptID
);


WITH WinningCount AS (
  SELECT TicketID, COUNT(DISTINCT Number) AS MatchedCount
  FROM Tickets t
  JOIN WinningNumbers w ON t.Number = w.Number
  GROUP BY TicketID
),
WinningNumbersCount AS (
  SELECT COUNT(*) AS TotalWinning FROM WinningNumbers
)
SELECT 
  SUM(CASE
    WHEN wc.MatchedCount = wnc.TotalWinning THEN 100
    WHEN wc.MatchedCount > 0 THEN 10
    ELSE 0
  END) AS TotalWinnings
FROM WinningCount wc, WinningNumbersCount wnc;



WITH Numbers AS (
  SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
  UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
ORDER BY g.Product;
