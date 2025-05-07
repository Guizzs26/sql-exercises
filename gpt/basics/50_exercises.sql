-- 1. List the 5 most expensive products that have more than 10 units in stock.
SELECT name, price, stock
FROM products 
ORDER BY price DESC
LIMIT 10;


-- 2. Find the total amount of sales per product category, sorting from highest to lowest, 
-- and display only categories with sales over R$5,000.
SELECT
  p.nome,
  p.category,
  SUM(sl.price * sl.quantity) AS total_amount_per_category
FROM
  products p 
INNER JOIN
  sale_items sl ON p.product_id = sl.product_id
GROUP BY
  p.category
HAVING
  SUM(sl.price * sl.quantity) > 5000
ORDER BY  
  total_amount_per_category DESC;


-- 3. Identify customers who made purchases in at least 3 different months during the year 2023.
SELECT  
  c.name,
  COUNT(DISTINCT EXTRACT(MONTH FROM s.sale_date)) as distinct_months
FROM
  sales s
INNER JOIN
  customers c ON s.customer_id = c.customer_id
WHERE
  EXTRACT(YEAR FROM s.sale_date) = 2023
GROUP BY
  c.name
HAVING
  COUNT(DISTINCT EXTRACT(MONTH FROM s.sale_date)) >= 3
ORDER BY 
  distinct_months DESC, c.name ASC;


-- 4. Return the products that have never been sold, sorted by decreasing price.
SELECT 
	p.name,
	p.price
FROM 
	products AS p
LEFT JOIN
	itens_sale AS isl ON p.product_id = isl.product_id
WHERE
	isl.product_id IS NULL
ORDER BY
	p.price DESC;


-- 5. Find the customer who spent the highest amount on a single purchase and show which product
-- they bought, considering only sales with single items.
SELECT
  c.name,
  p.name,
  s.total_sale AS unique_sale_value,
	s.sale_id,
	isl.unit_price,
	s.total_value
FROM
  sales s
INNER JOIN
  customers c ON s.customer_id = c.customer_id
INNER JOIN
  itens_sale isl ON s.sale_id = isl.sale_id
INNER JOIN  
  products p ON isl.product_id = p.product_id
WHERE s.sale_id IN (
  SELECT sale_id
  FROM sale
  GROUP BY sale_id
  HAVING COUNT(*) = 1
)
ORDER BY 
  unique_sale_value DESC
LIMIT 1;


-- 6. List the number of sales per month, but exclude months with fewer than 3 sales.
SELECT
  TO_CHAR(sale_date, 'YYYY-MM') AS formatted_date,
  COUNT(*) AS sales_per_month
FROM
  sales s
GROUP BY
  TO_CHAR(sale_date, 'YYYY-MM')
HAVING 
  COUNT(*) >=3
ORDER BY  
  formatted_date DESC;
