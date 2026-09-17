# 08. The Report

[HackerRank link](https://www.hackerrank.com/challenges/the-report/problem)

## What it's asking
Two tables: `Students` (ID, Name, Marks) and `Grades` (min_mark, max_mark,
grade — grade 1 is marks 0-9, grade 2 is 10-19, ... up to grade 10 for
90-100). Build a report with `Name`, `Grade`, `Marks`:
- If the grade is 8 or higher, show the real name.
- If the grade is below 8, show `NULL` instead of the name (to keep those
  students anonymous).
- Sort by grade, highest first.
- Within the same grade: if it's 8 or higher, break ties by name
  (alphabetically); if it's below 8, break ties by marks (ascending).

## Steps
1. Join `Students` to `Grades` — each student's `Marks` falls between
   some row's `min_mark` and `max_mark`.
2. Decide the name to show with a `CASE WHEN`: real name for grade ≥ 8,
   `NULL` otherwise.
3. Sort by grade descending first. The tiebreaker column is *different*
   depending on the grade, so build it with two more `CASE WHEN`
   expressions inside `ORDER BY` — one that only has a value when grade <
   8 (sort by marks), one that only has a value when grade ≥ 8 (sort by
   name). Whichever one applies is the one that actually affects the
   order, since it's the only one with real values in that group.

## Code
```sql
SELECT
  CASE WHEN g.grade < 8 THEN NULL ELSE s.Name END AS Name,
  g.grade,
  s.Marks
FROM Students s
JOIN Grades g ON s.Marks BETWEEN g.min_mark AND g.max_mark
ORDER BY
  g.grade DESC,
  CASE WHEN g.grade < 8 THEN s.Marks END ASC,
  CASE WHEN g.grade >= 8 THEN s.Name END ASC;
```

## Walkthrough
- `BETWEEN a AND b` is shorthand for `>= a AND <= b` — here it's the join
  condition instead of a `WHERE` filter, matching each student to the one
  grade band their marks fall into.
- The first `CASE WHEN` decides *what to display*: it swaps the name for
  `NULL` once the grade drops below 8, per the anonymity rule.
- The two `CASE WHEN` expressions inside `ORDER BY` decide *how to sort*,
  and they're deliberately one-sided: `CASE WHEN g.grade < 8 THEN s.Marks
  END` only produces a value for low grades (it's `NULL` otherwise), and
  the next line only produces a value for high grades. Since `ORDER BY
  g.grade DESC` already groups all same-grade rows together, only one of
  these two columns actually has real values within any given group — so
  only that one ends up influencing the order there.
- You can sort by an expression that isn't in the `SELECT` list at all —
  `ORDER BY` is allowed to reference columns and calculations that never
  appear in the output.
