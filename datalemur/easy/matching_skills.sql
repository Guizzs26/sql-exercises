-- Problem: Matching Skills
-- LinkedIn Interview Question
-- Difficulty: Easy
-- Link: https://datalemur.com/questions/matching-skills

-- Solution 1 - Using IN and HAVING operators

SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id; -- or candidate_id ASC

-- The question makes it clear that we do not have repeated records (candidate_id - skill pairs), 
-- so in this case it's not necessary to use COUNT(DISTINCT skill).

-- Solution 2 - Using subquery

SELECT c.candidate_id
FROM (
  SELECT 
    candidate_id,
    COUNT(skill) AS skill_count
  FROM candidates
  WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
  GROUP BY candidate_id
) AS c
WHERE c.skill_count = 3
ORDER BY candidate_id; 

-- Solution 3 - Using INTERSECT operator

SELECT candidate_id FROM candidates WHERE skill = 'Python'
INTERSECT
SELECT candidate_id FROM candidates WHERE skill = 'Tableau'
INTERSECT
SELECT candidate_id FROM candidates WHERE skill = 'PostgreSQL'
ORDER BY candidate_id;

-- Solution 4 - Using CASE

SELECT candidate_id
FROM candidates
GROUP BY candidate_id
HAVING COUNT(CASE WHEN skill IN ('Python', 'Tableau', 'PostgreSQL') THEN 1 ELSE NULL END) = 3
ORDER BY candidate_id;

-- Solution 5 - Using CTE

WITH skill_count AS (
  SELECT 
    candidate_id,
    SUM(CASE WHEN skill = 'Python' THEN 1 ELSE 0 END) AS python_count,
    SUM(CASE WHEN skill = 'Tableau' THEN 1 ELSE 0 END) AS tableau_count,
    SUM(CASE WHEN skill = 'PostgreSQL' THEN 1 ELSE 0 END) AS postgres_count
  FROM candidates
  GROUP BY candidate_id
)
SELECT candidate_id
FROM skill_count
WHERE python_count + tableau_count + postgres_count = 3
ORDER BY candidate_id;