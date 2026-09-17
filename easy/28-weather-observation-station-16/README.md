# 28. Weather Observation Station 16

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-16/problem)

## What it's asking
Print the smallest `LAT_N` value from `STATION` that is greater than
38.7780. Round the answer to 4 decimal places.

## Steps
1. Filter to `LAT_N > 38.7780`.
2. Find the smallest one left with `MIN(LAT_N)`.
3. Round to 4 decimal places (this one says *round*, not *truncate* — so
   use `ROUND`, not `TRUNCATE`).

## Code
```sql
SELECT ROUND(MIN(LAT_N), 4)
FROM STATION
WHERE LAT_N > 38.7780;
```

## Walkthrough
- Mirror image of the previous problem: `MIN` instead of `MAX`, and a
  `>` filter instead of `<`.
- Pay attention to whether a problem says "round" or "truncate" — they
  give different results, and HackerRank checks for the exact one asked
  for.
