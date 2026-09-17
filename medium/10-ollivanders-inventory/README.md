# 10. Ollivander's Inventory

[HackerRank link](https://www.hackerrank.com/challenges/harry-potter-and-wands/problem)

## What it's asking
Two tables: `Wands` (id, code, coins_needed, power) and `Wands_Property`
(code, age, is_evil). For every combination of `age` and `power`, find the
**cheapest non-evil wand**. Print that wand's `id`, `age`, `coins_needed`,
and `power`, sorted by power (highest first), and by age (highest first)
for ties.

**Wands table**
| Column | Type |
|---|---|
| id | Integer |
| code | Integer |
| coins_needed | Integer |
| power | Integer |

**Wands_Property table**
| Column | Type |
|---|---|
| code | Integer |
| age | Integer |
| is_evil | Integer (0 = not evil) |

## Steps
1. Join the two tables on `code`, so each wand has its `age` and
   `is_evil` attached.
2. Filter out evil wands with `WHERE is_evil = 0`.
3. For each wand, you need to know: "is this the *cheapest* wand among all
   non-evil wands that share this exact age and power?" That's a
   **correlated subquery** — a subquery that looks back at the outer
   row's `age` and `power` to compute a comparison value just for that
   group.
4. Keep the wand only if its price matches that cheapest price.

## Code
```sql
SELECT w.id, wp.age, w.coins_needed, w.power
FROM Wands w
JOIN Wands_Property wp ON w.code = wp.code
WHERE wp.is_evil = 0
  AND w.coins_needed = (
    SELECT MIN(w2.coins_needed)
    FROM Wands w2
    JOIN Wands_Property wp2 ON w2.code = wp2.code
    WHERE wp2.age = wp.age
      AND w2.power = w.power
      AND wp2.is_evil = 0
  )
ORDER BY w.power DESC, wp.age DESC;
```

## Walkthrough
- This is a step up from the subqueries you saw in "Weather Observation
  Station 15" — those subqueries ran once, independently. This one is
  **correlated**: it references `wp.age` and `w.power` from the *outer*
  query, so it effectively re-runs once per outer row, each time asking
  "what's the cheapest non-evil wand for this specific age and power?"
- `w.coins_needed = (that subquery)` keeps only the wand(s) whose price
  matches the cheapest price for their own age/power group — the same
  "compare against a computed minimum" idea as station 15, just recomputed
  per group instead of once for the whole table.
- Note the subquery re-joins `Wands` to `Wands_Property` again (as `w2`
  and `wp2`) — it needs its own independent view of the data to search
  through, separate from the outer query's `w` and `wp`.
