# 09. Placements

[HackerRank link](https://www.hackerrank.com/challenges/placements/problem)

## What it's asking
Three tables: `Students` (ID, Name), `Friends` (ID, Friend_ID — each
student's one best friend), and `Packages` (ID, Salary — the monthly
salary offered to that student). Print the names of students whose best
friend was offered a **higher** salary than they were, ordered by how
much the friend was offered (ascending).

**Students table**
| Column | Type |
|---|---|
| ID | Integer |
| Name | String |

**Friends table**
| Column | Type |
|---|---|
| ID | Integer |
| Friend_ID | Integer |

**Packages table**
| Column | Type |
|---|---|
| ID | Integer |
| Salary | Float |

## Steps
1. You need four things lined up in one row: the student's name, the
   student's own salary, who their best friend is, and *that friend's*
   salary. That means joining across all three tables.
2. Join `Students` to `Friends` to find out who each student's best
   friend is, and join `Students` to `Packages` to get the student's own
   salary.
3. Join `Packages` a *second* time — matched to the friend's ID instead of
   the student's — to get the friend's salary.
4. Keep only the rows where the friend's salary is higher, and sort by
   that friend's salary.

## Code
```sql
SELECT s.Name
FROM Students s
JOIN Friends f ON s.ID = f.ID
JOIN Packages p ON s.ID = p.ID
JOIN Packages fp ON f.Friend_ID = fp.ID
WHERE fp.Salary > p.Salary
ORDER BY fp.Salary;
```

## Walkthrough
- `Packages` is joined twice, under two different names (`p` and `fp`) —
  once matched to the student's own `ID` (their salary), and once matched
  to `f.Friend_ID` (their friend's salary). This is the same trick as the
  self-join in "Symmetric Pairs," except here it's two different tables
  being joined to a shared table, rather than a table joined to itself.
- `WHERE fp.Salary > p.Salary` compares the two salaries directly, now
  that both are sitting in the same row thanks to the joins.
- Once all four tables are joined, the query reads like any other
  filter-and-sort query — the work is entirely in setting up the joins
  correctly.
