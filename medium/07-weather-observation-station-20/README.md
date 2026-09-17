# 07. Weather Observation Station 20

[HackerRank link](https://www.hackerrank.com/challenges/weather-observation-station-20/problem)

## What it's asking
Print the **median** of all `LAT_N` values in `STATION`, rounded to 4
decimal places. The median is the middle value once everything is sorted
— if there's an odd number of values, it's the exact middle one; if
there's an even number, it's the average of the two middle ones.

## Steps
1. There's no built-in `MEDIAN()` function in MySQL, so you have to find
   the middle value yourself.
2. Sort all the `LAT_N` values and give each one a position number using
   `ROW_NUMBER()`, the same window function from the Occupations pivot —
   just without `PARTITION BY`, since there's nothing to group by first.
3. Also work out how many rows there are in total, so you know which
   position (or positions) count as "the middle."
4. Keep only the row(s) at the middle position(s), and average them —
   this handles the odd/even cases in one shot.

## Code
```sql
SELECT ROUND(AVG(LAT_N), 4)
FROM (
  SELECT LAT_N,
         ROW_NUMBER() OVER (ORDER BY LAT_N) AS row_num,
         COUNT(*) OVER () AS total
  FROM STATION
) ranked
WHERE row_num IN (FLOOR((total + 1) / 2), FLOOR((total + 2) / 2));
```

## Walkthrough
- `ROW_NUMBER() OVER (ORDER BY LAT_N)` numbers every row 1, 2, 3... in
  sorted order — this is what lets you talk about "the middle row" at
  all.
- `COUNT(*) OVER ()` is another window function, but with nothing inside
  the parentheses — that means "count all rows, without partitioning or
  filtering." Every row gets the same `total` value: the size of the
  whole table.
- The two middle positions are `FLOOR((total + 1) / 2)` and
  `FLOOR((total + 2) / 2)`. If `total` is odd, both formulas land on the
  exact same number — the single middle row. If `total` is even, they
  land on the two rows on either side of the middle.
- `WHERE row_num IN (...)` keeps just those one or two rows, and
  `AVG(LAT_N)` averages them — for the odd case that's just averaging one
  number with itself (which does nothing), and for the even case it's the
  proper "average the two middle values" median calculation.
