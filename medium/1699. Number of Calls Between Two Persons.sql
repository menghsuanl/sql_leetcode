-- make the p1>p2 into p2>p1
-- count ttl
WITH cte AS(
SELECT
to_id as person1,
from_id as person2,
duration
FROM Calls
where from_id > to_id
UNION ALL
SELECT
from_id as person1,
to_id as person2,
duration
FROM Calls
where from_id < to_id
)

SELECT
person1,
person2,
COUNT(*) AS call_count,
SUM(duration) AS total_duration
FROM cte
GROUP BY 1,2
