# 05. Weather Observation Station 18

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-18/problem)

## What it's asking
Take two points on a map: `P1` uses the smallest `LAT_N` and smallest
`LONG_W` in `STATION`; `P2` uses the largest `LAT_N` and largest
`LONG_W`. Print the **Manhattan distance** between them, rounded to 4
decimal places.

Manhattan distance just means: add up how far apart the points are on
each axis separately (no diagonal shortcuts) —
`|x1 - x2| + |y1 - y2|`.

## Steps
1. Get the four building blocks: `MIN(LAT_N)`, `MAX(LAT_N)`, `MIN(LONG_W)`,
   `MAX(LONG_W)`.
2. Find the gap on each axis with `ABS(...)`, so it doesn't matter which
   value happens to be bigger.
3. Add the two gaps together, then round to 4 decimal places.

## Code
```sql
SELECT ROUND(
  ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)),
  4
)
FROM STATION;
```

## Walkthrough
- `ABS(number)` strips the sign off a number — `ABS(-5)` and `ABS(5)` both
  give `5`. It's used here so the formula works regardless of whether
  `MIN` or `MAX` happens to be larger (they always are, but writing `ABS`
  makes that assumption unnecessary).
- The four aggregate functions (`MIN`, `MAX`) run once each over the whole
  table, then get combined with regular arithmetic — you've done this
  kind of "aggregate, then do math on the results" step before, in
  "Population Density Difference."
- `ROUND(..., 4)` wraps the whole calculation to round the final answer,
  same as earlier rounding problems.
