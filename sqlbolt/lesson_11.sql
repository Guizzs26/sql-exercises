-- SQL Lesson 11: Queries with aggregates (Pt. 2)

-- 1. Find the number of Artists in the studio (without a HAVING clause)
SELECT
  COUNT(role) AS total_artists
FROM
  employees
WHERE 
  role = "Artist";
  
-- 2. Find the number of Employees of each role in the studio
SELECT
  role,
  COUNT(role) AS employees_at_each_role
FROM
  employees
GROUP BY  
  role;

-- 3. Find the total number of years employed by all Engineers
SELECT
  role,
  SUM(years_employed) AS employees_at_each_role
FROM
  employees
WHERE
  role = "Engineer"
GROUP BY 
  role;

-- Ou

SELECT role, SUM(years_employed)
FROM employees
GROUP BY role
HAVING role = "Engineer";