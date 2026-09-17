# 34. Top Earners

[HackerRank link](https://www.hackerrank.com/challenges/earnings-of-employees/problem)

## What it's asking
Each employee's *total earnings* is `salary × months` worked. Find the
**highest** total earnings value in the `Employee` table, and **how many
employees** share that highest value. Print both numbers, separated by a
space.

## Steps
1. Work out each employee's earnings: `salary * months`.
2. Group employees by that earnings value, so you can count how many
   people land on each one — `GROUP BY salary * months`.
3. Sort the groups so the highest earnings value comes first:
   `ORDER BY earnings DESC`.
4. Keep only the top group with `LIMIT 1` — that's the highest value, and
   `COUNT(*)` within that group tells you how many employees share it.

## Code
```sql
SELECT salary * months AS earnings, COUNT(*)
FROM Employee
GROUP BY earnings
ORDER BY earnings DESC
LIMIT 1;
```

## Walkthrough
- `salary * months AS earnings` computes each employee's total earnings
  and gives that calculation a name (`earnings`) so the rest of the query
  can refer to it.
- `GROUP BY earnings` buckets every employee into groups that share the
  same earnings value — this is new: instead of one row per employee,
  `COUNT(*)` here counts employees *within each group*.
- `ORDER BY earnings DESC` puts the highest-earning group first, and
  `LIMIT 1` keeps just that one group — giving you the maximum earnings
  value and how many employees are tied for it.
