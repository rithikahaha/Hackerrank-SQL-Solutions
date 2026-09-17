# 15. Weather Observation Station 12

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-12/problem)

## What it's asking
Print `CITY` names that **both** don't start with a vowel **and** don't
end with a vowel. Don't repeat names.

## Steps
1. Same two checks as the last problem.
2. This time both need to be true at once, so use `AND` instead of `OR`.

## Code
```sql
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U')
  AND RIGHT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U');
```

## Walkthrough
- The only difference from station 11 is swapping `OR` for `AND` — a small
  change that makes the condition stricter.
- With `AND`, a city only qualifies if it fails the vowel check on *both*
  ends, not just one.
