-- use window func. with rows between current and 6 preceding
-- make tb by date
-- sum up amt to get moving sum
-- moving suM / 7 to get moving avg

SELECT
visited_on,
amount,
average_amount
FROM
(
    SELECT
    visited_on,
    SUM(day_amt) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW ) AS amount,
    ROUND(SUM(day_amt) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW ) / 7,2) AS average_amount
    FROM
    (
    SELECT
    visited_on,
    sum(amount) AS day_amt
    FROM Customer
    GROUP BY 1
    )sub
)sub2
WHERE DATEDIFF(visited_on ,(SELECT MIN(visited_on) FROM Customer)) >=6

/* faster sol. without correlated subquery */
SELECT
sub2.visited_on,
sub2.amount,
sub2.average_amount
FROM(
    SELECT
    sub.visited_on,
    SUM(sub.amount) OVER(ORDER BY sub.visited_on ROWS 6 PRECEDING) AS amount,
    ROUND(SUM(sub.amount) OVER(ORDER BY sub.visited_on ROWS 6 PRECEDING)/7,2) AS average_amount,
    RANK() OVER(ORDER BY sub.visited_on) AS rnk
    FROM
        (
            SELECT 
            visited_on,
            SUM(amount) as amount
            FROM Customer
            GROUP BY 1
            ORDER BY 1 desc
        )sub
    )sub2
WHERE sub2.rnk>=7
