SELECT s.Name
FROM Students s
JOIN Friends f ON s.ID = f.ID
JOIN Packages p ON s.ID = p.ID
JOIN Packages fp ON f.Friend_ID = fp.ID
WHERE fp.Salary > p.Salary
ORDER BY fp.Salary;
