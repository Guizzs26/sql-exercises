-- Problem: Teams Power User
-- Microsoft Interview Question
-- Difficulty: Easy
-- Link: https://datalemur.com/questions/teams-power-users

-- Solution 1 - Usign <= >= to date range 
SELECT 
  sender_id,
  COUNT(message_id) AS message_count
FROM messages
WHERE sent_date >= '2022-08-01' AND sent_date <= '2022-08-31'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;

-- Solution 2 - Using EXTRACT() function from month and year
SELECT 
  sender_id,
  COUNT(message_id) AS message_count
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = '8'
  AND EXTRACT(YEAR FROM sent_date) = '2022'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2; 

-- Solution 3 - Using to_char
SELECT  
  sender_id, 
  COUNT(message_id) AS message_count
FROM messages 
WHERE TO_CHAR(sent_date, 'MM-YYYY') = '08-2022'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 2;

-- !!! - Study more this solution (between with hour) - stack over flow discussion:
-- https://stackoverflow.com/questions/31433747/postgres-where-clause-compare-timestamp.com
SELECT
   sender_id,
  COUNT(message_id) AS message_count
FROM messages
WHERE sent_date BETWEEN '08/01/2022 00:00:00' AND '08/31/2022 00:00:00'
GROUP BY sender_id 
ORDER BY COUNT(message_id) DESC
LIMIT 2;