-- add a separate col for today to calculate window
-- calculate window with existing dates
-- compare today vs existing
SELECT
user_id,
MAX(win) AS biggest_window
FROM
(
  SELECT
  user_id,
  DATEDIFF('2021-01-01', lastd) AS win
  FROM(
  SELECT
  user_id,
  MAX(visit_date) as lastd
  FROM UserVisits
  GROUP BY user_id
  )last_w

  UNION ALL

  SELECT
  user_id,
  DATEDIFF(visit_date, LAG(visit_date,1) OVER(PARTITION BY user_id ORDER BY visit_date)) AS win
  FROM  UserVisits
)sub
GROUP BY 1

/* concise sol */
SELECT user_id, MAX(diff) AS biggest_window
FROM
(
SELECT user_id,
DATEDIFF(LEAD(visit_date, 1, '2021-01-01') OVER (PARTITION BY user_id ORDER BY visit_date), visit_date) AS diff
	FROM userVisits
) a
GROUP BY user_id
ORDER BY user_id
Many People would face the Issue of explanation so let us dive into it:
/*
LEAD Function:
i].The Syntax for Lead function is LEAD<column_name,context,default_value>. It Means that where you want to check the next row in a column, and after how many rows you would like to check (Context), and the default value if there is no date present after the last date (2021-01-01).
ii]. PARTITION BY: It helps to segregate result based on the USERS you want and ORDER BY re-orders the results in Ascending Order for each 
USER_ID that has been partitioned (OR GROUPED). WE USE PARTITION IN LEAD FUNCTION.
*/
