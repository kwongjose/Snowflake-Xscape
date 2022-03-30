use escape_velocity_sales.curated;

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