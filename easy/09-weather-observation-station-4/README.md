# 09. Weather Observation Station 4

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-4/problem)

## What it's asking
Find the difference between the total number of `CITY` entries and the
number of *distinct* `CITY` entries — in other words, how many duplicate
city names exist.

## Steps
1. `COUNT(CITY)` counts every row that has a city name, including repeats.
2. `COUNT(DISTINCT CITY)` counts only the unique names.
3. Subtract the second from the first to get the number of duplicates.

## Code
```sql
SELECT COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION;
```

## Walkthrough
- `COUNT(column)` counts how many rows have a value in that column.
- Adding `DISTINCT` inside `COUNT` tells it to only count each unique value
  once, instead of counting every occurrence.
- The gap between "count everything" and "count unique things" is exactly
  the number of extra (duplicate) rows.
