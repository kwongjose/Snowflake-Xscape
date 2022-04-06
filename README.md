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
| 3     | create_views.sql       | ./        | Creates a view for monthly sales in 2019. Creates a view for the highest-spending customers. Outputs top ten customers.  Creates a view for product sales.                                                                                  

### Runbook (Longform)
1. Ensure user is properly authenticated to the Snowflake environment. The user should also have access to GitHub on their machine.

If these steps have already been completed, you may disregard, and skip to **Step 4**.

2. If the repository is not yet cloned, do this now. The repository will default to the `main` branch. This is the correct branch to run these commands from.

3.  The necessary files are at the root of this repository. Traverse to the root of the directory, 

These commands are as shown below:

``` 
git clone https://github.com/kwongjose/Snowflake-Xscape.git

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
This command creates a view for monthly sales in 2019.

This command also creates a view for the highest-spending customers. It outputs the top ten customers.

This command also creates product and sales view that includes columns for sales year
and month.

7. This is the end, you have successfully deployed our changes.

---

## Deletion / Rollback
If rollback is necessary, all databases, tables, schemas, and staging environments can be quickly removed from the environment.

1. Ensure user is properly authenticated to the Snowflake environment. The user should also have access to GitHub on their machine.

If these steps have already been completed, you may disregard, and skip to **Step 4**.

2. If the repository is not yet cloned, do this now. The repository will default to the `main` branch. This is the correct branch to run these commands from.

3.  The necessary files are at the root of this repository. Traverse to the root of the directory, 

These commands are as shown below:

``` 
git clone https://github.com/kwongjose/Snowflake-Xscape.git

cd Snowflake-Xscape
```

4. In the CLI, type the command: 

```
snowsql -f drop.sql
```

5. The code will execute, with output to the console about the successful deletion of all resources. You have successfully rolled back our changes. If the database is empty, or does not exist, it will output appropriate errors, however the final result is still that all data has been cleansed from the system.

-----

## Materialized Views and Clustering
1. Lets assume that we have a complete list of all products that a customer can buy and that customers buy product that is in stock. We want to perform queries against those products and we want to get orders that happen in a specific date range. First, we can create a materialized view that lists only interactions among product that you keep in stock. Therefore, as long as orders are for product that is in that materialized view the searchers will be faster. We can create a cluster key on the Date column and the ProductID column because we only want a specific set of rows in a specific order. Both materialized views and clustering in this case help create faster and more efficient queries. This use case may require the date field to be a non-nullable field, which is an update to the current table format.

2. Lets assume we have a complete list of all existing customers who can purchase product. If we want to perform queries against that set of customers, we can create a materialized view that lists only interactions with that customers list. We can create a clustering key with the Date and CustomerID column so that we can query on a specific set of dates during a time period. This case would improve queries where we want to determine which existing customers have made a purchase during a time period and how much did they buy. This use case may require the date field to be a non-nullable field, which is an update to the current table format.

-----

## Data Quality checks

- Duplicate ID values were checked for in all datasets.
- Null fields were checked for in all datasets.

### Employees2.csv
- Inconsistent capitalization of Regions were detected. This is remedied during staging.
- O'Leary has a single quote as middle name. This was kept, as we cannot determine if this is incorrect information.
- No duplicate employee entries were found.

### Products.csv
- No duplicate entries were found.
- All products with price of $0.00 were retained in the dataset.
- No products with a negative price were found.
- Special characters in product names did not cause parsing errors.

### Customer
- Duplicate entries were found and cleansed from the dataset. This does not include customers who share the same name as one another.

### Sales
- All foreign key values were valid for joining.
- All Date and Time entries were formatted correctly.
- All quantities were numeric values greater than zero.