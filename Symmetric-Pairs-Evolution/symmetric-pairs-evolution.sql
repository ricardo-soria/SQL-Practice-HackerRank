/* 
   CHALLENGE: Symmetric Pairs (HackerRank)
   AUTHOR: ricardo-soria
   
   DESCRIPTION:
   Three different approaches to identify pairs (X, Y) where a symmetric pair (Y, X) 
   exists in the table, ensuring that for X = Y, at least two instances are present.
*/

--------------------------------------------------------------------------------
-- SOLUTION 1: SELF-JOIN WITH ROW IDENTITY & DISTINCT
-- This approach uses ROW_NUMBER() to handle the "Identity Problem" in datasets 
-- without a primary key. It ensures a row does not match with itself.
--------------------------------------------------------------------------------

SELECT DISTINCT F1.X, F1.Y 
FROM
    (SELECT *, ROW_NUMBER() OVER() AS RN FROM FUNCTIONS) AS F1
    JOIN 
    (SELECT *, ROW_NUMBER() OVER() AS RN FROM FUNCTIONS) AS F2
    ON (F1.X = F2.Y AND F2.X = F1.Y AND F1.RN <> F2.RN)
WHERE F1.X <= F1.Y
ORDER BY F1.X ASC;


--------------------------------------------------------------------------------
-- SOLUTION 2: HYBRID APPROACH (JOIN + GROUP BY)
-- In this version, the DISTINCT keyword is replaced by GROUP BY and HAVING.
-- It demonstrates a transition from simple filtering to aggregate-based logic
-- while still maintaining row identity for the join condition.
--------------------------------------------------------------------------------

SELECT F1.X, F1.Y 
FROM
    (SELECT *, ROW_NUMBER() OVER() AS RN FROM FUNCTIONS) AS F1
    JOIN 
    (SELECT *, ROW_NUMBER() OVER() AS RN FROM FUNCTIONS) AS F2
    ON (F1.X = F2.Y AND F2.X = F1.Y AND F1.RN <> F2.RN)
GROUP BY F1.X, F1.Y
HAVING COUNT(*) > 1 OR F1.X < F1.Y
ORDER BY F1.X ASC;


--------------------------------------------------------------------------------
-- SOLUTION 3: OPTIMIZED SET-THEORY (EXISTS & GROUP BY)
-- The most professional and scalable version. It eliminates the need for 
-- self-joins and row numbering, instead using a correlated subquery (EXISTS) 
-- to validate symmetry efficiently.
--------------------------------------------------------------------------------

SELECT X, Y 
FROM FUNCTIONS
WHERE X <= Y
GROUP BY X, Y
HAVING COUNT(*) > 1 OR (X < Y AND EXISTS
    (SELECT 1 FROM FUNCTIONS F2
     WHERE FUNCTIONS.X = F2.Y AND FUNCTIONS.Y = F2.X))
ORDER BY X;
