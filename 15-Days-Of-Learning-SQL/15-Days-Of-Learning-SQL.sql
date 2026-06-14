/* 
   CHALLENGE: 15 Days of Learning SQL (HackerRank)
   AUTHOR: ricardo-soria
   
   DESCRIPTION:
   An advanced time-series analysis query that tracks daily submission metrics over 
   a 15-day window. It dynamically calculates:
   1. The count of unique hackers who maintained a perfect daily consecutive streak since Day 1.
   2. The top contributor of each specific day (with tie-breaking logic).
*/

SELECT 
    s1.submission_date,

    -- SUBQUERY 1: Calculate the number of consecutive, uninterrupted hackers since Day 1
    (SELECT COUNT(DISTINCT s3.hacker_id)
     FROM Submissions s3
     WHERE s3.submission_date = s1.submission_date
       AND (
           SELECT COUNT(DISTINCT s4.submission_date)
           FROM Submissions s4
           WHERE s4.hacker_id = s3.hacker_id
             AND s4.submission_date <= s3.submission_date
       ) = DATEDIFF(s3.submission_date, '2016-03-01') + 1
    ) AS num_continuous_hackers,
    
    -- SUBQUERY 2: Find the Hacker ID with the maximum submissions for the current day
    -- Tie-breaker: Lowest hacker_id wins.
    (SELECT s2.hacker_id
     FROM Submissions s2 
     LEFT JOIN Hackers h ON s2.hacker_id = h.hacker_id
     WHERE s2.submission_date = s1.submission_date
     GROUP BY s2.hacker_id
     ORDER BY COUNT(s2.hacker_id) DESC, s2.hacker_id ASC
     LIMIT 1
    ) AS best_hacker_id,
    
    -- SUBQUERY 3: Fetch the name of the top hacker identified in Subquery 2
    (SELECT h.name 
     FROM Hackers h 
     WHERE h.hacker_id = best_hacker_id
    ) AS best_hacker_name
    
FROM (SELECT DISTINCT submission_date FROM Submissions) s1
ORDER BY s1.submission_date;
