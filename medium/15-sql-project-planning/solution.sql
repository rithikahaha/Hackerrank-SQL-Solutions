SELECT p1.Start_Date, MIN(p2.End_Date) AS End_Date
FROM Projects p1
JOIN Projects p2 ON p2.End_Date >= p1.Start_Date
WHERE NOT EXISTS (SELECT 1 FROM Projects WHERE End_Date = p1.Start_Date)
  AND NOT EXISTS (SELECT 1 FROM Projects WHERE Start_Date = p2.End_Date)
GROUP BY p1.Start_Date
ORDER BY DATEDIFF(End_Date, p1.Start_Date), p1.Start_Date;
