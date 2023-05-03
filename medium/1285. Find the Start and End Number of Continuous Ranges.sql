-- create row_num of the rows by asc order
-- create new col: row-log_id
-- group by (row-log_id), and get the continuos groups
-- pick the first and the last of each gp
SELECT
MIN(log_id) AS start_id,
MAX(log_id) AS end_id
FROM
(
    SELECT
    log_id,
    (log_id-rnk) AS gp
    FROM 
    (
        SELECT
        log_id,
        ROW_NUMBER() OVER (ORDER BY log_id) AS rnk
        FROM Logs
    )a
)b
GROUP BY b.gp
