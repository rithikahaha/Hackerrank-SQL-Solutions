# 37. Asian Population

[HackerRank link](https://www.hackerrank.com/challenges/asian-population/problem)

## What it's asking
Print the sum of the populations of all cities where the continent is
`'Asia'`.

## Steps
1. Same join as the last two problems.
2. Filter to `COUNTRY.CONTINENT = 'Asia'`.
3. Add up `CITY.POPULATION` for the matching rows.

## Code
```sql
SELECT SUM(CITY.POPULATION)
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.CONTINENT = 'Asia';
```

## Walkthrough
- This is "African Cities" and "Japan Population" fused together: the
  join and filter from the African Cities problem, plus the `SUM` from
  Japan Population.
- By now the join itself should feel routine — `JOIN COUNTRY ON
  CITY.COUNTRYCODE = COUNTRY.CODE` is the same line in all three of the
  last problems. What changes is what you do with the joined rows
  afterward.
