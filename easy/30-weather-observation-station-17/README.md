# 30. Weather Observation Station 17

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-17/problem)

## What it's asking
Find the row in `STATION` with the **smallest `LAT_N` that's still greater
than 38.7780**, and print that row's `LONG_W`, rounded to 4 decimal places.

## Steps
1. Same idea as the previous problem, but with `MIN` instead of `MAX`, and
   a `>` filter instead of `<`.
2. Subquery first to find the smallest qualifying latitude, then look up
   the `LONG_W` for the row that has it.

## Code
```sql
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (
  SELECT MIN(LAT_N)
  FROM STATION
  WHERE LAT_N > 38.7780
);
```

## Walkthrough
- Once you've solved one "subquery for the matching row" problem, this one
  is the same shape with `MIN`/`MAX` and `<`/`>` swapped.
- If this still feels shaky, re-read problem 29's walkthrough — the logic
  here is identical.
