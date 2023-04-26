-- find points that do not share either x-axis or y axis

SELECT
a.id AS P1,
b.id AS P2,
abs(a.x_value - b.x_value) * abs(a.y_value - b.y_value) AS area
FROM Points a JOIN Points b
WHERE a.x_value <> b.x_value AND a.y_value <> b.y_value 
AND -- remove duplicate rows
a.id < b.id
ORDER BY abs(a.x_value - b.x_value) * abs(a.y_value - b.y_value) DESC, a.id, b.id
