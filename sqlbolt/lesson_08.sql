-- SQL Lesson 8: A short note on NULLs 

-- 1. Find the name and role of all employees who have not been assigned to a building
SELECT
  name,
  role
FROM  
  employees
WHERE building IS NULL;

-- 2. Find the names of the buildings that hold no employees
SELECT  
  bld.building_name
FROM  
  buildings AS bld
LEFT JOIN
  employees AS emp ON bld.building_name = emp.building
WHERE
  emp.name IS NULL;