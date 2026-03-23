-- Join orders, products, and payments
-- =========================
-- 1. MASTER DATA JOIN
-- =========================
SELECT
  o.order_id,
  o.customer_id,
  i.product_id,
  p.product_category_name,
  pay.payment_type,
  pay.payment_value
FROM orders o
JOIN order_items i
  ON o.order_id = i.order_id
JOIN products p
  ON i.product_id = p.product_id
JOIN order_payments pay
  ON o.order_id = pay.order_id;
