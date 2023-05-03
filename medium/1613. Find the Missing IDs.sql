-- create a number series with recursive cte
-- compare to cust tbl
WITH RECURSIVE cte AS
(
    SELECT
    1 AS ids
    UNION ALL
    SELECT
    ids+1 AS ids
    FROM cte
    WHERE ids < (SELECT MAX(customer_id) FROM Customers)
)
SELECT 
ids
FROM cte
LEFT JOIN Customers 
ON cte.ids = Customers.customer_id
WHERE Customers.customer_id IS NULL 
