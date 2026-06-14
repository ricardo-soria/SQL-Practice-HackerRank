## 🚀 Challenge: Interviews
**Difficulty:** Hard  
**Platform:** HackerRank  
**Key Concepts:** Common Table Expressions (CTEs), Multi-Table Joins, Fan-out Prevention, Conditional Filtering (HAVING).

### 🧠 Technical Overview & The "Fan-Out" Problem
The objective of this challenge is to query the statistics (views and submissions) of various coding contests. The core difficulty lies in the database schema: a single challenge can have multiple rows in `View_Stats` and multiple rows in `Submission_Stats`. 

If you join all these tables directly in a single pipeline, SQL creates a Cartesian product (Fan-out effect). This causes the rows to multiply exponentially, leading to heavily inflated and incorrect `SUM()` totals.

### 🛠 My Architectural Approach

* **Pre-Aggregation via CTEs:**
    To solve the fan-out issue, I isolated the transactional tables (`View_Stats` and `Submission_Stats`) and aggregated their metrics independently using `WITH` clauses grouped strictly by `challenge_id`. This guarantees that each challenge contributes exactly **one unique row** to the main join stream.

* **Relational Schema Traversal:**
    Once the metrics were safely pre-aggregated, I traversed the dimensional hierarchy: `Contests` ➡️ `Colleges` ➡️ `Challenges`. I utilized `LEFT JOINs` to append the aggregated stats, ensuring that contests with missing records in one category aren't dropped from the final matrix.

* **Activity Masking:**
    The final `HAVING` clause filters out any rows where the sum of all metrics equals zero, satisfying the business logic requirement of only displaying active contest data.

---
*Focusing on clean code, performance trade-offs, and scalable SQL architecture.*
