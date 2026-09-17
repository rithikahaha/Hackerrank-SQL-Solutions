# 04. Japanese Cities' Name

[HackerRank link](https://www.hackerrank.com/challenges/japanese-cities-name/problem)

## What it's asking
Same filter as before (Japanese cities), but this time print **only the
NAME column**, not the whole row.

## Steps
1. Keep the same `WHERE COUNTRYCODE = 'JPN'` filter.
2. Instead of `SELECT *`, name the one column you actually want: `NAME`.

## Code
```sql
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'JPN';
```

## Walkthrough
- What you filter on (`WHERE`) and what you display (`SELECT`) are separate
  decisions — you can filter by one column and only show a different one.
- Naming a specific column after `SELECT` limits the output to just that
  column, instead of every column in the table.
