# 18. Employee Salaries

[HackerRank link](https://www.hackerrank.com/challenges/salary-of-employees/problem)

## What it's asking
Print the `name` of every employee who earns **more than $2000 a month**
and has worked **fewer than 10 months**, ordered by `employee_id`.

## Steps
1. Two conditions need to be true at once — combine them with `AND`.
2. Sort the result by `employee_id`.

## Code
```sql
SELECT name
FROM Employee
WHERE salary > 2000
  AND months < 10
ORDER BY employee_id;
```

## Walkthrough
- `WHERE salary > 2000 AND months < 10` keeps only employees who satisfy
  both conditions — high pay *and* short tenure.
- `ORDER BY` runs after filtering, so it only sorts the employees who made
  it past the `WHERE` clause, not the whole table.
