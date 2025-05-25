
UPDATE Employees
SET phone_number = REPLACE(phone_number, '124', '999')
WHERE phone_number LIKE '%124%';

SELECT 
    first_name AS FirstName,
    LEN(first_name) AS NameLength
FROM Employees
WHERE first_name LIKE 'A%' 
   OR first_name LIKE 'J%' 
   OR first_name LIKE 'M%'
ORDER BY first_name;


SELECT ManagerID, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY ManagerID;


SELECT 
    Year1,
    GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;


SELECT *
FROM cinema
WHERE id % 2 = 1
  AND LOWER(description) <> 'boring';


SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;

SELECT 
    id,
    COALESCE(ssn, passportid, itin) AS FirstNonNullValue
FROM person;

SELECT
  StudentID,
  SUBSTRING_INDEX(FullName, ' ', 1) AS Firstname,
  SUBSTRING_INDEX(SUBSTRING_INDEX(FullName, ' ', 2), ' ', -1) AS Middlename,
  SUBSTRING_INDEX(FullName, ' ', -1) AS Lastname
FROM Students;


SELECT o.*
FROM Orders o
WHERE o.DeliveryState = 'TX'
  AND o.CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
    WHERE DeliveryState = 'CA'
  );


SELECT GROUP_CONCAT(String ORDER BY SequenceNumber SEPARATOR ' ') AS ConcatenatedString
FROM DMLTable;


SELECT *
FROM Employees
WHERE (
  LENGTH(CONCAT(first_name, last_name)) 
  - LENGTH(REPLACE(LOWER(CONCAT(first_name, last_name)), 'a', ''))
) >= 3;

SELECT
  department_id,
  COUNT(*) AS TotalEmployees,
  ROUND(
    100.0 * SUM(CASE WHEN DATEDIFF(year, hire_date, GETDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS PercentageMoreThan3Years
FROM Employees
GROUP BY department_id;


SELECT
  JobDescription,
  MAX(MissionCount) AS MaxExperience,
  MIN(MissionCount) AS MinExperience
FROM Personal
GROUP BY JobDescription;


WITH chars AS (
    SELECT SUBSTRING(val, n, 1) AS ch
    FROM (SELECT 'tf56sd#%OqH' AS val) t
    CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) numbers
)
SELECT
  STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch ELSE '' END, '') AS UppercaseLetters,
  STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch ELSE '' END, '') AS LowercaseLetters,
  STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch ELSE '' END, '') AS Numbers,
  STRING_AGG(CASE WHEN ch NOT LIKE '[A-Za-z0-9]' THEN ch ELSE '' END, '') AS OtherCharacters
FROM chars;


SELECT
  StudentID,
  FullName,
  Grade,
  SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Students
ORDER BY StudentID;

