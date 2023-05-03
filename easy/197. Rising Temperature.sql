-- !must use datediff to compared two dates. using a.date+1 = b.date will trigger error when crossing one year
-- use self join to find the previous date temp
-- compare two temp
SELECT
a.id
FROM Weather a
JOIN Weather b
WHERE a.temperature > b.temperature
AND DATEDIFF(a.recordDate, b.recordDate) = 1
