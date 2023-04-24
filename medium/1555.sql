WITH cte AS (
  SELECT
  user_id,
  SUM(net_txn) as net_txn
  FROM
  (
    SELECT
    paid_by AS user_id,
    -SUM(amount) AS net_txn
    FROM Transactions
    GROUP BY 1
    UNION ALL
    SELECT
    paid_to AS user_id,
    SUM(amount) AS net_txn
    FROM Transactions
    GROUP BY 1
  ) sub
  GROUP BY user_id
)

SELECT
u.user_id,
u.user_name,
u.credit + COALESCE(cte.net_txn, 0) AS credit,
(CASE WHEN u.credit + COALESCE(cte.net_txn, 0) < 0 THEN 'Yes' ELSE 'No' END) AS credit_limit_breached
FROM Users u
LEFT JOIN cte
ON u.user_id = cte.user_id

/* More concise sol. */
SELECT user_id,user_name,
IFNULL(SUM(CASE WHEN a.user_id=b.paid_by THEN -amount ELSE amount END),0)+a.credit as credit,
CASE WHEN IFNULL(SUM(CASE WHEN a.user_id=b.paid_by THEN -amount ELSE amount END),0)>=-a.credit THEN "No" ELSE "Yes" END as credit_limit_breached
FROM Users as a
LEFT JOIN Transactions as b
ON a.user_id=b.paid_by OR a.user_id=b.paid_to
GROUP BY a.user_id;
