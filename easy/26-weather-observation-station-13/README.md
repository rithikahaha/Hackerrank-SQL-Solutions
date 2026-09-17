# 26. Weather Observation Station 13

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-13/problem)

## What it's asking
Print the sum of `LAT_N` values from `STATION` that are greater than
38.7880 and less than 137.2345. Cut the answer down to 4 decimal places
(don't round — just chop off anything past the 4th digit).

## Steps
1. Filter with two conditions joined by `AND`, same pattern as before.
2. Add up what's left with `SUM(LAT_N)`.
3. Use `TRUNCATE(..., 4)` to cut it to 4 decimal places without rounding.

## Code
```sql
SELECT TRUNCATE(SUM(LAT_N), 4)
FROM STATION
WHERE LAT_N > 38.7880
  AND LAT_N < 137.2345;
```

## Walkthrough
- `TRUNCATE(number, 4)` keeps 4 digits after the decimal point and just
  drops the rest — `1.23456` becomes `1.2345`, no rounding involved. This
  is different from `ROUND`, which can bump the last digit up.
- Everything else is the filter-then-aggregate pattern from earlier
  problems.
