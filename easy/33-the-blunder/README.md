# 33. The Blunder

[HackerRank link](https://www.hackerrank.com/challenges/the-blunder/problem)

## What it's asking
Samantha tried to calculate the average monthly salary in the `EMPLOYEES`
table, but her keyboard's `0` key was broken — so every salary she typed
had its zeros missing (e.g. `10050` came out as `1 5`... well, `1005`
minus its zeros). Find the difference between the **correct** average
salary and her **broken** average (actual − miscalculated), rounded *up*
to the next whole number.

**EMPLOYEES table** — the column we need:
| Column | Type |
|---|---|
| SALARY | Integer |

## Steps
1. The correct average is just `AVG(SALARY)`.
2. To recreate Samantha's mistake, strip every `0` out of each salary
   before averaging it — `REPLACE(SALARY, '0', '')` does that.
3. Subtract the broken average from the real one.
4. Round the result *up* with `CEIL()` (the opposite of `FLOOR`).

## Code
```sql
SELECT CEIL(AVG(SALARY) - AVG(REPLACE(SALARY, '0', '')))
FROM EMPLOYEES;
```

## Walkthrough
- `REPLACE(text, old, new)` swaps every occurrence of `old` with `new`
  inside `text`. `REPLACE(SALARY, '0', '')` removes every `0` character by
  replacing it with nothing.
- `AVG(REPLACE(SALARY, '0', ''))` rebuilds Samantha's mistake: it averages
  the "zeros removed" version of every salary, exactly like her broken
  keyboard would have produced.
- `CEIL(number)` rounds *up* to the next whole number, no matter how small
  the decimal part is — `4.01` becomes `5`. It's the mirror image of
  `FLOOR`, which you used in "Average Population."
