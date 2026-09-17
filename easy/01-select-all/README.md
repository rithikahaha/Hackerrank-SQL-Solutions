# 01. Select All

[HackerRank link](https://www.hackerrank.com/challenges/select-all-sql/problem)

## What it's asking
There's a `CITY` table. Print **every column, for every row** — no filtering.

**CITY table**
| Column | Type |
|---|---|
| ID | NUMBER |
| NAME | VARCHAR2(17) |
| COUNTRYCODE | VARCHAR2(3) |
| DISTRICT | VARCHAR2(20) |
| POPULATION | NUMBER |

## Steps
1. You want all the columns, so use `*` instead of naming each one.
2. You want all the rows, so there's no `WHERE` clause to filter anything out.

## Code
```sql
SELECT *
FROM CITY;
```

## Walkthrough
- `SELECT *` is shorthand for "give me every column" — you'd otherwise have to
  type `ID, NAME, COUNTRYCODE, DISTRICT, POPULATION` by hand.
- `FROM CITY` tells the database which table to read from.
- With no `WHERE` clause, nothing is excluded — every row comes back.
