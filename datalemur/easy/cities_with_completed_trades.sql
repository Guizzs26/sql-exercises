-- Problem: Cities With Completed Trades
-- Robinhood  Interview Question
-- Difficulty: Easy
-- Link: https://datalemur.com/questions/completed-trades

-- Solution 1 - Nothing special 
SELECT
  u.city,
  COUNT(*) AS total_completed_trades
FROM trades t 
INNER JOIN users u ON u.user_id = t.user_id
WHERE t.status = 'Completed'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3 ;

-- Solution 2 - No alias, order_id in COUNT function
SELECT 
  users.city, 
  COUNT(trades.order_id) AS total_orders 
FROM trades 
INNER JOIN users 
  ON trades.user_id = users.user_id 
WHERE trades.status = 'Completed' 
GROUP BY users.city 
ORDER BY total_orders DESC
LIMIT 3;

-- Solution 3 - SUM with CASE
SELECT 
  u.city, 
  SUM(CASE WHEN t.status = 'Completed' THEN 1 ELSE 0 END) as total_orders
FROM trades as t
JOIN users as u ON t.user_id = u.user_id
GROUP BY u.city
ORDER BY total_orders DESC
LIMIT 3; 