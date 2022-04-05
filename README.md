# Snowflake-Xscape

## Project Team: Escape Velocity

## Team Members:

  - Andrew Bros
  - Emily Clark
  - John Caspers
  - Joseph Kwong
  - Michael Whitney

## Slack channel: escape-velocity
https://umndataspring2022.slack.com/archives/C02UQ7W64EB

-----

## Deployment RunBook
This runbook will detail how to provision our database, schemas, staging environments, and views. This runbook will also include a deletion clause, in the case a rollback is deemed necessary.

## Creation

### Execution Order:
| Order | Filename               | Directory | Description                                                                                                                                                       |
|-------|------------------------|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1     | create.sql             | ./        | Creates database, raw schema, staging tables for customers, employees, sales, and products. Downloads and loads data to the staging tables.                       |
| 2     | transform.sql          | ./        | Creates curated schema, curated tables for customers, employees, sales, and products. Transforms and sanitizes data from staging, and loads it to curated tables. |
| 3     | create_views.sql       | ./        | Creates a view for monthly sales in 2019. Outputs top 24 results.                                                                                                 |
| 4     | top_customers_view.sql | ./        | Creates a view for the highest-spending customers. Outputs top ten customers.                                                                                     |
| 5     | product_sales_view.sql | ./        | Creates a view for product sales.                                                                                                                                 |

### Runbook (Longform)
1. Ensure user is properly authenticated to the Snowflake environment. The user should also have SSH credentials configured for GitHub on their machine.

If these steps have already been completed, you may disregard, and skip to **Step 4**.

2. If the repository is not yet cloned, do this now. The repository will default to the `main` branch. This is the correct branch to run these commands from.

3.  The necessary files are at the root of this repository. Traverse to the root of the directory, 

These commands are as shown below:

``` 
git clone git@github.com:kwongjose/Snowflake-Xscape.git

cd Snowflake-Xscape
```

4. In the CLI, type the command: 
```
snowsql -f create.sql
```
This command creates the database, raw schema, staging tables for customers, employees, sales, and products. It then downloads and loads data to the staging tables.

5. In the CLI, type the command: 
```
snowsql -f transform.sql
```
This command creates the curated schema, curated tables for customers, employees, sales, and products. It then transforms and sanitizes data from staging, and loads it to curated tables.

6. In the CLI, type the command: 
```
snowsql -f create_views.sql
```
This command creates a view for monthly sales in 2019. It outputs the top 24 results.

7. In the CLI, type the command: 
```
snowsql -f top_customers_view.sql
```
This command creates a view for the highest-spending customers. It outputs the top ten customers.

8. In the CLI, type the command: 
```
snowsql -f product_sales_view.sql
```
This command creates a view for product sales.

9. This is the end, you have successfully deployed our changes.

---

## Deletion / Rollback
If rollback is necessary, all databases, tables, schemas, and staging environments can be quickly removed from the environment.

1. Ensure user is properly authenticated to the Snowflake environment. The user should also have SSH credentials configured for GitHub on their machine.

If these steps have already been completed, you may disregard, and skip to **Step 4**.

2. If the repository is not yet cloned, do this now. The repository will default to the `main` branch. This is the correct branch to run these commands from.

3.  The necessary files are at the root of this repository. Traverse to the root of the directory, 

These commands are as shown below:

``` 
git clone git@github.com:kwongjose/Snowflake-Xscape.git

cd Snowflake-Xscape
```

4. In the CLI, type the command: 

```
snowsql -f drop.sql
```

5. The code will execute, with output to the console about the successful deletion of all resources. You have successfully rolled back our changes.

-----

## Materialized Views and Clustering
1. Lets assume that we have a complete list of all products that a customer can buy and that customers buy product that is in stock. We want to perform queries against those products and we want to get orders that happen in a specific date range. First, we can create a materialized view that lists only interactions among product that you keep in stock. Therefore, as long as orders are for product that is in that materialized view the searchers will be faster. We can create a cluster key on the Date column and the ProductID column because we only want a specific set of rows in a specific order. Both materialized views and clustering in this case help create faster and more efficient queries. 

2. Lets assume we have a complete list of all customers who can purchase product. If we want to perform queries against that set of customers, we can create a materialized view that lists only interactions with that customers list. We can create a clustering key with the Date and CustomerID column so that we can query on a specific set of dates during a time period. This case would improve queries where we want to determine which customers made purchase during a time period and how much did they buy. 

-----

## Data Quality checks

- check for duplicate ID value
- check for NULL values

### Employees2.csv
- inconsistent capitalization of Region.
- check for duplicated names?
- O'Leary has a single quote as middle name

### Products.csv
- uses pipe delimiters instead of comma
- check for duplicate product name
- 48 products have a price of 0.0000
- check for negative price?
- punctuation in product name [,-'.]

### Customer
- pipe delimited
- only id, first, middle, last name fields
- duplicate row:
  17829|Stefanie||Smith
- repeated names with different id - We will ignore this, as we cannot confirm if they are unique or duplicate individuals.

### Sales
- pipe delimited
- foreign keys to employee, customer, product
- check for invalid foreign key values (non-joinable rows)
- check for invalid dates/times
- check for invalid quantity