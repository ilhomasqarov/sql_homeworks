SELECT 
    sale_id,
    customer_id,
    customer_name,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total_sales
FROM sales_data;




SELECT 
    product_category,
    COUNT(*) AS number_of_orders
FROM sales_data
GROUP BY product_category;



SELECT 
    product_category,
    MAX(total_amount) AS max_total_amount
FROM sales_data
GROUP BY product_category;


SELECT 
    product_category,
    MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;


SELECT 
    sale_id,
    order_date,
    total_amount,
    AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_sales
FROM sales_data;


SELECT 
    region,
    SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;

SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS total_purchase,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank
FROM sales_data
GROUP BY customer_id, customer_name;



SELECT 
    sale_id,
    customer_id,
    total_amount,
    total_amount - LAG(total_amount, 1) OVER (PARTITION BY customer_id ORDER BY order_date) AS diff_from_previous_sale
FROM sales_data;


WITH RankedProducts AS (
    SELECT 
        product_category,
        product_name,
        unit_price,
        RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS product_rank
    FROM sales_data
)
SELECT 
    product_category,
    product_name,
    unit_price
FROM RankedProducts
WHERE product_rank <= 3;



SELECT 
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data;


SELECT 
    product_category,
    order_date,
    SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS cumulative_revenue
FROM sales_data;


CREATE TABLE OneColumn (
    Value SMALLINT
);

INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

SELECT 
    Value,
    SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS SumPreValues
FROM OneColumn;


WITH RowNums AS (
    SELECT 
        Id,
        Vals,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS RowNumber
    FROM Row_Nums
)
SELECT 
    Id,
    Vals,
    CASE 
        WHEN RowNumber = 1 THEN RowNumber
        ELSE RowNumber * 2 - 1
    END AS RowNumber
FROM RowNums;


SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;

WITH RegionalAvg AS (
    SELECT 
        region,
        AVG(total_amount) AS avg_spending
    FROM sales_data
    GROUP BY region
)
SELECT 
    s.customer_id,
    s.customer_name,
    s.total_amount,
    s.region
FROM sales_data s
JOIN RegionalAvg r ON s.region = r.region
WHERE s.total_amount > r.avg_spending;


SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spending,
    RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS rank
FROM sales_data
GROUP BY customer_id, customer_name, region;


SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total_sales
FROM sales_data;


WITH LastOrder AS (
    SELECT 
        customer_id,
        MAX(order_date) AS last_order_date,
        SUM(total_amount) AS last_total_amount
    FROM sales_data
    GROUP BY customer_id
)
SELECT 
    s.customer_id,
    s.total_amount
FROM sales_data s
JOIN LastOrder l ON s.customer_id = l.customer_id
WHERE s.total_amount > l.last_total_amount;


SELECT 
    product_name,
    unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);

SELECT 
    ID, 
    SUM(Cost) AS Total_Cost, 
    SUM(Quantity) AS Total_Quantity
FROM TheSumPuzzle
GROUP BY ID;

