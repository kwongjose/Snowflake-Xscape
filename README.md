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
//TODO
### Creation
Your ReadMe should contain information that shows how the code should be run on the
production environment (Deployment RunBook section) information that might be helpful to the
end user about the databases that were created, and information about the data (User
Documentation section). Include a concise table list of SQL file run order. The table should
contain the numerical run order, name of file, path in repository, and short description of what
the file will create or do.
### Deletion / Rollback
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

## Materialized Views
//TODO
Read about Snowflake materialized views and clustering. In a section of your ReadMe, give two
specific use cases where clustering and materialized views may be beneficial to the consumption
of the sales data.

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