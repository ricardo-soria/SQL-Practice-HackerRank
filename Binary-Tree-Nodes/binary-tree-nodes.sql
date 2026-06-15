/* CHALLENGE: Binary Tree Nodes (HackerRank)
   AUTHOR: ricardo-soria
   
   DESCRIPTION:
   A highly optimized hierarchical traversal query. Instead of utilizing standard 
   nested subqueries, this solution leverages a LEFT JOIN against a pre-aggregated 
   derived table to determine node depth and classification (Root, Inner, or Leaf) 
   with maximum performance efficiency.
*/

SELECT 
    B1.N, 
    CASE
        -- TYPE 1: Origin node with no upstream parent.
        WHEN B1.P IS NULL THEN 'Root'
        
        -- TYPE 2: Node with a parent but zero downstream children.
        WHEN B2.C IS NULL THEN 'Leaf'
        
        -- TYPE 3: Node that bridges the hierarchy (has both parent and children).
        ELSE 'Inner' 
    END AS Node_Type
FROM BST B1 
LEFT JOIN (
    -- Pre-aggregating parent IDs to calculate child counts per node
    SELECT P, COUNT(P) AS C 
    FROM BST 
    GROUP BY P
) AS B2 ON B1.N = B2.P
ORDER BY B1.N;
