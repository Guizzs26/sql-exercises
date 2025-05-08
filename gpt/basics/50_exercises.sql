-- 1. List the 5 most expensive products that have more than 10 units in stock.
SELECT name, price, stock
FROM products 
WHERE stock > 10
ORDER BY price DESC
LIMIT 5;


-- 2. Find the total amount of sales per product category, sorting from highest to lowest, 
-- and display only categories with sales over R$5,000.
SELECT
  p.name,
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

-- OR

SELECT 
    EXTRACT(MONTH FROM sale_date) || '-' || LPAD(EXTRACT(MONTH FROM sale_date)::TEXT, 2, '0') AS month,
    COUNT(*) AS sales_per_month
FROM sales s
GROUP BY EXTRACT(MONTH FROM sale_date), LPAD(EXTRACT(MONTH FROM sale_date)::TEXT, 2, '0')
HAVING(*) >= 3
ORDER BY EXTRACT(YEAR FROM data_venda), EXTRACT(MONTH FROM data_venda);


-- 7. Identify customers who purchased products from at least 4 different categories.
SELECT 
    c.customer_id, 
    c.name, 
    COUNT(DISTINCT p.category) AS qtt_distinct_categories
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
INNER JOIN sale_items si ON s.sale_id = si.sale_id
INNER JOIN products p ON si.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT p.category) >= 4;


-- 8. Find the average price of products by category, but exclude the categories 'Electronics' and 'Computers'
-- and products with stock below 15.
SELECT
    category,
    AVG(price) AS avg_price_by_category
FROM products
WHERE category NOT IN ('Eletronics', 'Computers') AND stock >= 15;


-- 9. List customers who have made purchases totaling more than R$3,000, but have never purchased products from the 'Furniture' category.
SELECT
    c.customer_id,
    c.name,
    SUM(s.total_value) AS total_spent
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
INNER JOIN sale_items si ON s.sale_id = si.sale_id
INNER JOIN products p ON si.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING 
    SUM(s.total_value) > 3000 
    AND
    COUNT(CASE WHEN p.category = 'Furniture' THEN 1 END) = 0;


-- 10. For each state, show the average sales value and the most sold product (by quantity).
WITH product_sales_by_state AS (
    SELECT 
        c.state,
        p.product_id,
        p.name,
        SUM(si.quantity) AS total_quantity
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    JOIN sale_items si ON s.sale_id = si.sale_id
    JOIN products p ON si.product_id = p.product_id
    GROUP BY c.state, p.product_id, p.name
),
most_sold_products AS (
    SELECT DISTINCT ON (state)
        state,
        name AS most_sold_product,
        total_quantity
    FROM product_sales_by_state
    ORDER BY state, total_quantity DESC
)
SELECT 
    c.state,
    ROUND(AVG(s.total_value), 2) AS avg_sales,
    msp.most_sold_product,
    msp.total_quantity
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN most_sold_products msp ON c.state = msp.state
GROUP BY c.state, msp.most_sold_product, msp.total_quantity;


-- 11. Find products whose price is greater than the average price in their category and that have been sold at least 2 times.
SELECT 
    p.name, 
    p.category,
    p.price,
    COUNT(si.item_id) AS sale_count
FROM products p
INNER JOIN sale_items si ON p.product_id = si.product_id
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category = p.category
)
GROUP BY p.name, p.category, p.price
HAVING COUNT(si.item_id) >= 2;