# 11. Weather Observation Station 7

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-7/problem)

## What it's asking
Print a list of `CITY` names that **end with a vowel**. Don't repeat names.

## Steps
1. Same idea as station 6, but check the *last* letter instead of the
   first — use `RIGHT(CITY, 1)`.
2. Compare it against the five vowels with `IN (...)`.
3. Add `DISTINCT` to drop repeats.

## Code
```sql
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U');
```

## Walkthrough
- `RIGHT(CITY, 1)` grabs the last `1` character of the name — the mirror
  image of `LEFT(CITY, 1)` from the previous problem.
- Everything else works exactly the same as station 6.
