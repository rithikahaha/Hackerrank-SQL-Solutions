# 21. Revising Aggregations - Averages

[HackerRank link](https://www.hackerrank.com/challenges/revising-aggregations-the-average-function/problem)

## What it's asking
Print the **average population** of all cities in `CITY` where `DISTRICT`
is `'California'`.

## Steps
1. Same filter as the last problem: `WHERE DISTRICT = 'California'`.
2. Swap `SUM` for `AVG` to get the average instead of the total.

## Code
```sql
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';
```

## Walkthrough
- `AVG(column)` adds up the values (like `SUM` does) and then divides by
  how many rows there are — you get the mean population in one step.
- At this point you've seen `COUNT`, `SUM`, and `AVG` used in the exact
  same pattern: filter with `WHERE`, then aggregate what's left.
