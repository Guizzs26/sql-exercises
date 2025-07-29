-- Problem: Unfinished Parts
-- Tesla Interview Question
-- Difficulty: Easy
-- Link: https://datalemur.com/questions/tesla-unfinished-parts

-- Solution 01 - Using IS NULL
SELECT part, assembly_step
FROM parts_assembly
WHERE finished_date IS NULL;

-- Trivial question, just select the parts that are not finished yet.