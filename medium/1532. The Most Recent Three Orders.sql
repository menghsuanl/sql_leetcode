-- use rank window to find the latest orders
SELECT
c.name AS customer_name,
sub.customer_id,
sub.order_id,
sub.order_date
FROM Customers c
INNER JOIN
(
    SELECT
    customer_id,
    order_id,
    order_date,
    RANK() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rnk
    FROM Orders
)sub
ON c.customer_id = sub.customer_id
WHERE sub.rnk <= 3
ORDER BY c.name, sub.customer_id, sub.order_date DESC
