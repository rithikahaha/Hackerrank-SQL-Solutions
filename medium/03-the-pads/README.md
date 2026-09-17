# 03. The PADS

[HackerRank link](https://www.hackerrank.com/challenges/the-pads/problem)

## What it's asking
There's an `OCCUPATIONS` table with `Name` and `Occupation` (one of
Doctor, Professor, Singer, or Actor). Print **two separate result sets**
in the same query box:

1. Every name, alphabetically, immediately followed by the first letter of
   their occupation in parentheses — e.g. `AmyDoctor(D)`.
2. For each occupation, a sentence like `There are a total of 2 doctors.`
   — count is per occupation, occupation name is lowercase, and the plural
   just adds an `s`. Sort these lines by the count (smallest first); if
   two occupations tie on count, sort those alphabetically by occupation
   name.

**OCCUPATIONS table**
| Column | Type |
|---|---|
| Name | String |
| Occupation | String (Doctor, Professor, Singer, or Actor) |

## Steps
1. For the first list: glue the name and `"(" + first letter + ")"`
   together into one string, then sort by name.
2. For the second list: count rows per occupation, build the sentence
   text, then sort by the count and, for ties, by occupation name.
3. These are two independent queries — write them one after another,
   separated by a semicolon.

## Code
```sql
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')')
FROM OCCUPATIONS
ORDER BY Name;

SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(Occupation), 's.')
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(*), Occupation;
```

## Walkthrough
- `CONCAT(a, b, c, ...)` glues text pieces together into one string —
  here, the name, an opening parenthesis, the first letter, and a closing
  parenthesis.
- `LEFT(Occupation, 1)` grabs just the first character of the occupation —
  the same function used to check a city's first letter back in the
  Weather Observation Station problems, just applied to a different
  column.
- `LOWER(text)` converts text to lowercase — needed because `Occupation`
  is stored as `Doctor`, `Professor`, etc., but the sentence wants
  `doctor`, `professor`.
- `GROUP BY Occupation` buckets rows by occupation so `COUNT(*)` counts
  members of each occupation separately, the same grouping idea from
  "Top Earners" and the continent-average problem.
- Two `SELECT` statements, one after another with a semicolon between
  them, run as two independent queries and print two separate blocks of
  output — this is different from `UNION`, which merges results into a
  single list.
