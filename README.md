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
