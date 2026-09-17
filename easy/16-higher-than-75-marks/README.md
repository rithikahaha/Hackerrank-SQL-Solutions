# 16. Higher Than 75 Marks

[HackerRank link](https://www.hackerrank.com/challenges/more-than-75-marks/problem)

## What it's asking
There's a `Students` table. Print the `Name` of every student who scored
more than 75 marks, ordered by the **last 3 characters** of their name. If
two students tie on that, break the tie by their `ID` (smallest first).

**Students table**
| Column | Type |
|---|---|
| ID | Integer |
| Name | String |
| Marks | Integer |

## Steps
1. Filter first: keep only students with `Marks > 75`.
2. The sort key is unusual — it's the last 3 letters of the name, not the
   whole name. `RIGHT(Name, 3)` gets that.
3. Some students might share the same last 3 letters, so add `ID` as a
   second sort key to break ties consistently.

## Code
```sql
SELECT Name
FROM Students
WHERE Marks > 75
ORDER BY RIGHT(Name, 3), ID;
```

## Walkthrough
- `WHERE Marks > 75` runs before any sorting — it decides which rows are
  even in the running.
- `ORDER BY` can take more than one column. It sorts by the first one
  (`RIGHT(Name, 3)`) and only looks at the second (`ID`) to decide the
  order between rows that are tied on the first.
