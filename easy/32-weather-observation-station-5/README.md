# 32. Weather Observation Station 5

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-5/problem)

## What it's asking
Find the city in `STATION` with the **shortest** name and the city with
the **longest** name, and print each one along with how many characters
long it is. If there's a tie for shortest or longest, pick whichever name
comes first alphabetically.

## Steps
1. `LENGTH(CITY)` gives you the number of characters in a name.
2. For the shortest city: sort by `LENGTH(CITY)` ascending, and use the
   name as a tiebreaker (`CITY` ascending too), then keep only the first
   row with `LIMIT 1`.
3. For the longest city: same idea, but sort `LENGTH(CITY)` descending —
   still break ties alphabetically.
4. You need *both* rows in one result, so run both queries and stick them
   together with `UNION`.

## Code
```sql
(SELECT CITY, LENGTH(CITY)
 FROM STATION
 ORDER BY LENGTH(CITY) ASC, CITY ASC
 LIMIT 1)
UNION
(SELECT CITY, LENGTH(CITY)
 FROM STATION
 ORDER BY LENGTH(CITY) DESC, CITY ASC
 LIMIT 1);
```

## Walkthrough
- `ORDER BY LENGTH(CITY) ASC, CITY ASC` sorts shortest-name-first; if two
  cities tie on length, the second sort key (`CITY ASC`) breaks the tie
  alphabetically — the same two-column sorting idea from "Higher Than 75
  Marks," just with a different tiebreaker.
- `LIMIT 1` keeps only the top row after sorting — here, the shortest (or
  longest) name.
- `UNION` combines the results of two separate `SELECT` queries into one
  list. Each half is wrapped in parentheses so `ORDER BY`/`LIMIT` apply to
  that half only, not the combined result.
