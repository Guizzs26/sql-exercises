-- Problem: Average Post Hiatus (Part 1)
-- Facebook Interview Question
-- Difficulty: Easy
-- Link: https://datalemur.com/questions/sql-average-post-hiatus-1

-- Solution 1 - Using HAVING, MIN, MAX
SELECT
  user_id,
  MAX(post_date::DATE) - MIN(post_date::DATE) AS days_between
FROM posts
WHERE post_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY user_id
HAVING COUNT(post_id) >= 2;

-- Solution 2 - Extracting day in select clause
SELECT 
  user_id, 
  EXTRACT(DAY FROM (MAX(post_date) - MIN(post_date))) AS "days_between"
FROM posts
WHERE post_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY user_id
HAVING count(post_id) > 1;

-- Solution 3 - Using CTE
WITH posts_2021 AS (
  SELECT *
  FROM posts
  WHERE EXTRACT(YEAR FROM post_date) = 2021
),
user_post_dates AS (
  SELECT 
    user_id,
    MIN(post_date::DATE) AS first_post_date,
    MAX(post_date::DATE) AS last_post_date
  FROM posts_2021
  GROUP BY user_id
  HAVING COUNT(*) >= 2
)
SELECT 
  user_id,
  (last_post_date - first_post_date) AS days_between
FROM user_post_dates;