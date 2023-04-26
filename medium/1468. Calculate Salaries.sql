-- Find the max salary of every comp.
-- map comp to tax rate
-- apply to employees
WITH cte AS
(
    SELECT
    company_id,
    (CASE WHEN ms < 1000 THEN 1 
    WHEN ms > 10000 THEN 0.51
    ELSE 0.76 END) AS after_tax
    FROM
    (
        SELECT 
        company_id,
        MAX(salary) as ms
        FROM Salaries
        GROUP BY 1
    )sub
)
SELECT
s.company_id,
s.employee_id,
s.employee_name,
ROUND(s.salary * c.after_tax) AS salary
FROM Salaries s
LEFT JOIN cte c
ON s.company_id = c.company_id

/* window func. to create max_sal column to every employee*/
WITH
tmp AS (
SELECT company_id, employee_id, employee_name, salary, 
MAX(salary) OVER(PARTITION BY company_id) AS max_sal
FROM Salaries   
)

SELECT company_id, employee_id, employee_name,
CASE WHEN max_sal < 1000  THEN ROUND(salary) 
WHEN max_sal BETWEEN 1000 AND 10000 THEN ROUND(salary * (1-0.24))
ELSE ROUND(salary * (1-0.49))
END AS salary
FROM tmp;
