# 06. Revising the Select Query II

[HackerRank link](https://www.hackerrank.com/challenges/revising-the-select-query-2/problem)

## What it's asking
Print just the `NAME` of American cities with a population bigger than
120,000.

## Steps
1. Same idea as the last problem — filter by country and population with
   `AND`.
2. Only show the `NAME` column this time, not every column.

## Code
```sql
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 120000;
```

## Walkthrough
- This is basically the previous problem with a different threshold
  (120,000 instead of 100,000) and a narrower `SELECT` list.
- Once you're comfortable combining `WHERE` conditions, changing the number
  or the selected column is a small tweak, not a new problem.
