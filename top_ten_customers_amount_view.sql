USE escape_velocity_sales.curated;

DROP VIEW IF EXISTS top_ten_customers_amount_view;
CREATE VIEW top_ten_customers_amount_view AS (
  WITH customer_purchase_amount as (
    SELECT s.CustomerID, SUM(s.Quantity*p.Price) as TotalLifetimePurchasedAmount
    FROM sales as s
    JOIN products as p
    ON s.ProductID = p.ProductID
    GROUP BY s.CustomerID
  )
  SELECT TOP 10 c.CustomerID, c.LastName, c.FirstName, p.TotalLifetimePurchasedAmount
  FROM customers as c, customer_purchase_amount as p
  WHERE c.CustomerID = p.CustomerID
  ORDER BY TotalLifetimePurchasedAmount DESC
);