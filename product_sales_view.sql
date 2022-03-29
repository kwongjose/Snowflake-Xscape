user escape_velocity_sales.curated;

DROP VIEW IF EXISTS product_sales_view;

CREATE VIEW product_sales_view AS
	SELECT s.OrderID, s.SalesPersonID, s.CustomerID, s.ProductID, Name, Price, s.Quantity, Amount, s.Date, YEAR(s.Date) as Year, MONTH(s.Date) as Month
    FROM sales as s, LATERAL(
        SELECT
            Name,
            Price,
            Price * s.Quantity AS Amount
        FROM products as p
      WHERE s.ProductID = ProductID) AS a;