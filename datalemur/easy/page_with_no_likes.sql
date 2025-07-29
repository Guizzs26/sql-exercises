-- Problem: Page With No Likes
-- Facebook Interview Question
-- Difficulty: Easy
-- Link: https://datalemur.com/questions/sql-page-with-no-likes

-- Solution 1 - Using LEFT JOIN and IS NULL
SELECT p.page_id
FROM pages p 
LEFT OUTER JOIN page_likes pl ON pl.page_id = p.page_id
WHERE pl.page_id IS NULL
ORDER BY p.page_id;

-- Solution 2 - Using EXCEPT
SELECT page_id
FROM pages
EXCEPT
SELECT page_id
FROM page_likes
ORDER BY page_id;

-- Very performant solution, but not supported by all SQL databases.

-- Solution 3 - Using NOT EXISTS
SELECT p.page_id
FROM pages p 
WHERE NOT EXISTS (
  SELECT page_id
  FROM page_likes pl 
  WHERE pl.page_id = p.page_id
)
ORDER BY p.page_id;

-- More easy to undestand the null results (NOT EXISTS expects no rows to match).

-- Solution 4 - Using NOT IN
SELECT p.page_id
FROM pages p 
WHERE p.page_id NOT IN (
  SELECT pl.page_id
  FROM page_likes pl
  WHERE pl.page_id IS NOT NULL
)
ORDER BY p.page_id;

-- Be careful: If the subquery in NOT IN returns any NULL values, the entire NOT IN condition will not match any rows,
-- because SQL treats comparisons with NULL as unknown. This can lead to unexpected results, such as returning zero rows.
-- To avoid this, always filter out NULLs in the subquery (as shown above with WHERE pl.page_id IS NOT NULL).