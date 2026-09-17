# 05. Revising the Select Query I

[HackerRank link](https://www.hackerrank.com/challenges/revising-the-select-query/problem)

## What it's asking
Print every column, but only for American cities with a population bigger
than 100,000. The `COUNTRYCODE` for the USA is `'USA'`.

## Steps
1. You need two things to be true at once: the right country, **and** a
   big enough population.
2. Chain both conditions in the `WHERE` clause with `AND`.

## Code
```sql
SELECT *
FROM CITY
WHERE POPULATION > 100000
  AND COUNTRYCODE = 'USA';
```

## Walkthrough
- `AND` combines two conditions — a row only survives if **both** sides are
  true. If either one is false, the row gets dropped.
- The order of the two conditions doesn't matter; `COUNTRYCODE = 'USA' AND
  POPULATION > 100000` would give the same result.
