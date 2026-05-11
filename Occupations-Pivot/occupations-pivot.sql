/* 
   CHALLENGE: Occupations (Data Pivoting)
   AUTHOR: ricardo-soria
   
   DESCRIPTION:
   Pivot the Occupation column in the OCCUPATIONS table so that each Name is 
   sorted alphabetically and displayed under its corresponding Occupation header.
*/

SELECT 
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
FROM (
    -- Step 1: Assign a row index to each name partitioned by occupation
    -- to align them horizontally during the pivot.
    SELECT 
        *, ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name) AS row_num
    FROM OCCUPATIONS
) AS temp
GROUP BY row_num -- Step 2: Group by the index to create the matrix
ORDER BY row_num;
