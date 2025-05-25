SELECT 
    Id,
    LTRIM(RTRIM(PARSENAME(REPLACE(Name, ',', '.'), 2))) AS Name,
    LTRIM(RTRIM(PARSENAME(REPLACE(Name, ',', '.'), 1))) AS Surname
FROM TestMultipleColumns;


SELECT *
FROM TestPercent
WHERE Strs LIKE '%[%]%';

SELECT 
    Id,
    PARSENAME(REPLACE(Vals, '.', '.'), 3) AS Part1,
    PARSENAME(REPLACE(Vals, '.', '.'), 2) AS Part2,
    PARSENAME(REPLACE(Vals, '.', '.'), 1) AS Part3
FROM Splitter;

DECLARE @input VARCHAR(100) = '1234ABC123456XYZ1234567890ADS';

SELECT 
    @input AS Original,
    TRANSLATE(@input, '0123456789', REPLICATE('X', 10)) AS Masked;


SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;


SELECT 
    texts,
    LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

SELECT e.Name
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;



SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Hire_Date,
    DATEDIFF(YEAR, Hire_Date, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, Hire_Date, GETDATE()) BETWEEN 10 AND 14;

DECLARE @str VARCHAR(100) = 'rtcfvty34redt';

SELECT 
    @str AS Original,
    -- Remove all digits to get characters only
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        @str, '0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9','') AS CharactersOnly,
    -- Remove all characters to get digits only
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        @str, 'a',''),'b',''),'c',''),'d',''),'e',''),'f',''),'g',''),'h',''),'i',''),'j','') AS DigitsOnly;


SELECT w1.Id, w1.RecordDate, w1.Temperature
FROM weather w1
JOIN weather w2 
    ON DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;


SELECT 
    player_id, 
    MIN(event_date) AS FirstLogin
FROM Activity
GROUP BY player_id;

SELECT 
    PARSENAME(REPLACE(fruit_list, ',', '.'), 1) AS Fourth,
    PARSENAME(REPLACE(fruit_list, ',', '.'), 2) AS Third
FROM fruits;



WITH Letters AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Letters WHERE n < LEN('sdgfhsdgfhs@121313131')
)
SELECT 
    n AS Position,
    SUBSTRING('sdgfhsdgfhs@121313131', n, 1) AS Character
FROM Letters
OPTION (MAXRECURSION 100);


SELECT 
    p1.id,
    CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;



SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Hire_Date,
    DATEDIFF(YEAR, Hire_Date, GETDATE()) AS YearsWorked,
    CASE 
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) BETWEEN 11 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;



SELECT 
    Id,
    Vals,
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS StartingInteger
FROM GetIntegers
WHERE Vals LIKE '[0-9]%';


WITH SplitVals AS (
    SELECT 
        Id,
        Vals,
        CAST('<x>' + RE

SELECT 
    Id,
    CONCAT(SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, CHARINDEX(',', Vals + ',', CHARINDEX(',', Vals) + 1) - CHARINDEX(',', Vals) - 1),
           ',',
           LEFT(Vals, CHARINDEX(',', Vals) - 1),
           ',',
           PARSENAME(REPLACE(Vals, ',', '.'), 1)) AS Swapped
FROM MultipleVals;


  
WITH FirstLogins AS (
    SELECT 
        player_id,
        device_id,
        event_date,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn
    FROM Activity
)
SELECT player_id, device_id
FROM FirstLogins
WHERE rn = 1;
