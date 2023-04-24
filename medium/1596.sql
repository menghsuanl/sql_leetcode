/*-- use window func to find the cnt of each prd each cust
SELECT
DISTINCT customer_id,
product_id,
COUNT(*)OVER (PARTITION BY customer_id, product_id) AS cnt
FROM Orders
ORDER BY customer_id, product_id
*/
-- use groupby to find cnt per cust per product
-- find the max count of product
-- left join the prod name
SELECT
sub3.customer_id,
sub3.product_id,
p.product_name
FROM
(
  SELECT
  customer_id,
  product_id
  FROM (
    SELECT 
    customer_id,
    product_id,
    RANK() OVER (PARTITION BY customer_id ORDER BY cnt DESC) AS rnk
    FROM 
    (
      SELECT
      customer_id,
      product_id,
      COUNT(*) AS cnt
      FROM Orders
      GROUP BY 1,2
    )sub
  )sub2
  WHERE rnk = 1
)sub3
LEFT JOIN Products p
ON sub3.product_id = p.product_id
ORDER BY 1,2
