/* bottom up*/
-- use 3 slef joins to find emp's 3 level mgr
-- check if any of them is emp_id = 1
-- exclude head himself

SELECT
employee_id
FROM (
SELECT
a.employee_id,
a.manager_id AS mgr_1,
b.manager_id AS mgr_2,
c.manager_id AS mgr_3
FROM Employees a
JOIN Employees b
ON a.manager_id = b.employee_id
JOIN Employees c
ON b.manager_id = c.employee_id
)sub
WHERE
((mgr_1 = 1) OR (mgr_2 = 1) OR (mgr_3 = 1)) AND (employee_id != 1)


/* top down recursive cte */
with recursive cte1(id,n) as
(
    select employee_id as id, 1 as n
    from employees
    where manager_id=1 and employee_id!=1
    union
    select employee_id as id,n+1 as n
    from employees, cte1
    where manager_id=cte1.id and n+1<4
)
select id as employee_id 
from cte1
