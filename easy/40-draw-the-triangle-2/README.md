# 40. Draw The Triangle 2

[HackerRank link](https://www.hackerrank.com/challenges/draw-the-triangle-2/problem)

## What it's asking
The mirror image of the last problem: print 20 rows of stars, but
*growing* by one star each row instead of shrinking.

```
*
* *
* * *
...
* * * * * * * * * * * * * * * * * * * *
```

The top row has 1 star, the last row has 20.

## Steps
1. Same recursive CTE idea as "Draw The Triangle 1," but counting *up*
   from 1 to 20 instead of down.
2. Print each row the same way — `n` stars separated by spaces.
3. Order so 1 comes first and 20 comes last.

## Code
```sql
WITH RECURSIVE rows AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM rows WHERE n < 20
)
SELECT REPEAT('* ', n)
FROM rows
ORDER BY n ASC;
```

## Walkthrough
- This is "Draw The Triangle 1" with the counting direction flipped: start
  at `1`, add `1` each step, stop once `n` reaches `20`.
- `REPEAT('* ', n)` and the final `ORDER BY` work exactly the same as
  before — the only real change from the last problem is which direction
  the numbers (and therefore the rows) count.
