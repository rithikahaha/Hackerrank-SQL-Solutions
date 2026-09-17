# 14. Weather Observation Station 11

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-11/problem)

## What it's asking
Print `CITY` names that either **don't start** with a vowel, **or don't
end** with a vowel (only one of the two needs to be true). Don't repeat
names.

## Steps
1. You already have both checks: "doesn't start with a vowel" and "doesn't
   end with a vowel."
2. Because only *one* of them needs to hold, join them with `OR` instead of
   `AND`.

## Code
```sql
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U')
   OR RIGHT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U');
```

## Walkthrough
- `OR` keeps a row if **at least one** side is true — unlike `AND`, it
  doesn't need both.
- So a city is included here if its first letter isn't a vowel, its last
  letter isn't a vowel, or neither of its letters is a vowel.
