-- map numbers to left and right in expression tbl
-- compare the two in the expression tbl
WITH cte AS (
SELECT
e.*,
v.value AS l_val,
v2.value AS r_val
FROM Expressions e
LEFT JOIN Variables v
ON e.left_operand = v.name
LEFT JOIN Variables v2
ON e.right_operand = v2.name
)

SELECT
left_operand,
operator,
right_operand,
(CASE WHEN l_val > r_val AND operator = '>' THEN 'true'
WHEN l_val > r_val AND operator != '>' THEN 'false'
WHEN l_val < r_val AND operator = '<' THEN 'true'
WHEN l_val < r_val AND operator != '<' THEN 'false'
WHEN l_val = r_val AND operator = '=' THEN 'true'
WHEN l_val = r_val AND operator != '=' THEN 'false' END) AS value
FROM cte

/* judge true condition, and the else will be false*/
SELECT a.left_operand, a.operator, a.right_operand, 
CASE WHEN b.value > c.value AND a.operator = '>' THEN 'true'
WHEN b.value = c.value AND a.operator = '=' THEN 'true'
WHEN b.value < c.value AND a.operator = '<' THEN 'true'
ELSE 'false' END AS value
FROM Expressions AS a
LEFT JOIN Variables AS b ON a.left_operand = b.name
LEFT JOIN Variables AS c ON a.right_operand = c.name;
