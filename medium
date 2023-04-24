#1613
-- use recursive CTE to list all consecutive num till the max
WITH RECURSIVE id_seq AS (
SELECT 1 as continued_id
UNION 
SELECT continued_id + 1
FROM id_seq
WHERE continued_id < (SELECT MAX(customer_id) FROM Customers) 
)

-- use NOT IN to find out the missing nums
SELECT continued_id AS ids
FROM id_seq
WHERE continued_id NOT IN (SELECT customer_id FROM Customers)
ORDER BY ids; 
