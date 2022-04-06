// make sure database and schema are right
USE escape_velocity_sales.curated;

DROP VIEW IF EXISTS customer_monthly_sales_2019_view;

CREATE VIEW customer_monthly_sales_2019_view AS
  SELECT c.CustomerID, c.LastName, c.FirstName, a.Year, a.Month, a.Aggregate
    FROM customers as c, LATERAL(
        SELECT sales.CustomerID,
          YEAR(sales.Date) as Year,
          MONTH(sales.Date) as Month,
          sum(sales.Quantity) as Aggregate
        FROM sales
        WHERE YEAR(sales.Date) = 2019 and sales.CustomerID = c.CustomerID
        GROUP BY sales.CustomerID, YEAR(sales.Date), MONTH(sales.Date))
	AS a;

-- // sanity check
-- SELECT TOP 24 * FROM customer_monthly_sales_2019_view;

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

DROP VIEW IF EXISTS product_sales_view;

CREATE VIEW product_sales_view AS
	SELECT s.OrderID, s.SalesPersonID as "SalesPerson ID", s.CustomerID as "Customer ID", s.ProductID as "Product ID", Name as "Product Name", Price as "Product Price", s.Quantity, Amount as "Total Sales Amount", s.Date as "Order Date", YEAR(s.Date) as "Sales Year", MONTH(s.Date) as "Sales Month"
    FROM sales as s, LATERAL(
        SELECT
            Name,
            Price,
            Price * s.Quantity AS Amount
        FROM products as p
      WHERE s.ProductID = ProductID) AS a;
