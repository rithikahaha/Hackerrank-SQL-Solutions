# 13. Weather Observation Station 9

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-9/problem)

## What it's asking
Print `CITY` names that **do not** start with a vowel. Don't repeat names.

## Steps
1. Same first-letter check as station 6 — `LEFT(CITY, 1) IN (...)`.
2. This time you want the opposite result, so flip `IN` to `NOT IN`.

## Code
```sql
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U');
```

## Walkthrough
- `NOT IN (...)` is the reverse of `IN (...)` — it keeps rows where the
  value is **not** one of the listed options.
- Everything else about the query (grabbing the first letter, using
  `DISTINCT`) stays the same as station 6.
