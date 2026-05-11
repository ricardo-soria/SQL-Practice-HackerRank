# SQL Practice: HackerRank Solutions

This repository documents my progress in solving complex SQL challenges, focusing on logic, optimization, and clean code.

## 🚀 Featured Challenge: Symmetric Pairs
**Platform:** HackerRank  
**Concepts:** Self-Joins, Row Identity (ROW_NUMBER), Aggregate Functions, Subqueries.

### 🧠 My Evolution of Solutions:
I developed three distinct approaches to solve this challenge, demonstrating an evolution from row-level logic to set-theory optimization:

*   **Version 1: Self-Join with Row Identity (DISTINCT)**
    *   *Concept:* Used `ROW_NUMBER()` to ensure a row doesn't match with itself. Applied `DISTINCT` for the final output.
    
*   **Version 2: Hybrid Join with Aggregation (GROUP BY)**
    *   *Concept:* A transition toward efficiency by replacing `DISTINCT` with `GROUP BY` and `HAVING` to manage the logic of symmetric existence.

*   **Version 3: Optimized Subquery (EXISTS)**
    *   *Concept:* The most scalable version. Leveraging the `EXISTS` clause to validate symmetry without the overhead of a full self-join.

---
*Focusing on clean code, performance trade-offs, and scalable SQL architecture.*
