# 03. Japanese Cities' Attributes

[HackerRank link](https://www.hackerrank.com/challenges/japanese-cities-attributes/problem)

## What it's asking
Print every column, but only for cities in Japan. Japan's `COUNTRYCODE` is
`'JPN'`.

## Steps
1. Same shape as before: `SELECT *` for all columns.
2. Filter with `WHERE COUNTRYCODE = 'JPN'`.

## Code
```sql
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'JPN';
```

## Walkthrough
- Text values (like `'JPN'`) go inside single quotes in SQL — numbers don't
  need quotes, but words and codes do.
- `WHERE COUNTRYCODE = 'JPN'` keeps only the rows where that column exactly
  matches `'JPN'`.
