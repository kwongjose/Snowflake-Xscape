// drop views
DROP VIEW IF EXISTS escape_velocity_sales.curated.customer_monthly_sales_2019_view;
DROP VIEW IF EXISTS escape_velocity_sales.curated.product_sales_view;
DROP VIEW IF EXISTS escape_velocity_sales.curated.top_ten_customers_amount_view;

// drop curated tables
DROP TABLE IF EXISTS escape_velocity_sales.curated.sales;
DROP TABLE IF EXISTS escape_velocity_sales.curated.products;
DROP TABLE IF EXISTS escape_velocity_sales.curated.customers;
DROP TABLE IF EXISTS escape_velocity_sales.curated.employees;

DROP SCHEMA IF EXISTS escape_velocity_sales.curated;

// drop raw tables
DROP TABLE IF EXISTS escape_velocity_sales.raw.sales;
DROP TABLE IF EXISTS escape_velocity_sales.raw.products;
DROP TABLE IF EXISTS escape_velocity_sales.raw.customers;
DROP TABLE IF EXISTS escape_velocity_sales.raw.employees;

// drop stages
DROP STAGE IF EXISTS escape_velocity_sales.raw.stage_sales;
DROP STAGE IF EXISTS escape_velocity_sales.raw.stage_employee;
DROP STAGE IF EXISTS escape_velocity_sales.raw.stage_products;
DROP STAGE IF EXISTS escape_velocity_sales.raw.stage_customers;

DROP SCHEMA IF EXISTS escape_velocity_sales.raw;

// drop database
DROP DATABASE IF EXISTS escape_velocity_sales;
