/* group and island */
with temp0 AS
(SELECT  id,
            login_date,
            dense_rank() OVER(PARTITION BY id ORDER BY login_date) as row_num
    FROM Logins),

temp1 as (
    select id, login_date, row_num,
        DATE_ADD(login_date, INTERVAL -row_num DAY) as Groupings
    from temp0),

answer_table as (SELECT  id,
         MIN(login_date) as startDate,
         MAX(login_date) as EndDate,
         row_num,
         Groupings, 
         count(id),
        datediff(MAX(login_date), MIN(login_date)) as duration
 FROM temp1
 GROUP BY id, Groupings
 HAVING datediff(MAX(login_date), MIN(login_date)) >= 4
 ORDER BY id, StartDate)
 
select distinct a.id, name
from answer_table a
join Accounts acc on acc.id = a.id
order by a.id


/* use diff-rnk as a group to group up consecutive rows */
WITH
tmp AS(
SELECT a.id, a.name, b.login_date,
DENSE_RANK() OVER(PARTITION BY a.id ORDER BY b.login_date) AS rnk, 
DATEDIFF(b.login_date, '2020-01-01') AS diff -- use 2020-01-01 as anchor
FROM Accounts AS a
LEFT JOIN (
SELECT DISTINCT id, login_date FROM Logins
) AS b
ON a.id = b.id
)

SELECT DISTINCT id, name FROM tmp
GROUP BY id, name, diff-rnk
HAVING COUNT(login_date) >= 5;
