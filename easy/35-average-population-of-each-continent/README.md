# 35. Average Population of Each Continent

[HackerRank link](https://www.hackerrank.com/challenges/average-population-of-each-continent/problem)

## What it's asking
For every continent, print its name and the **average population** of the
cities on it, rounded down to the nearest whole number.

This is the first problem that needs **two tables**: `CITY` has each
city's population, but the continent it's on is stored in a separate
`COUNTRY` table. They're linked by `CITY.COUNTRYCODE` matching
`COUNTRY.CODE`.

**CITY table (relevant columns)**
| Column | Type |
|---|---|
| COUNTRYCODE | VARCHAR2(3) |
| POPULATION | NUMBER |

**COUNTRY table (relevant columns)**
| Column | Type |
|---|---|
| CODE | VARCHAR2(3) |
| CONTINENT | VARCHAR2(20) |

## Steps
1. You need columns from both tables at once, so `JOIN` them: match every
   `CITY` row to the `COUNTRY` row where the country codes are equal.
2. Group the joined rows by `CONTINENT`, so each continent gets its own
   bucket of cities.
3. Within each group, compute `FLOOR(AVG(CITY.POPULATION))` — same average
   + round-down combo from "Average Population," just applied per group
   instead of to the whole table.

## Code
```sql
SELECT COUNTRY.CONTINENT, FLOOR(AVG(CITY.POPULATION))
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
GROUP BY COUNTRY.CONTINENT;
```

## Walkthrough
- A **join** lets you combine two tables into one result, based on a
  shared value. `JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE` says:
  "for every city, attach the country row whose `CODE` matches that
  city's `COUNTRYCODE`" — now you can use columns from either table as if
  they were one.
- `GROUP BY COUNTRY.CONTINENT` buckets the joined rows by continent, the
  same idea as `GROUP BY earnings` in the Top Earners problem — just
  grouping by a text column instead of a number.
- `FLOOR(AVG(CITY.POPULATION))` runs separately inside each continent's
  bucket, giving one average per continent instead of one for the whole
  table.
- `TABLE.COLUMN` notation (like `CITY.POPULATION`) tells the database
  which table a column comes from — useful once you're joining tables
  that might have similarly-named columns.
