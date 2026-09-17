# 13. Contest Leaderboard

[HackerRank link](https://www.hackerrank.com/challenges/contest-leaderboard/problem)

## What it's asking
Two tables: `Hackers` (hacker_id, name) and `Submissions` (submission_id,
hacker_id, challenge_id, score). A hacker's *total score* is the sum of
their **best** score on each challenge (not every submission — if they
tried a challenge five times, only their highest score for it counts
once). Print `hacker_id`, `name`, and total score, ordered by score
(descending), breaking ties by `hacker_id` ascending. Leave out hackers
whose total score is 0.

**Hackers table**
| Column | Type |
|---|---|
| hacker_id | Integer |
| name | String |

**Submissions table**
| Column | Type |
|---|---|
| submission_id | Integer |
| hacker_id | Integer |
| challenge_id | Integer |
| score | Integer |

## Steps
1. First, find each hacker's *best* score per challenge — group
   `Submissions` by `hacker_id` and `challenge_id`, and take `MAX(score)`
   in each group. This is a smaller, intermediate result — build it as a
   subquery.
2. Join that intermediate result to `Hackers`, then sum up each hacker's
   best-per-challenge scores to get their total.
3. Exclude totals of 0, and sort.

## Code
```sql
SELECT h.hacker_id, h.name, SUM(best.score) AS total_score
FROM Hackers h
JOIN (
    SELECT hacker_id, challenge_id, MAX(score) AS score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
) best ON h.hacker_id = best.hacker_id
GROUP BY h.hacker_id, h.name
HAVING total_score > 0
ORDER BY total_score DESC, h.hacker_id ASC;
```

## Walkthrough
- The subquery in parentheses is a **derived table** — a query used in
  place of a table name, giving you an intermediate result to build on.
  Here it computes "each hacker's best score per challenge" *before*
  anything gets summed.
- This two-step structure matters: if you summed every submission
  directly, a hacker who resubmitted the same challenge many times would
  get counted many times over. Reducing to one best-score-per-challenge
  row first, then summing, avoids that.
- `JOIN (...) best ON h.hacker_id = best.hacker_id` treats that derived
  table exactly like a regular table — you can join to it, alias it
  (`best`), and reference its columns the normal way.
- `HAVING total_score > 0` filters on the summed value, which is why it
  has to be `HAVING` and not `WHERE` — the total doesn't exist until after
  grouping.
