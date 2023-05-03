-- find first login date of each user
-- filter date within 90 days of 2019-06-30.
-- group by date

SELECT
login_date,
COUNT(user_id) AS user_count
FROM
(
    SELECT
    user_id,
    -- RANK()OVER (PARTITION BY user_id ORDER BY activity_date) AS rnk
    min(activity_date) as login_date
    FROM Traffic
    WHERE activity = 'login'
    GROUP BY 1
)sub
WHERE DATEDIFF('2019-06-30',sub.login_date) <= 90 
GROUP BY 1
ORDER BY login_date
