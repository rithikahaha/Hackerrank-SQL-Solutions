# 24. Population Density Difference

[HackerRank link](https://www.hackerrank.com/challenges/population-density-difference/problem)

## What it's asking
Print the difference between the **maximum** and **minimum** populations
in `CITY`.

## Steps
1. `MAX(POPULATION)` gives the biggest population value.
2. `MIN(POPULATION)` gives the smallest.
3. Subtract one from the other.

## Code
```sql
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM CITY;
```

## Walkthrough
- `MAX` and `MIN` are aggregate functions too — they scan the whole column
  and return the largest or smallest value found.
- You can do arithmetic directly on aggregate results, just like on normal
  numbers: `MAX(...) - MIN(...)` runs both aggregates first, then
  subtracts.
