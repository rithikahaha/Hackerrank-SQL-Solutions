# 14. Top Competitors

[HackerRank link](https://www.hackerrank.com/challenges/full-score/problem)

## What it's asking
Four tables: `Hackers` (hacker_id, name), `Difficulty` (difficulty_level,
score — the max possible score at that level), `Challenges`
(challenge_id, hacker_id, difficulty_level), and `Submissions`
(submission_id, hacker_id, challenge_id, score). Print the `hacker_id` and
`name` of every hacker who scored a **perfect score** (matching the
challenge's max possible score) on **more than one** challenge. Order by
how many perfect scores they got (descending), breaking ties by
`hacker_id`.

## Steps
1. Chain the four tables together: a submission belongs to a challenge,
   a challenge has a difficulty level, and a difficulty level has a max
   score — you need all of that lined up to know whether a given
   submission was "perfect."
2. Keep only rows where the submission's score equals that challenge's
   max score.
3. Group by hacker and count how many perfect scores they have.
4. Keep only hackers with more than one, and sort.

## Code
```sql
SELECT h.hacker_id, h.name
FROM Hackers h
JOIN Submissions s ON h.hacker_id = s.hacker_id
JOIN Challenges c ON s.challenge_id = c.challenge_id
JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
WHERE s.score = d.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, h.hacker_id ASC;
```

## Walkthrough
- Four joins in a row just means following the chain one link at a time:
  submission → its challenge → that challenge's difficulty → that
  difficulty's max score. Each `JOIN ... ON` attaches the next piece.
- `WHERE s.score = d.score` is the "was this a perfect score?" check —
  comparing the actual submission score against the max score for that
  challenge's difficulty.
- `HAVING COUNT(*) > 1` is the same "filter after grouping" idea from
  "Challenges" and "Contest Leaderboard" — here it's enforcing "more than
  one perfect score," which can only be checked once the rows are grouped
  per hacker.
- By this point, four-table joins plus `GROUP BY`/`HAVING` should be
  starting to feel like a repeatable recipe rather than four separate new
  ideas — that's the pattern most "medium" SQL problems boil down to.
