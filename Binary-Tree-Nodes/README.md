## 🚀 Challenge: Binary Tree Nodes
**Difficulty:** Medium  
**Platform:** HackerRank  
**Key Concepts:** Hierarchical Traversal, Pre-Aggregation, Left Joins, Conditional Logic (CASE WHEN).

### 🧠 Technical Overview & Hierarchical Logic
Processing tree or network structures in relational databases usually involves costly recursive operations or nested subqueries. The goal is to classify every node `N` from a Binary Search Tree into three operational categories: **Root**, **Inner**, or **Leaf**.

### 🛠 My Architectural Approach (The Self-Join Optimization)

Instead of evaluating an `IN` condition for every single row—which degrades performance on large datasets—I designed a **Pre-Aggregated Self-Join** model:

1.  **The Child Counter Matrix (`B2`):** 
    I isolated the dataset and ran a fast `GROUP BY P` aggregation to count how many times each node acts as a parent. This creates a lightweight hash table of structural relationships.
2.  **The Left Join Pipeline:** 
    By running a `LEFT JOIN` from the main tree (`B1`) to our matrix (`B2`), nodes without children naturally receive a `NULL` value in the counter column (`B2.C`).
3.  **Streamlined Routing:** 
    The `CASE` statement evaluates the structural flags instantly:
    *   No parent (`B1.P IS NULL`) ➡️ **Root**.
    *   No children records (`B2.C IS NULL`) ➡️ **Leaf**.
    *   Active relationship bridge ➡️ **Inner**.

### 📊 Performance Implications
This architecture shifts the heavy lifting to a single aggregation pass, allowing the database engine to utilize efficient merge joins or hash lookups. It showcases production-grade SQL optimization habits.

---
*Focusing on clean code, performance trade-offs, and scalable SQL architecture.*
