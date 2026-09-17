# 23. Japan Population

[HackerRank link](https://www.hackerrank.com/challenges/japan-population/problem)

## What it's asking
Print the sum of the populations of all Japanese cities in `CITY`. Japan's
`COUNTRYCODE` is `'JPN'`.

## Steps
1. Filter to Japanese cities with `WHERE COUNTRYCODE = 'JPN'`.
2. Add up their populations with `SUM(POPULATION)`.

## Code
```sql
SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = 'JPN';
```

## Walkthrough
- Nothing new here — it's the same filter you used back in "Japanese
  Cities' Attributes," combined with the `SUM` you just practiced.
- This is a good sign you're starting to recognize the pieces: once you
  know `WHERE` and `SUM` separately, combining them for a new question is
  mostly about spotting which pattern applies.
