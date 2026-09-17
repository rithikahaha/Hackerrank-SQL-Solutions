# 27. Weather Observation Station 14

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-14/problem)

## What it's asking
Print the greatest `LAT_N` value from `STATION` that is less than
137.2345. Truncate the answer to 4 decimal places.

## Steps
1. Filter to `LAT_N < 137.2345`.
2. Find the biggest one left with `MAX(LAT_N)`.
3. Truncate to 4 decimal places.

## Code
```sql
SELECT TRUNCATE(MAX(LAT_N), 4)
FROM STATION
WHERE LAT_N < 137.2345;
```

## Walkthrough
- This combines two things you've already used separately: filtering with
  `WHERE`, and `MAX()` from the population-density problem.
- Filtering happens before the aggregate, so `MAX(LAT_N)` only looks at the
  rows that already passed the `LAT_N < 137.2345` check.
