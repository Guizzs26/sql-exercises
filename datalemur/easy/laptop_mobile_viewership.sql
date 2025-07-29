-- Problem: Unfinished Parts
-- NY Times Interview Question
-- Difficulty: Easy
-- Link: https://datalemur.com/questions/laptop-mobile-viewership

-- Solution 1 - Using CASE WHEN with COUNT

SELECT
  COUNT(CASE WHEN device_type = 'laptop' THEN 1 ELSE NULL END) AS laptop_views,
  COUNT(CASE WHEN device_type IN ('phone', 'tablet') THEN 1 ELSE NULL END) AS mobile_views
FROM viewership;

-- Solution 2 - Using CASE WHEN with SUM
SELECT
  SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
  SUM(CASE WHEN device_type IN ('phone', 'tablet') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership;

-- In my opinion, using SUM with CASE WHEN is more readable than using COUNT with CASE WHEN.

-- Solution 3 - Using COUNT with FILTER
SELECT
  COUNT(*) FILTER (WHERE device_type = 'laptop') AS laptop_views,
  COUNT(*) FILTER (WHERE device_type IN ('phone', 'tablet')) AS mobile_views
FROM viewership;  

-- !!! PostgreSQL 9.4+ is required for the FILTER clause (specif postgresql syntax).

