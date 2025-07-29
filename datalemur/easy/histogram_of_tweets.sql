-- Problem: Histogram of Tweets
-- Twitter Interview Question
-- Difficulty: Easy
-- Link: https://datalemur.com/questions/sql-histogram-tweets

-- Solution 1 - Using subquery

SELECT
  tweet_count AS tweet_bucket,
  COUNT(user_id) AS users_num
FROM (
  SELECT
    user_id,
    COUNT(tweet_id) AS tweet_count
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
) AS tweet_count_per_user
GROUP BY tweet_bucket;

-- We can use DATE_PART('year', tweet_date) = 2022 to filter tweets from the year 2022.
-- Or we can use DATE_TRUNC('year', tweet_date) = '2022-01-01' to filter tweets from the year 2022.
-- Or we can use EXTRACT(YEAR FROM tweet_date) = 2022 to filter tweets from the year 2022.

-- Solution 2 - Using CTE

WITH tweet_count_per_user AS (
  SELECT
    user_id,
    COUNT(tweet_id) AS tweet_count
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
)
SELECT 
  tweet_count AS tweet_bucket,
  COUNT(user_id) AS users_num
FROM tweet_count_per_user
GROUP BY tweet_bucket;