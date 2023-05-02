-- if id = max(count) and it is odd. no change
-- if id is odd then id+1, else id-1
SELECT
(CASE WHEN id = (SELECT MAX(id) FROM Seat) AND MOD(id,2) = 1 THEN id
WHEN MOD(id,2)=1 THEN id+1 ELSE id-1 END) AS id,
student
FROM Seat
ORDER BY (CASE WHEN (id = (SELECT MAX(id) FROM Seat)) AND (MOD(id,2) = 1 )THEN id
WHEN MOD(id,2)=1 THEN id+1 ELSE id-1 END)
