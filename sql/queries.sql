-- Project: E-commerce Analysis
-- Tool: BigQuery
-- Author: Muktha R

-- 1. Revenue by Month

SELECT
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
  EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
  SUM(payment_value) AS total_revenue
FROM orders o
JOIN order_payments p
  ON o.order_id = p.order_id
GROUP BY year, month
ORDER BY year, month;


-- 2. Top Product Categories

SELECT
  p.product_category_name,
  SUM(i.price) AS total_revenue
FROM order_items i
JOIN products p
  ON i.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 3. Customer Orders Count

SELECT
  customer_id,
  COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;


-- 4. Delivery Speed

SELECT
  order_id,
  DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) AS delivery_days,
  CASE
    WHEN DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) <= 5 THEN 'Fast'
    WHEN DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) <= 10 THEN 'Medium'
    ELSE 'Slow'
  END AS delivery_category
FROM orders;
