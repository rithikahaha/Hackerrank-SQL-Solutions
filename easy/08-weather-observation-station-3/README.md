# 08. Weather Observation Station 3

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-3/problem)

## What it's asking
Print a list of `CITY` names from `STATION` where the `ID` is an even
number. Don't repeat a city name if it shows up more than once.

## Steps
1. "Even ID" means `ID` divided by 2 leaves no remainder — check that with
   `MOD(ID, 2) = 0`.
2. The same city name could appear on more than one even-ID row, so add
   `DISTINCT` to drop repeats from the output.

## Code
```sql
SELECT DISTINCT CITY
FROM STATION
WHERE MOD(ID, 2) = 0;
```

## Walkthrough
- `MOD(a, b)` gives the remainder of `a ÷ b`. For even numbers, the
  remainder of dividing by 2 is always `0`.
- `DISTINCT` removes duplicate values from the result — without it, a city
  name could print twice if two even-ID rows both have that name.
