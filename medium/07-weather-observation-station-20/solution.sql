SELECT ROUND(AVG(LAT_N), 4)
FROM (
  SELECT LAT_N,
         ROW_NUMBER() OVER (ORDER BY LAT_N) AS row_num,
         COUNT(*) OVER () AS total
  FROM STATION
) ranked
WHERE row_num IN (FLOOR((total + 1) / 2), FLOOR((total + 2) / 2));
