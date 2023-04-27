ITH cte AS(
SELECT
id,
visit_date,
people,
DENSE_RANK() OVER (ORDER BY id) AS rnk
FROM
(
  SELECT 
  id,
  visit_date,
  people
  FROM Stadium
  WHERE people >= 100
)sub
)

SELECT
id,
visit_date,
people
FROM cte
WHERE
(id-rnk) IN
(
  SELECT 
  (id-rnk)
  FROM cte
  GROUP BY (id-rnk)
  HAVING COUNT(*) >= 3
)
ORDER BY visit_date

/* same sol but even more concise */
with t as ( select t1.id , t1.visit_date , t1.people , 
            id - row_number() OVER(ORDER BY id) as grp
       from stadium t1
       where people >= 100 
          )
select t.id, t.visit_date ,t.people
from t 
where grp in ( select grp from t group by grp having count(*) >=3  )
