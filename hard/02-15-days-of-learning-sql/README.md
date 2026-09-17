# 02. 15 Days of Learning SQL

[HackerRank link](https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem)

## What it's asking
Julia ran a 15-day contest, March 1–15, 2016. Two tables: `Hackers`
(hacker_id, name) and `Submissions` (submission_date, submission_id,
hacker_id, score). For **every day of the contest**, print:
1. the date,
2. how many hackers have submitted **at least once on every single day**
   so far, from day 1 up through this day (a hacker who skipped even one
   earlier day doesn't count, even if they're active today),
3. the `hacker_id` of whoever submitted the **most times that specific
   day** (lowest `hacker_id` breaks a tie), and
4. that hacker's name.

Sorted by date.

**Hackers table**
| Column | Type |
|---|---|
| hacker_id | Integer |
| name | String |

**Submissions table**
| Column | Type |
|---|---|
| submission_date | Date |
| submission_id | Integer |
| hacker_id | Integer |
| score | Integer |

## Steps
This problem is really two separate questions, answered once per day, then
joined together:

**Part A — the "submitted every day so far" streak count:**
1. For a given day `d`, a hacker qualifies if the number of *distinct*
   days they've submitted on, counting only days up to and including `d`,
   equals `d`'s position in the contest (day 1, day 2, ... day 15).
   `DATEDIFF(d, '2016-03-01') + 1` gives that position number.
2. Count how many hackers meet that bar, for each day — this needs a
   subquery that reruns per day, similar in spirit to the correlated
   subqueries from "Ollivander's Inventory."

**Part B — the top submitter of each individual day:**
1. Count each hacker's submissions *per day* (not cumulative — just that
   day).
2. Rank hackers within each day by submission count (highest first), with
   `hacker_id` breaking ties — this is `ROW_NUMBER() OVER (PARTITION BY
   ... ORDER BY ...)`, the same window function pattern from "Occupations"
   and "Weather Observation Station 20."
3. Keep only rank 1 per day.

**Then:** join Part A and Part B together by date, and pull in the
hacker's name.

## Code
```sql
WITH streak AS (
  SELECT s1.submission_date,
    (SELECT COUNT(*)
     FROM (
       SELECT hacker_id
       FROM Submissions s2
       WHERE s2.submission_date <= s1.submission_date
       GROUP BY hacker_id
       HAVING COUNT(DISTINCT s2.submission_date)
              = DATEDIFF(s1.submission_date, '2016-03-01') + 1
     ) qualifying_hackers
    ) AS unique_hackers
  FROM (SELECT DISTINCT submission_date FROM Submissions) s1
),
top_hacker AS (
  SELECT submission_date, hacker_id,
         ROW_NUMBER() OVER (
           PARTITION BY submission_date
           ORDER BY COUNT(*) DESC, hacker_id ASC
         ) AS rn
  FROM Submissions
  GROUP BY submission_date, hacker_id
)
SELECT st.submission_date, st.unique_hackers, th.hacker_id, h.name
FROM streak st
JOIN top_hacker th ON st.submission_date = th.submission_date AND th.rn = 1
JOIN Hackers h ON h.hacker_id = th.hacker_id
ORDER BY st.submission_date;
```

## Walkthrough
- **The `streak` block** answers "how many hackers have a perfect
  streak through this day?" one day at a time. For each day `s1`, the
  inner subquery looks at every submission up to and including that day
  (`s2.submission_date <= s1.submission_date`), groups by hacker, and
  counts each hacker's *distinct* submission days in that range
  (`COUNT(DISTINCT s2.submission_date)`). If that count matches the day's
  position in the contest — day 5 means "5 distinct days out of the 5
  possible so far" — the hacker has submitted every day without a gap.
  `DATEDIFF(s1.submission_date, '2016-03-01') + 1` turns a calendar date
  into that day-position number (day 1, day 2, ...).
- **The `top_hacker` block** is more familiar: group submissions by day
  and hacker to get each hacker's daily count, then use `ROW_NUMBER() OVER
  (PARTITION BY submission_date ORDER BY COUNT(*) DESC, hacker_id ASC)` to
  rank hackers within each day — highest count first, lowest `hacker_id`
  breaking ties. Filtering to `rn = 1` keeps just the top hacker per day,
  the same ranking trick used for the continent-average and median
  problems earlier, just applied per day instead of globally.
- **The final `SELECT`** joins these two independently-computed pieces
  back together by date, then joins `Hackers` once more just to look up
  the winning hacker's name.
- This problem doesn't introduce any single new idea — it combines
  several you've already used (correlated subqueries, `COUNT(DISTINCT
  ...)`, window-function ranking, multiple CTEs chained together) into one
  query. If it feels like a lot, that's expected — this is one of the
  hardest problems on HackerRank's SQL track. Reading each CTE (`streak`,
  `top_hacker`) as its own small, independent problem — and only then
  seeing how they're stitched together — is the way to make sense of it.
