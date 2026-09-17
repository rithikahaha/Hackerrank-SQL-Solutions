# 29. Weather Observation Station 15

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-15/problem)

## What it's asking
Find the row in `STATION` with the **largest `LAT_N` that's still less
than 137.2345**, and print that row's `LONG_W` value, rounded to 4 decimal
places.

This is different from problem 27 — that one wanted the latitude itself;
this one wants the *longitude that belongs to* that specific row.

## Steps
1. You can't just do `MAX(LAT_N)` here, because you don't want the
   latitude — you want the longitude sitting next to it in the same row.
2. First, work out what that largest qualifying latitude actually is: a
   query on its own — `SELECT MAX(LAT_N) FROM STATION WHERE LAT_N <
   137.2345`. This is called a **subquery**: a query nested inside another
   query, used as if it were a single value.
3. Then find the row where `LAT_N` equals that value, and print its
   `LONG_W`.

## Code
```sql
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (
  SELECT MAX(LAT_N)
  FROM STATION
  WHERE LAT_N < 137.2345
);
```

## Walkthrough
- The part in parentheses runs first and produces a single number — the
  largest `LAT_N` under 137.2345.
- The outer query then treats that number like any other value: `WHERE
  LAT_N = (that number)` finds the matching row, and `LONG_W` from that
  same row is what gets printed.
- This is the key idea behind subqueries: when you need "the value in
  column B, from the row where column A is the biggest/smallest," you
  first find that row with a subquery, then pull the column you actually
  want from it.
