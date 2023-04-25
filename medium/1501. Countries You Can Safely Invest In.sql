-- map every call to countries: use union all to double count caller and callee
-- find country avg
-- compare to global avg
SELECT
co.name AS country
FROM Country co
INNER JOIN
(
  SELECT
  sub.country_code
  FROM
  (
    SELECT
    ca.caller_id,
    ca.duration,
    LEFT(p.phone_number,3) AS country_code
    FROM Calls ca
    LEFT JOIN Person p
    ON ca.caller_id = p.id
    UNION ALL 
    SELECT
    ca.callee_id,
    ca.duration,
    LEFT(p.phone_number,3) AS country_code
    FROM Calls ca
    LEFT JOIN Person p
    ON ca.callee_id = p.id
  )sub
  GROUP BY sub.country_code
  HAVING AVG(sub.duration) > (SELECT AVG(duration) FROM Calls)
) sub2
ON co.country_code = sub2.country_code

/* using the second join with calls when p.id is in (c.caller_id, c.callee_id)
This explodes each row of calls into two rows, one for caller, and the other for callee. 
p.id IN (c.caller_id, c.callee_id) is equal to calls.caller_id = person.id OR calls.callee_id = person.id */

SELECT
 co.name AS country
FROM
 person p
 JOIN
     country co
     ON SUBSTRING(phone_number,1,3) = country_code
 JOIN
     calls c
     ON p.id IN (c.caller_id, c.callee_id)
GROUP BY
 co.name
HAVING
 AVG(duration) > (SELECT AVG(duration) FROM calls)
