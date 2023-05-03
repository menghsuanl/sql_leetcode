-- expand row using union to make teams in one column
-- compute points for each match
-- group points by team
-- left join team name
WITH pt AS(
SELECT
host_team as team_id,
(CASE WHEN host_goals > guest_goals THEN 3
    WHEN host_goals = guest_goals THEN 1 ELSE 0 END) AS pt
FROM Matches
UNION ALL
SELECT
guest_team as team_id,
(CASE WHEN host_goals < guest_goals THEN 3
    WHEN host_goals = guest_goals THEN 1 ELSE 0 END) AS pt
FROM Matches
)

SELECT
t.team_id,
t.team_name,
IFNULL(SUM(p.pt),0) AS num_points
FROM pt p
RIGHT JOIN Teams t
ON p.team_id = t.team_id
GROUP BY 1,2
ORDER BY SUM(p.pt) DESC, t.team_id



/*
-- turn goals into points
-- sum up pts by team(both host+guest)
-- order the result

    SELECT
    t.team_id,
    t.team_name,
    SUM(CASE WHEN team_id = host_team AND host_goals > guest_goals THEN 3
    WHEN team_id = guest_team AND host_goals < guest_goals THEN 3 
    WHEN host_goals = guest_goals THEN 1
    ELSE 0 END) AS num_points
    FROM Teams t
    LEFT JOIN
    Matches m
    ON t.team_id = m.host_team OR t.team_id = m.guest_team
    GROUP BY 1,2
    ORDER BY num_points DESC, team_id
*/
