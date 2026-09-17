SELECT
  CASE WHEN g.grade < 8 THEN NULL ELSE s.Name END AS Name,
  g.grade,
  s.Marks
FROM Students s
JOIN Grades g ON s.Marks BETWEEN g.min_mark AND g.max_mark
ORDER BY
  g.grade DESC,
  CASE WHEN g.grade < 8 THEN s.Marks END ASC,
  CASE WHEN g.grade >= 8 THEN s.Name END ASC;
