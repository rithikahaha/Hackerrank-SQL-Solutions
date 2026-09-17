# 25. Weather Observation Station 2

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-2/problem)

## What it's asking
Print two numbers from `STATION`: the sum of all `LAT_N` values and the
sum of all `LONG_W` values, each rounded to 2 decimal places.

## Steps
1. You need two separate sums, so list two `SUM(...)` expressions after
   `SELECT`, separated by a comma — just like selecting two columns.
2. Wrap each one in `ROUND(..., 2)` to keep 2 decimal places.

## Code
```sql
SELECT ROUND(SUM(LAT_N), 2), ROUND(SUM(LONG_W), 2)
FROM STATION;
```

## Walkthrough
- `ROUND(number, 2)` rounds to the nearest value with 2 decimal places
  (unlike `FLOOR`, which always rounds down — `ROUND` rounds to the
  *closest* value).
- Selecting multiple aggregate expressions works the same as selecting
  multiple columns: separate them with a comma, and each one becomes its
  own value in the output row.
