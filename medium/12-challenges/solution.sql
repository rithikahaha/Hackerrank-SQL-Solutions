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
