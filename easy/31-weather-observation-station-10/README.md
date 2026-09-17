# 31. Weather Observation Station 10

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-10/problem)

## What it's asking
Print `CITY` names from `STATION` that **do not end** with a vowel. Don't
repeat names.

## Steps
1. Check the last letter with `RIGHT(CITY, 1)`.
2. Use `NOT IN` to keep only the names where that last letter isn't a
   vowel.
3. Add `DISTINCT` to avoid repeats.

## Code
```sql
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U');
```

## Walkthrough
- This is the same shape as "Weather Observation Station 9" (not starting
  with a vowel), just checking the last letter instead of the first — the
  same swap you made between stations 6 and 7 earlier.
- If a pattern like this feels familiar, that's the point: most SQL
  problems are small variations on a handful of building blocks.
