// just in case
USE DATABASE escape_velocity_sales;

CREATE SCHEMA IF NOT EXISTS curated
       DATA_RETENTION_TIME_IN_DAYS = 0;

USE SCHEMA curated;

DROP TABLE IF EXISTS employees;

CREATE TABLE IF NOT EXISTS employees (
       EmployeeID int not null,
       FirstName varchar not null,
       MiddleInitial varchar null,
       LastName varchar not null,
       Region varchar null);

// copy data from raw to curated, transforming as necessary
INSERT INTO curated.employees (
       EmployeeID, FirstName, MiddleInitial, LastName, Region)
       SELECT EmployeeID, FirstName, MiddleInitial, LastName, INITCAP(Region)
       FROM raw.employees;

//transform customers
DROP TABLE IF EXISTS customers;

CREATE TABLE IF NOT EXISTS customers (
       CustomerID int not null,
       FirstName varchar not null,
       MiddleInitial varchar null,
       LastName varchar not null);

// copy data from raw to curated, transforming as necessary
INSERT INTO curated.customers (
       CustomerID, FirstName, MiddleInitial, LastName)
       SELECT DISTINCT CustomerID, FirstName, MiddleInitial, LastName
       FROM raw.customers;

//transform sales
DROP TABLE IF EXISTS sales;

CREATE TABLE IF NOT EXISTS sales (
       OrderID int not null,
       SalesPersonID int not null,
       CustomerID int not null,
       ProductID int not null,
       Quantity int null,
       Date timestamp null);

// copy data from raw to curated, transforming as necessary
INSERT INTO curated.sales (
       OrderID, SalesPersonID, CustomerID, ProductID, Quantity, Date)
       SELECT OrderID, SalesPersonID, CustomerID, ProductID, Quantity, Date
       FROM raw.sales;


//transform products
DROP TABLE IF EXISTS products;

CREATE TABLE IF NOT EXISTS products (
       ProductID int not null,
       Name varchar not null,
       Price number(12,4) null);


// copy data from raw to curated, transforming as necessary
INSERT INTO curated.products (
       ProductID, Name, Price)
       SELECT ProductID, Name, Price
	   FROM raw.products;
