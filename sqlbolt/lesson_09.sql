-- SQL Lesson 9: Queries with expressions

-- 1. List all movies and their combined sales in millions of dollars
SELECT
  mv.title,
  (bo.domestic_sales + bo.international_sales) / 1000000 AS total_sales
FROM 
  movies AS mv
INNER JOIN  
  boxoffice AS bo ON mv.id = bo.movie_id;

-- 2. List all movies and their ratings in percent
SELECT
  mv.title,
  bo.rating * 10 AS rating_in_percent
FROM
  movies AS mv
INNER JOIN  
  boxoffice AS bo ON mv.id = bo.movie_id;

-- 3. List all movies that were released on even number years
SELECT title, year
FROM movies 
WHERE year % 2 = 0;