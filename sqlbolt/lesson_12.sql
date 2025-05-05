-- SQL Lesson 12: Order of execution of a Query

-- 1. Find the number of movies each director has directed
SELECT
  director,
  COUNT(*) AS total_movies_director
FROM  
  movies
GROUP BY 
  director;

-- 2. Find the total domestic and international sales that can be attributed to each director
SELECT
  mv.director,
  SUM(domestic_sales + international_sales) AS cumulative_sales_from_all_movies
FROM
  movies AS mv
INNER JOIN
  boxoffice AS bo ON mv.id = bo.movie_id
GROUP BY
  director;