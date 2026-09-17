# 39. Draw The Triangle 1

[HackerRank link](https://www.hackerrank.com/challenges/draw-the-triangle-1/problem)

## What it's asking
There's no table to query here at all — you have to *generate* the output
yourself. Print a triangle of stars, 20 rows tall, shrinking by one star
each row:

```
* * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * *
...
* *
*
```

The top row has 20 stars, the next has 19, down to a single star on the
last row.

## Steps
1. With no source table, you first need a list of numbers 20 down to 1 to
   drive the row-by-row shrinking — the same **recursive CTE** idea from
   "Print Prime Numbers," just counting down instead of up.
2. For each number `n` in that list, print a row of `n` stars separated by
   spaces.
3. Order the rows so 20 comes first and 1 comes last.

## Code
```sql
WITH RECURSIVE rows AS (
  SELECT 20 AS n
  UNION ALL
  SELECT n - 1 FROM rows WHERE n > 1
)
SELECT REPEAT('* ', n)
FROM rows
ORDER BY n DESC;
```

## Walkthrough
- The recursive CTE here counts *down*: it starts at 20, and each next row
  subtracts 1, stopping once `n` reaches 1. This is the same recursive
  building-block from "Print Prime Numbers" — only the starting point and
  the step direction changed.
- `REPEAT(text, n)` repeats a piece of text `n` times in a row. `REPEAT('*
  ', n)` repeats `"* "` (a star and a space) `n` times, which builds a row
  like `"* * * "` — a trailing space at the end is expected and fine here.
- `ORDER BY n DESC` prints the 20-star row first and the 1-star row last,
  matching the shrinking pattern in the problem.
