USE DATABASE escape_velocity_sales;
USE SCHEMA curated;

// drop tables
DROP TABLE sales;
DROP TABLE products;
DROP TABLE customers;
DROP TABLE employees;

DROP schema curated;
USE schema raw;

// drop stages
DROP STAGE stage_sales;
DROP STAGE stage_employee;
DROP STAGE stage_products;
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
