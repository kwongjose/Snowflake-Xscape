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

// sanity check
SELECT TOP 24 * FROM customer_monthly_sales_2019_view;
