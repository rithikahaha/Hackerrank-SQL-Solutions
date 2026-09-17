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
