/* CHALLENGE: Interviews (HackerRank)
   AUTHOR: ricardo-soria
   
   DESCRIPTION:
   A complex multi-table aggregation query that extracts contest statistics. 
   To prevent data inflation caused by many-to-many relationship structures 
   between View and Submission stats, this architecture aggregates metrics 
   independently inside CTEs (Common Table Expressions) before joining them 
   to the main relational pipeline.
*/

-- CTE 1: Pre-aggregating View Statistics per Challenge
WITH Sum_views AS (
    SELECT challenge_id, 
           SUM(total_views) AS stv, 
           SUM(total_unique_views) AS stuv
    FROM View_Stats
    GROUP BY challenge_id
),

-- CTE 2: Pre-aggregating Submission Statistics per Challenge
Sum_submissions AS (
    SELECT challenge_id, 
           SUM(total_submissions) AS sts, 
           SUM(total_accepted_submissions) AS stas
    FROM Submission_Stats
    GROUP BY challenge_id
)

-- Main Pipeline: Joining core tables and merging aggregated metrics
SELECT 
    C1.contest_id, 
    C1.hacker_id, 
    C1.name, 
    SUM(SS.sts) AS ssts, 
    SUM(SS.stas) AS sstas, 
    SUM(SV.stv) AS sstv, 
    SUM(SV.stuv) AS sstuv
FROM Contests C1
JOIN Colleges C2 ON C2.contest_id = C1.contest_id
JOIN Challenges C3 ON C3.college_id = C2.college_id
LEFT JOIN Sum_views SV ON SV.challenge_id = C3.challenge_id
LEFT JOIN Sum_submissions SS ON SS.challenge_id = C3.challenge_id
GROUP BY C1.contest_id, C1.hacker_id, C1.name
-- Filter out contests with zero activity across all metrics
HAVING ssts > 0 OR sstas > 0 OR sstv > 0 OR sstuv > 0
ORDER BY C1.contest_id;
