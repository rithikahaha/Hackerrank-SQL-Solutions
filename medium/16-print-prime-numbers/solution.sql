WITH RECURSIVE numbers AS (
  SELECT 2 AS n
  UNION ALL
  SELECT n + 1 FROM numbers WHERE n < 1000
),
primes AS (
  SELECT n
  FROM numbers a
  WHERE NOT EXISTS (
    SELECT 1 FROM numbers b
    WHERE b.n BETWEEN 2 AND SQRT(a.n)
      AND a.n % b.n = 0
  )
)
SELECT GROUP_CONCAT(n ORDER BY n SEPARATOR '&')
FROM primes;
