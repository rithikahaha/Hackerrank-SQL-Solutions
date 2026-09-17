# 12. Weather Observation Station 8

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-8/problem)

## What it's asking
Print `CITY` names where **both** the first letter and the last letter are
vowels. Don't repeat names.

## Steps
1. You already know how to check the first letter (station 6) and the last
   letter (station 7) separately.
2. This problem needs both checks to be true at the same time — join them
   with `AND`.

## Code
```sql
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U')
  AND RIGHT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U');
```

## Walkthrough
- This is literally the `WHERE` clauses from the last two problems, joined
  with `AND`.
- `AND` only keeps a row when **every** condition attached to it is true —
  here, both the first-letter check and the last-letter check.
