## 🚀 Challenge: 15 Days of Learning SQL
**Difficulty:** Hard  
**Platform:** HackerRank  
**Key Concepts:** Correlated Subqueries, Time-Series Continuity, Date Arithmetic, Aggregation & Partitioning.

### 🧠 Technical Overview & Problem Breakdown
This is widely considered one of the most challenging SQL problems on the platform. It requires tracking user behavior over time to extract two complex metrics simultaneously every day:
1.  **Churn/Retention Tracking:** Determining how many unique users have submitted code *every single day* from the start date (`2016-03-01`) up to the current row's date.
2.  **Daily Leadership:** Identifying the single user with the highest submission volume for that specific day, implementing a strict tie-breaking rule (lowest ID wins).

### 🛠 My Architectural Approach

*   **Solving the Continuity Streak (The Hardest Part):**
    Instead of using heavy recursive CTEs, I implemented a highly mathematical solution using `DATEDIFF`. By comparing the total count of distinct submission dates for a user (`s4.submission_date <= s3.submission_date`) against the actual days elapsed since Day 1 (`DATEDIFF(...) + 1`), the query dynamically isolates only those users whose attendance ratio remains exactly 100%.

*   **Modular Correlation:**
    The query uses decoupled inline scalar subqueries driven by a core calendar anchor loop (`s1`). This architectural pattern prevents cross-join rows duplication, ensuring clean, predictable data aggregation for the daily leaderboards.

### 📊 Performance Implications
In a production cloud data warehouse environment, this multi-layered correlated subquery structure efficiently evaluates sequential intervals. It demonstrates advanced mastery of relational algebra and operational logic without relying on window frame mutations.

---
*Focusing on clean code, performance trade-offs, and scalable SQL architecture.*
