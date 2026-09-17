# 22. Average Population

[HackerRank link](https://www.hackerrank.com/challenges/average-population/problem)

## What it's asking
Print the average population for **all** cities in `CITY`, rounded *down*
to the nearest whole number.

## Steps
1. No filter this time — every city counts.
2. `AVG(POPULATION)` gives the average, but it'll likely come out with
   decimals (like `1234567.89`).
3. Wrap it in `FLOOR()` to round down to a whole number.

## Code
```sql
SELECT FLOOR(AVG(POPULATION))
FROM CITY;
```

## Walkthrough
- `FLOOR(number)` rounds *down* to the nearest integer, no matter what the
  decimal part is — `4.9` becomes `4`, not `5`.
- Functions can wrap other functions: `AVG(POPULATION)` runs first to get
  the average, and `FLOOR(...)` then rounds that result down.
