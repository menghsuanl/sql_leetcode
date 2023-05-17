-- left join the check cnt to another column
-- sum up
-- MUST HAVE COALESCE: It will skip the entire row if the value is null and won't get added
SELECT
SUM(apple_count+c_a) AS apple_count,
SUM(orange_count+c_o) AS orange_count
FROM(
SELECT
b.box_id,
b.apple_count,
b.orange_count,
COALESCE(c.apple_count,0) AS c_a,
COALESCE(c.orange_count,0) AS c_o
FROM Boxes b
LEFT JOIN Chests C
ON b.chest_id = c.chest_id
)sub
