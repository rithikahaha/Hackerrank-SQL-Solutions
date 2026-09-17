# 07. Weather Observation Station 1

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-1/problem)

## What it's asking
A new table, `STATION`, shows up starting here. Print the `CITY` and
`STATE` columns for every row.

**STATION table**
| Column | Type |
|---|---|
| ID | NUMBER |
| CITY | VARCHAR2(21) |
| STATE | VARCHAR2(2) |
| LAT_N | NUMBER |
| LONG_W | NUMBER |

## Steps
1. You want two specific columns, not all of them and not just one.
2. List both column names after `SELECT`, separated by a comma.

## Code
```sql
SELECT CITY, STATE
FROM STATION;
```

## Walkthrough
- Separating column names with a comma is how you ask for more than one
  column but not the whole table.
- No `WHERE` clause means every row from `STATION` is included.
