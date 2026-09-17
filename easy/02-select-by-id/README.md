# 02. Select By ID

[HackerRank link](https://www.hackerrank.com/challenges/select-by-id/problem)

## What it's asking
Print every column, but only for the one city where `ID = 1661`.

## Steps
1. Start the same way as "Select All" — you still want every column.
2. Add a `WHERE` clause so only the row with the matching ID comes back.

## Code
```sql
SELECT *
FROM CITY
WHERE ID = 1661;
```

## Walkthrough
- `WHERE ID = 1661` is a filter: the database checks every row, keeps the
  ones where the condition is true, and throws away the rest.
- Since `ID` is unique per city, this returns exactly one row.
