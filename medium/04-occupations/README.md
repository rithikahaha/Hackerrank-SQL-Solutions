# 04. Occupations

[HackerRank link](https://www.hackerrank.com/challenges/occupations/problem)

## What it's asking
Same `OCCUPATIONS` table as the last problem. This time, turn it
sideways: instead of one row per person, print **four columns** — Doctor,
Professor, Singer, Actor — with each occupation's names listed
alphabetically underneath it. If one occupation has fewer people than
another, fill the empty spots with `NULL`. This reshaping (rows becoming
columns) is called a **pivot**.

## Steps
1. First, figure out each person's position *within their own
   occupation*, alphabetically — the 1st doctor, 2nd doctor, 1st actor,
   and so on. `ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name)`
   does exactly this.
2. Group everyone by that position number — so all the "1st in their
   occupation" people land in one row, all the "2nd in their occupation"
   people in the next, and so on.
3. Within each group, pull out the name for each occupation using `CASE
   WHEN Occupation = 'Doctor' THEN Name END` wrapped in `MAX()` — if
   nobody in that group is a doctor, this naturally comes out `NULL`.

## Code
```sql
SELECT
  MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
  MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
  MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
  MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
FROM (
  SELECT Name, Occupation,
         ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
  FROM OCCUPATIONS
) ranked
GROUP BY rn
ORDER BY rn;
```

## Walkthrough
- `ROW_NUMBER() OVER (...)` is a **window function** — it numbers rows
  without collapsing them the way `GROUP BY` does. Each row still shows up
  individually, but now has a running count attached to it.
- `PARTITION BY Occupation` tells `ROW_NUMBER()` to restart its counting
  for each occupation separately — so doctors are numbered 1, 2, 3... and
  actors are *also* numbered 1, 2, 3..., independently.
- `ORDER BY Name` (inside the `OVER (...)`) decides what "1st, 2nd, 3rd"
  means — alphabetical order by name within each occupation.
- The inner query (in parentheses) produces one row per person, each
  tagged with their alphabetical rank inside their occupation. The outer
  query then groups by that rank (`GROUP BY rn`), so row 1 collects
  everyone's "1st place" person, row 2 collects everyone's "2nd place"
  person, and so on — this is what actually reshapes rows into columns.
- `MAX(CASE WHEN Occupation = 'Doctor' THEN Name END)` looks inside each
  `rn` group for the doctor's name. Since at most one row in the group can
  be a doctor, `MAX` just picks out that one value — or returns `NULL` if
  there isn't one in that group.
