# 36. African Cities

[HackerRank link](https://www.hackerrank.com/challenges/african-cities/problem)

## What it's asking
Print the names of all cities where the continent is `'Africa'`. Continent
lives in `COUNTRY`, not `CITY`, so you'll need the same join as the
previous problem.

## Steps
1. Join `CITY` to `COUNTRY` on `CITY.COUNTRYCODE = COUNTRY.CODE`, same as
   before.
2. Filter the joined rows with `WHERE COUNTRY.CONTINENT = 'Africa'`.
3. Print `CITY.NAME`.

## Code
```sql
SELECT CITY.NAME
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.CONTINENT = 'Africa';
```

## Walkthrough
- Once two tables are joined, you can filter and select from them exactly
  like a single table — `WHERE COUNTRY.CONTINENT = 'Africa'` works the
  same way `WHERE COUNTRYCODE = 'JPN'` did back in "Japanese Cities'
  Attributes."
- No `GROUP BY` needed here since this problem wants a list of matching
  cities, not one summary number per group.
