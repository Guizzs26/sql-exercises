-- SQL Lesson 2: Queries with constraints (Pt. 1)

-- 1. Find the movie with a row id of 6
SELECT id, title FROM movies WHERE id = 6;

-- 2. Find the movies released in the years between 2000 and 2010
SELECT id, title, year FROM movies WHERE year BETWEEN 2000 AND 2010;

-- 3. Find the movies not released in the years between 2000 and 2010
SELECT id, title, year FROM movies WHERE year NOT BETWEEN 2000 AND 2010;

-- 4. Find the first 5 Pixar movies and their release year
SELECT id, title, year FROM movies WHERE year LIMIT 5;