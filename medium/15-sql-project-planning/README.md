# 15. SQL Project Planning

[HackerRank link](https://www.hackerrank.com/challenges/sql-projects/problem)

## What it's asking
A `Projects` table lists tasks, each with a `Start_Date` and `End_Date`
exactly one day apart. If one task's `End_Date` is the very next task's
`Start_Date`, they're considered part of the same *project* — a run of
back-to-back tasks. Find every project's overall start and end date, and
print them ordered by how many days the project took (ascending), then by
start date for ties.

**Projects table**
| Column | Type |
|---|---|
| Task_ID | Integer |
| Start_Date | Date |
| End_Date | Date |

## Steps
This is a classic pattern called **gaps and islands**: the table is a
timeline with runs ("islands") of consecutive dates, broken up by gaps.
You need to find where each island begins and ends.

1. A date is the **start of a project** if no other task's `End_Date`
   lands exactly on it — meaning nothing leads into it, so it's the first
   task in its run. Check this with `NOT EXISTS`.
2. A date is the **end of a project** the same way, mirrored: no other
   task's `Start_Date` lands exactly on it — nothing continues after it.
3. For every project start, find the *nearest* project end that comes on
   or after it — that's the other edge of the same island.
4. Group by the start date, sort by how long each project took
   (`end - start`), then by start date.

## Code
```sql
SELECT p1.Start_Date, MIN(p2.End_Date) AS End_Date
FROM Projects p1
JOIN Projects p2 ON p2.End_Date >= p1.Start_Date
WHERE NOT EXISTS (SELECT 1 FROM Projects WHERE End_Date = p1.Start_Date)
  AND NOT EXISTS (SELECT 1 FROM Projects WHERE Start_Date = p2.End_Date)
GROUP BY p1.Start_Date
ORDER BY DATEDIFF(End_Date, p1.Start_Date), p1.Start_Date;
```

## Walkthrough
- `NOT EXISTS (subquery)` checks that a subquery finds *nothing* — it's
  the opposite of the `IN (subquery)` pattern you've used before. Here,
  `NOT EXISTS (SELECT 1 FROM Projects WHERE End_Date = p1.Start_Date)`
  reads as: "there is no task whose `End_Date` equals this task's
  `Start_Date`" — i.e., nothing hands off into this task, so it must be a
  project's first day. The `SELECT 1` inside doesn't matter *what* it
  selects — `EXISTS` only cares whether any row comes back at all.
- The second `NOT EXISTS` is the mirror check for project ends: no task
  starts on the day this one ends.
- `p1` (candidate starts) is joined to `p2` (candidate ends) with
  `p2.End_Date >= p1.Start_Date`, then grouped by `p1.Start_Date` and
  reduced with `MIN(p2.End_Date)` — this picks the *closest* valid end for
  each start, which is what pairs each project's start with its own end
  rather than some much later one.
- `DATEDIFF(date1, date2)` gives the number of days between two dates —
  used here to sort projects by how long they took.
- Gaps-and-islands problems like this one are a well-known SQL pattern
  outside of HackerRank too — worth remembering the shape of this
  solution (find edges with `NOT EXISTS`, then pair them up) since it
  comes up in real reporting work (e.g. finding runs of consecutive login
  days, or continuous subscription periods).
