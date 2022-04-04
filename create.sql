// First attempt at automating creation and loading of sales data
CREATE DATABASE IF NOT EXISTS escape_velocity_sales;

USE DATABASE escape_velocity_sales;

CREATE SCHEMA IF NOT EXISTS raw
       DATA_RETENTION_TIME_IN_DAYS = 0;

USE SCHEMA raw;

CREATE TABLE IF NOT EXISTS employees (
       EmployeeID int not null,
       FirstName varchar not null,
       MiddleInitial varchar null,
       LastName varchar not null,
       Region varchar null);

// informational only
DESCRIBE TABLE employees;

CREATE STAGE IF NOT EXISTS stage_employee
       URL = "s3://seng5709/employees/";

COPY INTO employees FROM @stage_employee
     file_format = (type = CSV skip_header = 1);

// validation
SELECT TOP 10 * FROM employees;

// worth considering if we want null for middle initial or an empty string
CREATE TABLE IF NOT EXISTS customers(
       CustomerID int not null,
       FirstName varchar not null,
       MiddleInitial varchar null,
       LastName varchar not null);

// informational only
DESCRIBE TABLE customers;

CREATE STAGE IF NOT EXISTS stage_customers
       URL = "s3://seng5709/customers/";

COPY INTO customers FROM @stage_customers
     file_format = (type = CSV field_delimiter = '|' skip_header = 1);

// validation
SELECT TOP 10 * FROM customers;

CREATE TABLE IF NOT EXISTS sales (
       OrderID int not null,
       SalesPersonID int not null,
       CustomerID int not null,
       ProductID int not null,
       Quantity int null,
       Date timestamp null);

// informational only
DESCRIBE TABLE sales;

CREATE STAGE IF NOT EXISTS stage_sales
       URL = "s3://seng5709/sales/";

COPY INTO sales FROM @stage_sales
     file_format = (type = CSV skip_header = 1 FIELD_DELIMITER = '|');
     

// validation
SELECT TOP 10 * FROM sales;

CREATE TABLE IF NOT EXISTS products(
       ProductID int not null,
       Name varchar not null,
       Price number(12,4) null);

// informational only
DESCRIBE TABLE products;

CREATE STAGE IF NOT EXISTS stage_products
       URL = "s3://seng5709/products/";


COPY INTO products FROM @stage_products
     file_format = (type = CSV field_delimiter = '|' skip_header = 1);

// validation
SELECT TOP 10 * FROM products;
