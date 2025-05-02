-- SQL Lesson 7: OUTER JOINs

-- 1. Find the list of all buildings that have employees
SELECT DISTINCT
  bld.building_name
FROM
  buildings AS bld
INNER JOIN  
  employees AS emp ON bld.building_name = emp.building;

-- 2. Find the list of all buildings and their capacity
SELECT
  building_name,
  capacity
FROM
  buildings;

-- 3. List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT DISTINCT
  bld.building_name,
  emp.role
FROM
  buildings AS bld
LEFT JOIN 
  employees AS emp ON bld.building_name = emp.building;
