# 19. Revising Aggregations - The Count Function

[HackerRank link](https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/problem)

## What it's asking
From the `CITY` table, print **how many** cities have a population larger
than 100,000. Just one number, not a list of rows.

## A quick note on aggregate functions
Every query so far has printed *rows* — one line per matching city. This
problem wants a single summary number instead. Functions like `COUNT()`,
`SUM()`, `AVG()`, `MAX()`, and `MIN()` are called **aggregate functions**:
they take a whole column (or a filtered slice of it) and collapse it down
into one value. This problem is the simplest of them.

## Steps
1. Filter down to cities with `POPULATION > 100000`, same as always.
2. Instead of selecting a column, wrap the count around the rows that pass
   the filter: `COUNT(*)`.

## Code
```sql
SELECT COUNT(*)
FROM CITY
WHERE POPULATION > 100000;
```

## Walkthrough
- `WHERE` still runs first — it decides which rows are "in."
- `COUNT(*)` then counts how many rows made it through the filter, instead
  of printing them.
- `COUNT(*)` counts rows regardless of what's in them; `COUNT(column)`
  would count only rows where that specific column isn't empty — here it
  doesn't matter, since every row has a population value.
