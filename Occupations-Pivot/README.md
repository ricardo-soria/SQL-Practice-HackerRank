## 🚀 Challenge: Occupations (Data Pivoting)
**Difficulty:** Medium  
**Key Concepts:** Data Transformation, Pivot Tables, Window Functions.

### 🧠 The Logic Behind the Transformation:
Pivoting data in SQL requires a mental model of how rows transform into columns. To solve this, I visualized the process in 3 critical stages, as documented in my Excel analysis below:

#### 1. Row Indexing (Partitioning)
I used `ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name)` to assign a unique rank to each person within their category. This is the "glue" that allows us to align a Doctor and an Actor on the same horizontal line.

#### 2. Case Mapping & Aggregation
Using `MAX(CASE WHEN...)`, I mapped each name to its specific column. The `MAX` function is essential here to collapse the NULL values into a single clean row per index.

### 📊 Visual Breakdown (My Excel Process):
*Here is how I modeled the data before writing the final query:*

![Original Data](./original-data.png)
*Figure 1: Original data of the exercise.*

![Step 1 - Indexing](./step1-indexing.png)
*Figure 2: Assigning row numbers per occupation.*

![Step 2 - Matrix](./step2-pivoting.png)
*Figure 3: Transforming rows into columns with NULL handling.*

![Step 3 - Final Output](./step3-final-result.png)
*Figure 4: Final clean matrix.*
