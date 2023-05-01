-- numerator: find first login date of each player
-- use lead() window func. to find their next login
-- use datediff to see if it is 1
-- denominator: distinct cnt of players
WITH nu AS (
SELECT
    COUNT(player_id) AS n_cnt
    FROM(
        SELECT
        player_id,
        event_date,
        DENSE_RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rnk,
        LEAD(event_date, 1) OVER (PARTITION BY player_id ORDER BY event_date) AS next_d
        
        FROM Activity
    )sub
    WHERE rnk = 1 AND DATEDIFF(next_d, event_date) = 1
),
de AS(
SELECT COUNT(DISTINCT player_id) AS d_cnt
FROM Activity
)

SELECT
ROUND(n_cnt/d_cnt,2) AS fraction
FROM nu, de

/* left join */
SELECT ROUND(COUNT(DISTINCT b.player_id)/COUNT(DISTINCT a.player_id), 2) AS fraction FROM Activity AS a
LEFT JOIN
(SELECT player_id, MIN(event_date) AS first_login FROM Activity
GROUP BY player_id) AS b
ON a.player_id = b.player_id
AND DATEDIFF(a.event_date, b.first_login) = 1
