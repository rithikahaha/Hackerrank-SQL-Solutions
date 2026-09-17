# 02. Symmetric Pairs

[HackerRank link](https://www.hackerrank.com/challenges/symmetric-pairs/problem)

## What it's asking
There's a `Functions` table with columns `X` and `Y`. Two rows — say
`(X1, Y1)` and `(X2, Y2)` — form a **symmetric pair** if `X1 = Y2` and
`X2 = Y1`. In plain terms: the table also contains the *reverse* of that
row somewhere.

Print every such pair once, with the smaller value first (`X <= Y`),
ordered by `X`.

**Functions table**
| Column | Type |
|---|---|
| X | Integer |
| Y | Integer |

## Steps
1. This needs the table compared against *itself* — for each row, check
   whether its mirror image exists somewhere else in the same table. This
   is called a **self-join**: joining a table to another copy of itself.
2. The matching condition is exactly the definition above:
   `f1.X = f2.Y AND f1.Y = f2.X`.
3. A pair and its mirror would both show up (once as `(20, 21)`, once as
   `(21, 20)`) — keep only the version where `X <= Y` so each pair prints
   once, with the smaller value first.
4. A row can also be its own mirror when `X` equals `Y` (like `(20, 20)`)
   — the same join condition naturally covers this case too.

## Code
```sql
SELECT f1.X, f1.Y
FROM Functions f1
JOIN Functions f2 ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.X <= f1.Y
GROUP BY f1.X, f1.Y
ORDER BY f1.X, f1.Y;
```

## Walkthrough
- `FROM Functions f1 JOIN Functions f2 ON ...` joins the table to a second
  copy of itself. `f1` and `f2` are just two names ("aliases") for the
  same table, so the database can compare one row against another without
  getting confused about which is which.
- `f1.X = f2.Y AND f1.Y = f2.X` says: "find some row `f2` that is the
  reverse of row `f1`." If no such row exists, `f1` gets dropped by the
  join entirely — only genuinely mirrored rows survive.
- `WHERE f1.X <= f1.Y` stops each pair from being printed twice (once as
  `(20, 21)` and once as `(21, 20)`) — only the "smaller first" version
  passes.
- `GROUP BY f1.X, f1.Y` is a safety net: if the table happens to contain
  literal duplicate rows, this collapses them down to one line per pair.
