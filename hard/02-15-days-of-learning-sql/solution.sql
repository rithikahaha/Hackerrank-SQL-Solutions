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
