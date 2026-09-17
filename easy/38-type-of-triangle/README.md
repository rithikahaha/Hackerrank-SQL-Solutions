# 38. Type of Triangle

[HackerRank link](https://www.hackerrank.com/challenges/what-type-of-triangle/problem)

## What it's asking
The `TRIANGLES` table has three columns — `A`, `B`, `C` — the three side
lengths of a triangle. For every row, print one label:
- **Equilateral** — all 3 sides equal
- **Isosceles** — exactly 2 sides equal
- **Scalene** — all 3 sides different
- **Not A Triangle** — the three lengths can't actually form a triangle

**TRIANGLES table**
| Column | Type |
|---|---|
| A | Integer |
| B | Integer |
| C | Integer |

## Steps
1. First, rule out the impossible case: three lengths only form a real
   triangle if each side is shorter than the sum of the other two. If any
   side is greater than or equal to the sum of the other two, it's "Not A
   Triangle" — check this *first*, before anything else.
2. If it is a real triangle, check for all three sides equal →
   Equilateral.
3. Otherwise, check if any two sides are equal → Isosceles.
4. If none of the above, it's Scalene.
5. Since you're picking one label out of several conditions, use a `CASE
   WHEN` expression — SQL's version of if/else if/else.

## Code
```sql
SELECT CASE
  WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
  WHEN A = B AND B = C THEN 'Equilateral'
  WHEN A = B OR B = C OR A = C THEN 'Isosceles'
  ELSE 'Scalene'
END
FROM TRIANGLES;
```

## Walkthrough
- `CASE WHEN condition1 THEN result1 WHEN condition2 THEN result2 ... ELSE
  fallback END` checks each `WHEN` in order, top to bottom, and uses the
  result of the *first* one that matches. If none match, it falls back to
  `ELSE`.
- Order matters here: the "Not A Triangle" check has to come first,
  because a set of sides that can't form a triangle might still
  accidentally look "equal" or "different" — you want to rule it out
  before asking what *kind* of triangle it is.
- `A + B <= C` (and the same check for the other two pairings) is the
  standard rule for "can these three lengths form a triangle" — each side
  must be strictly less than the sum of the other two.
