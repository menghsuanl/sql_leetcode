-- find spam id and date
-- check if it is removed
-- avg the ration
WITH cte AS (
SELECT
DISTINCT a.action_date, -- must have distinct coz there are duplicate post_id
a.post_id,
(CASE WHEN r.remove_date IS NOT NULL THEN 1 ELSE 0 END) AS rmv_flg
FROM Actions a
LEFT JOIN Removals r
ON a.post_id = r.post_id
WHERE a.extra = 'spam'
)
SELECT
ROUND(AVG(day_rate)*100,2) AS average_daily_percent
FROM(
SELECT
action_date,
SUM(rmv_flg)/COUNT(*) AS day_rate
FROM cte
GROUP BY 1
)sub
