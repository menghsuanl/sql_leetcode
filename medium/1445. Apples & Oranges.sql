/* create a new col. and set orange num as negative, sum up by date */
SELECT
sale_date,
SUM(new_num) AS diff
FROM
(
    SELECT 
    sale_date,
    fruit,
    sold_num,
    IFNULL((CASE WHEN fruit = 'apples' then sold_num ELSE -1*(sold_num) END),0) AS new_num
    FROM Sales
)sub
GROUP BY 1

/* no subquery, combine sum and case when */
select sale_date, sum(case when fruit='apples' then sold_num else -sold_num end) as diff
from sales
group by sale_date
