# 📊 Retail Sales Analysis using SQL
Welcome to the Retail Sales Analysis Project where I used SQL to analyze transactional data and derive actionable business insights. This project covers everything from data cleaning to advanced analytics, all done in SQL.

📁 Dataset Overview
The dataset is a retail transaction log with the following key columns:

transactions_id: Unique ID of each sale

sale_date, sale_time: Timestamp of the sale

customer_id: Unique identifier for each customer

gender, age: Demographics of the customer

category: Product category sold

quantity: Number of units sold

price_per_unit: Price for one unit

cogs: Cost of goods sold

total_sale: Total revenue from each transaction

 Work Done
1. Database and Table Creation
2. CREATE DATABASE sql_project_p1;
```sql 
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT

);```

 Data Cleaning
Identified and removed rows with NULL values:

```sql
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL
   ;
   ```

 ```sql
 DELETE FROM retail_sales
   WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL
   ;
   ```

-- Q1 Peak sales hour:
```sql
SELECT sale_time, SUM(total_sale) AS hourly_sales
FROM retail_sales
GROUP BY sale_time
ORDER BY hourly_sales DESC
LIMIT 1;
```
. Customer Insights
Age group with highest revenue:

```sql
SELECT *,
  CASE
    WHEN age BETWEEN 10 AND 20 THEN '10-20'
    WHEN age BETWEEN 21 AND 30 THEN '21-30'
    WHEN age BETWEEN 31 AND 40 THEN '31-40'
    ELSE '40+'
  END AS age_group,
  SUM(total_sale) AS revenue
FROM retail_sales
GROUP BY age_group
ORDER BY revenue DESC;
```

🧰 Tools & Technologies
SQL (MySQL/PostgreSQL compatible)

DBMS: MySQL Workbench / pgAdmin / DBeaver

Data Source: Simulated retail dataset



