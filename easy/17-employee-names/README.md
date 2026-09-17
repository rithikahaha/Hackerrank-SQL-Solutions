# 17. Employee Names

[HackerRank link](https://www.hackerrank.com/challenges/name-of-employees/problem)

## What it's asking
There's an `Employee` table. Print every employee's `name`, sorted
alphabetically (A to Z).

**Employee table**
| Column | Type |
|---|---|
| employee_id | Integer |
| name | String |
| months | Integer |
| salary | Integer |

## Steps
1. No filtering needed — you want everyone.
2. Add `ORDER BY name` to sort the output.

## Code
```sql
SELECT name
FROM Employee
ORDER BY name;
```

## Walkthrough
- `ORDER BY` sorts the rows in the result. For text, the default order is
  alphabetical (A→Z); for numbers, it's smallest to largest.
- Without `ORDER BY`, rows would come back in whatever order the database
  happens to store them — not guaranteed to be alphabetical.
