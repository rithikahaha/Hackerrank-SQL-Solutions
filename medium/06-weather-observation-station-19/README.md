# 06. Weather Observation Station 19

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-19/problem)

## What it's asking
Same two points as the last problem — `P1` at (min `LAT_N`, min
`LONG_W`), `P2` at (max `LAT_N`, max `LONG_W`) — but this time print the
**Euclidean distance** between them (the straight-line, "as the crow
flies" distance), to 4 decimal places.

Euclidean distance is the familiar one from geometry:
`√((x1 - x2)² + (y1 - y2)²)`.

## Steps
1. Same four building blocks as station 18: `MIN`/`MAX` of `LAT_N` and
   `LONG_W`.
2. Square the difference on each axis instead of taking the absolute
   value.
3. Add the two squared differences, take the square root, then round.

## Code
```sql
SELECT ROUND(
  SQRT(
    POWER(MAX(LAT_N) - MIN(LAT_N), 2) +
    POWER(MAX(LONG_W) - MIN(LONG_W), 2)
  ),
  4
)
FROM STATION;
```

## Walkthrough
- `POWER(number, 2)` squares a number — squaring automatically gets rid of
  negative signs too, which is why this formula doesn't need `ABS` the
  way the Manhattan distance one did.
- `SQRT(number)` takes the square root — applied last, after both squared
  differences have been added together.
- This is the exact same "aggregate, then do math" shape as the last
  problem, just with a different formula plugged in.
