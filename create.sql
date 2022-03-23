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

// informational - how does stage work with multiple files?
LIST @stage_employee;

COPY INTO employees FROM @stage_employee
     file_format = (type = CSV skip_header = 1);

// validation
SELECT TOP 10 * FROM employees;
