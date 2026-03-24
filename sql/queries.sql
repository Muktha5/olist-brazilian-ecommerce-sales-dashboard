-- Project: E-commerce Analysis
-- Tool: BigQuery
-- Author: Muktha R

-- 1. Revenue Trend Analysis
-- Business Question :
-- How Has Revenue changed over month?

SELECT
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
  EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
  SUM(payment_value) AS total_revenue
FROM orders o
JOIN order_payments p
  ON o.order_id = p.order_id
GROUP BY year, month
ORDER BY year, month;

-- INSIGHT:
-- Revenue shows a consistent upward trend with periodic spikes,
-- indicating possible seasonal demand patterns.

-- 2. Top Product Categories
-- Business Question :
-- Which Product Categories Generate the Highest Revenue?

SELECT
  p.product_category_name,
  SUM(i.price) AS total_revenue
FROM order_items i
JOIN products p
  ON i.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- INSIGHT:
-- A few categories dominate revenue, suggesting dependency on
-- specific product segments.


-- 3. CUSTOMER ORDER BEHAVIOR
-- BUSINESS QUESTION:
-- Who are the most active customers based on order count?

SELECT
  customer_id,
  COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- INSIGHT:
-- A small group of customers contributes to a large number of orders,
-- indicating repeat purchase behavior.


-- 4. Delivery Speed
-- BUSINESS QUESTION:
-- How fast are orders being delivered?

SELECT
  order_id,
  DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) AS delivery_days,
  CASE
    WHEN DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) <= 5 THEN 'Fast'
    WHEN DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) <= 10 THEN 'Medium'
    ELSE 'Slow'
  END AS delivery_category
FROM orders;

-- INSIGHT:
-- Majority of deliveries fall under medium category, with fewer fast deliveries,
-- indicating scope for logistics improvement.
