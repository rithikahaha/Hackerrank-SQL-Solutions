# 20. Revising Aggregations - The Sum Function

[HackerRank link](https://www.hackerrank.com/challenges/revising-aggregations-sum/problem)

## What it's asking
Print the **total population** of all cities in `CITY` where the
`DISTRICT` is `'California'`.

## Steps
1. Filter to rows where `DISTRICT = 'California'`.
2. Add up the `POPULATION` values of those rows with `SUM(POPULATION)`.

## Code
```sql
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';
```

## Walkthrough
- `SUM(column)` is another aggregate function — it adds up every value in
  that column across the rows that survive the `WHERE` filter.
- Same shape as the `COUNT` problem: filter first, then aggregate. Only the
  function (`SUM` vs `COUNT`) and what it's applied to (`POPULATION` vs
  `*`) changed.
