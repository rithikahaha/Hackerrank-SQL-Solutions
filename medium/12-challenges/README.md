# 12. Challenges

[HackerRank link](https://www.hackerrank.com/challenges/challenges/problem)

## What it's asking
Two tables: `Hackers` (hacker_id, name) and `Challenges` (challenge_id,
hacker_id — who created it). For each hacker, print their `hacker_id`,
`name`, and how many challenges they created. Sort by that count
(descending), breaking ties by `hacker_id`.

There's one extra rule: if two or more hackers created the *same* number
of challenges, **and** that number isn't the overall maximum, drop those
hackers from the results entirely. (Hackers tied *at* the maximum are
still kept.)

**Hackers table**
| Column | Type |
|---|---|
| hacker_id | Integer |
| name | String |

**Challenges table**
| Column | Type |
|---|---|
| challenge_id | Integer |
| hacker_id | Integer |

## Steps
1. Join the two tables and count challenges per hacker, same shape as
   "Top Earners."
2. You need two extra pieces of information to apply the exclusion rule:
   the single highest challenge count anywhere, and which counts are
   "tied" (shared by more than one hacker).
3. Keep a hacker's row if *either*: their count equals the overall
   maximum, *or* their count is unique (no one else has that exact
   count).

## Code
```sql
SELECT h.hacker_id, h.name, COUNT(*) AS challenges_created
FROM Hackers h
JOIN Challenges c ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id, h.name
HAVING challenges_created = (
    SELECT MAX(cnt)
    FROM (SELECT COUNT(*) AS cnt FROM Challenges GROUP BY hacker_id) counts
)
OR challenges_created IN (
    SELECT cnt
    FROM (SELECT COUNT(*) AS cnt FROM Challenges GROUP BY hacker_id) counts
    GROUP BY cnt
    HAVING COUNT(*) = 1
)
ORDER BY challenges_created DESC, h.hacker_id;
```

## Walkthrough
- `GROUP BY h.hacker_id, h.name` plus `COUNT(*)` gives one row per hacker
  with their total challenge count — same pattern as "Top Earners" and
  "Contest Leaderboard."
- `HAVING` filters *after* grouping (unlike `WHERE`, which filters before)
  — you need `HAVING` here because the condition depends on
  `challenges_created`, a value that only exists once the grouping is
  done.
- The first subquery — `SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM
  Challenges GROUP BY hacker_id) counts` — first counts challenges per
  hacker (inner), then takes the biggest of those counts (outer). This
  finds the single highest challenge count in the whole table.
- The second subquery does something similar, but instead groups those
  per-hacker counts by their value and keeps only the ones that occur
  exactly once (`HAVING COUNT(*) = 1`) — in other words, counts that no
  two hackers share.
- A hacker's row survives if their count matches the overall max, *or* if
  their count shows up in that "counts nobody shares" list — which is
  exactly the rule described in the problem.
