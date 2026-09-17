# 01. Interviews

[HackerRank link](https://www.hackerrank.com/challenges/interviews/problem)

## What it's asking
Samantha runs coding contests to screen candidates at different colleges.
Five tables describe this: `Contests` (contest_id, hacker_id, name),
`Colleges` (college_id, contest_id), `Challenges` (challenge_id,
college_id), `View_Stats` (challenge_id, total_views, total_unique_views),
and `Submission_Stats` (challenge_id, total_submissions,
total_accepted_submissions).

For each contest, print its `contest_id`, `hacker_id`, `name`, and the
**sum** — across every challenge tied to that contest, through however
many colleges used it — of `total_submissions`,
`total_accepted_submissions`, `total_views`, and `total_unique_views`.
Order by `contest_id`, and leave out any contest where all four totals
come out to 0.

**Contests table**
| Column | Type |
|---|---|
| contest_id | Integer |
| hacker_id | Integer |
| name | String |

**Colleges table**
| Column | Type |
|---|---|
| college_id | Integer |
| contest_id | Integer |

**Challenges table**
| Column | Type |
|---|---|
| challenge_id | Integer |
| college_id | Integer |

**View_Stats / Submission_Stats tables**
| Column | Type |
|---|---|
| challenge_id | Integer |
| total_views / total_submissions | Integer |
| total_unique_views / total_accepted_submissions | Integer |

## Steps
1. Chain the tables the way the data actually connects: a contest can be
   used by several colleges, each college has its own challenges, and
   each challenge has its own view/submission stats. Follow that chain
   with joins: `Contests → Colleges → Challenges → View_Stats` and
   `Contests → Colleges → Challenges → Submission_Stats`.
2. Not every challenge necessarily has a matching row in `View_Stats` or
   `Submission_Stats` (maybe nobody ever viewed or submitted it). A
   regular `JOIN` would silently drop that challenge entirely — use `LEFT
   JOIN` instead, so the challenge stays in the results even when its
   stats are missing.
3. A missing stats row means `NULL` values, and `SUM` needs actual
   numbers to add — wrap each stats column in `COALESCE(column, 0)` to
   treat "missing" as zero before summing.
4. Group by contest and sum the four columns.
5. Drop any contest where all four sums are 0.

## Code
```sql
SELECT
  con.contest_id,
  con.hacker_id,
  con.name,
  SUM(COALESCE(ss.total_submissions, 0)) AS total_submissions,
  SUM(COALESCE(ss.total_accepted_submissions, 0)) AS total_accepted_submissions,
  SUM(COALESCE(vs.total_views, 0)) AS total_views,
  SUM(COALESCE(vs.total_unique_views, 0)) AS total_unique_views
FROM Contests con
JOIN Colleges col ON con.contest_id = col.contest_id
JOIN Challenges ch ON col.college_id = ch.college_id
LEFT JOIN View_Stats vs ON ch.challenge_id = vs.challenge_id
LEFT JOIN Submission_Stats ss ON ch.challenge_id = ss.challenge_id
GROUP BY con.contest_id, con.hacker_id, con.name
HAVING SUM(COALESCE(ss.total_submissions, 0)) != 0
    OR SUM(COALESCE(ss.total_accepted_submissions, 0)) != 0
    OR SUM(COALESCE(vs.total_views, 0)) != 0
    OR SUM(COALESCE(vs.total_unique_views, 0)) != 0
ORDER BY con.contest_id;
```

## Walkthrough
- `LEFT JOIN` keeps every row from the left-hand side (here, every
  challenge that made it through the earlier joins) even when the
  right-hand table has no match — the unmatched columns just come back as
  `NULL`, instead of the row disappearing the way a plain `JOIN` would
  drop it.
- `COALESCE(column, 0)` returns the column's value if it isn't `NULL`, and
  `0` if it is — this is what makes `SUM` behave correctly once `LEFT
  JOIN` starts introducing `NULL`s. Without it, `SUM` would just ignore
  the `NULL`s silently, which happens to give the same *sum*, but the
  `HAVING` check for "all four are 0" needs `COALESCE` to be reliable too.
- The four `JOIN`/`LEFT JOIN` lines are really just the chain from the
  problem statement written out one link at a time — contest to college,
  college to challenge, challenge to each stats table.
- `HAVING ... != 0 OR ... != 0 OR ...` excludes a contest only if *every
  one* of the four totals is zero — if even one of them isn't, the
  contest stays.
