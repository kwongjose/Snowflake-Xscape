USE DATABASE escape_velocity_sales;

// drop stages
DROP STAGE @stage_sales;
DROP STAGE stage_employee;
DROP STAGE state_products;
DROP STAGE stage_customers;

// drop tables
DROP TABLE sales;
DROP TABLE products;
DROP TABLE customers;
DROP TABLE employees;

// drop schema
DROP SCHEMA raw;

// drop database
DROP DATABASE escape_velocity_sales;
