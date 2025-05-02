-- SQL Lesson 6: Multi-table queries with JOINs

-- 1. Find the domestic and international sales for each movie
SELECT  
  mv.id,
  mv.title,
  bo.domestic_sales,
  bo.international_sales
FROM  
  movies as mv
INNER JOIN
  boxoffice AS bo ON mv.id = bo.movie_id;

-- 2. Show the sales numbers for each movie that did better internationally rather than domestically
SELECT
  mv.id,
  mv.title,
  bo.domestic_sales,
  bo.international_sales
FROM
  movies AS mv
INNER JOIN
  boxoffice AS bo ON mv.id = bo.movie_id
WHERE 
  international_sales > domestic_sales;

-- 3. List all the movies by their ratings in descending order
SELECT  
  mv.id,
  mv.title,
  bo.rating
FROM  
  movies AS mv
INNER JOIN
  boxoffice AS bo ON mv.id = bo.movie_id
ORDER BY
  rating DESC;