# 10. Weather Observation Station 6

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-6/problem)

## What it's asking
Print a list of `CITY` names that **start with a vowel** (a, e, i, o, u).
Don't repeat names.

## Steps
1. Grab just the first letter of each name with `LEFT(CITY, 1)`.
2. Check if that letter is one of the five vowels using `IN (...)`.
3. Add `DISTINCT` so repeated city names only show once.

## Code
```sql
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U');
```

## Walkthrough
- `LEFT(CITY, 1)` takes the first `1` character of the `CITY` text — the
  first letter of the name.
- `IN ('A', 'E', 'I', 'O', 'U')` checks that value against a list, so you
  don't have to write five separate `OR` conditions
  (`= 'A' OR = 'E' OR ...`).
