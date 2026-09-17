# 16. Print Prime Numbers

[HackerRank link](https://www.hackerrank.com/challenges/print-prime-numbers/problem)

## What it's asking
Print every prime number from 2 up to 1000, all on a single line,
separated by `&` instead of spaces or commas — e.g. for primes up to 10:
`2&3&5&7`.

## Steps
There's no `Numbers` table to select from here — you have to *generate*
the numbers 2 through 1000 yourself, then test each one for primality,
then glue the results into one line.

1. Build the list of candidate numbers 2–1000 using a **recursive CTE** —
   a query that generates its own rows by repeatedly referencing itself,
   starting from a base case and counting up.
2. For each candidate `n`, check whether any number from 2 up to `√n`
   divides it evenly. If nothing does, `n` is prime (this is the standard
   trial-division primality test — you only need to check up to the
   square root, since any factor larger than that would have a matching
   factor smaller than it).
3. Combine all the surviving primes into a single `&`-separated string
   with `GROUP_CONCAT`.

## Code
```sql
WITH RECURSIVE numbers AS (
  SELECT 2 AS n
  UNION ALL
  SELECT n + 1 FROM numbers WHERE n < 1000
),
primes AS (
  SELECT n
  FROM numbers a
  WHERE NOT EXISTS (
    SELECT 1 FROM numbers b
    WHERE b.n BETWEEN 2 AND SQRT(a.n)
      AND a.n % b.n = 0
  )
)
SELECT GROUP_CONCAT(n ORDER BY n SEPARATOR '&')
FROM primes;
```

## Walkthrough
- `WITH RECURSIVE numbers AS (...)` defines a **recursive CTE** (Common
  Table Expression) — a named, temporary result you can reference like a
  table for the rest of the query. The recursive part has two halves
  joined by `UNION ALL`: a starting point (`SELECT 2 AS n`) and a rule for
  generating the next row from the previous one (`SELECT n + 1 FROM
  numbers WHERE n < 1000`). The database repeats the second half over and
  over — each pass adds one more row, using the row it just generated as
  the new "previous" value — until the `WHERE n < 1000` stops matching.
  This is how you build a 2-to-1000 list without a table to draw from.
- `NOT EXISTS (SELECT 1 FROM numbers b WHERE b.n BETWEEN 2 AND SQRT(a.n)
  AND a.n % b.n = 0)` is the primality check: "there is no number `b`
  between 2 and the square root of `a.n` that divides `a.n` evenly."
  `a.n % b.n = 0` is the remainder check — a remainder of 0 means `b.n`
  divides evenly, so `a.n` isn't prime. If the subquery finds *no* such
  divisor, `a.n` survives as a prime — the same `NOT EXISTS` pattern from
  "SQL Project Planning," just checking a different condition.
- `GROUP_CONCAT(column ORDER BY column SEPARATOR '&')` is like `SUM()` or
  `COUNT()`, but for combining text: instead of collapsing many rows into
  one number, it collapses many rows into one string, in the given order,
  glued together with the given separator.
- This problem is a good one to come back to later — recursive CTEs are a
  genuinely advanced tool, and this pattern (generate numbers, then filter
  with a self-referencing `NOT EXISTS` check) is worth re-reading once the
  rest of this list feels comfortable.
