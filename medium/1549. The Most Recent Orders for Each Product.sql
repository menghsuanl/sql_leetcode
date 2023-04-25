WITH cte AS (
    SELECT
    product_id,
    MAX(order_date) AS order_date
    FROM Orders
    GROUP BY product_id
)

SELECT
p.product_name,
c.product_id,
o.order_id,
c.order_date
FROM cte c
LEFT JOIN Orders o
ON c.product_id = o.product_id AND c.order_date = o.order_date
LEFT JOIN Products p
ON c.product_id = p.product_id
ORDER BY p.product_name, c.product_id, o.order_id

/* filter 2 columns in where */
select b.product_name, a.product_id, a.order_id, a.order_date from Orders a
join Products b
on a.product_id = b.product_id
where (a.product_id, a.order_date) in (
select product_id, max(order_date) as order_date
from Orders
group by product_id)
order by b.product_name, a.product_id, a.order_id

/* rank() over */
SELECT product_name, product_id, order_id, order_date
FROM (
    SELECT product_name, P.product_id, order_id, order_date, RANK() OVER (PARTITION BY product_name ORDER BY order_date DESC) rnk
    FROM Orders O
    JOIN Products P
    On O.product_id = P.product_id
) temp
WHERE rnk = 1
ORDER BY product_name, product_id, order_id
