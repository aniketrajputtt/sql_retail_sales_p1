-- SQL Retail Sales Analysis - P1

create database sql_project_p1 ;

-- Create Table

	CREATE TABLE 
			retail_sales 
	(
    	transactions_id INT PRIMARY KEY,
    	sale_date DATE,
    	sale_time TIME,
    	customer_id INT,
    	gender VARCHAR(15),
    	age INT,
    	category VARCHAR(15),
    	quantity INT,  -- Fixed typo (was "quantiy")
    	price_per_unit FLOAT,    
    	cogs FLOAT,
   		total_sale FLOAT
);

START FROM retail_sales ;

SELECT *  
FROM RETAIL_SALES  
LIMIT 10;


select count(*)
from retail_sales
;

-- DATA CLEANING --

 SELECT *  
 FROM RETAIL_SALES  
 WHERE TRANSACTIONS_ID IS NULL  
   OR SALE_DATE IS NULL  
   OR SALE_TIME IS NULL  
   OR CUSTOMER_ID IS NULL  
   OR GENDER IS NULL  
   OR AGE IS NULL  
   OR QUANTITY IS NULL  
   OR PRICE_PER_UNIT IS NULL  
   OR COGS IS NULL  
   OR TOTAL_SALE IS NULL;

 DELETE FROM RETAIL_SALES  
 WHERE TRANSACTIONS_ID IS NULL  
   OR SALE_DATE IS NULL  
   OR SALE_TIME IS NULL  
   OR CUSTOMER_ID IS NULL  
   OR GENDER IS NULL  
   OR AGE IS NULL  
   OR QUANTITY IS NULL  
   OR PRICE_PER_UNIT IS NULL  
   OR COGS IS NULL  
   OR TOTAL_SALE IS NULL;



-- data exploration

-- how many sales do we have?

 select count(*)
 from retail_sales
;

-- how many customers do we have?

 select count (distinct customer_id) as total_sales 
 from retail_sales
;

-- Total category 

 select distinct category
 from retail_sales
;

-- Analysis and Findings

-- Q1 write a sql query to retrive all columns for sales made on '2022-11-05'

 SELECT *  
 FROM RETAIL_SALES  
 WHERE SALE_DATE = TO_DATE('05-11-2022', 'DD-MM-YYYY');

-- Q2 Write a sql query to retrieve all transactions where category is clothing and the quntity sold is more than 10

 SELECT *  
 FROM RETAIL_SALES  
 WHERE  
    CATEGORY = 'CLOTHING'  
    AND TO_CHAR(SALE_DATE, 'YYYY-MM') = '2022-11'  
    AND QUANTITY > 3
	;  


-- Q3 Write a SQL query to calculate the total sale for each category

 SELECT CATEGORY,  
    SUM(TOTAL_SALE) AS NET_SALES,  
    COUNT(*) AS TOTAL_ORDERS  
 FROM RETAIL_SALES  
 GROUP BY CATEGORY;  


--Q4 Write a SQL query to find total number of transactions made by each gender in each category 

  SELECT 
    CATEGORY, 
    GENDER, 
    COUNT(*) AS TOTAL_TRAN
 FROM RETAIL_SALES
 GROUP BY CATEGORY, GENDER
 ORDER BY CATEGORY;

-- Q5 write a sql query to calculate the avrage sales for each month find out best selling in each year 

 
SELECT 
	YEAR,
	MONTH,
	AVG_SALE
FROM
(
SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (
        PARTITION BY EXTRACT(YEAR FROM sale_date) 
        ORDER BY AVG(total_sale) DESC
    ) AS RANK
FROM retail_sales
GROUP BY year, month
)  AS T1
WHERE RANK = 1

-- Q WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMER BASED ON THE HIGHEST TOTAL SALES 

SELECT
	CUSTOMER_ID ,
	GENDER,
	SUM(TOTAL_SALE) AS TOTAL_SALE
FROM
	retail_sales
GROUP BY 
	CUSTOMER_ID, GENDER 
ORDER BY
	TOTAL_SALE DESC
LIMIT 	
		5
;

-- Q WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY

SELECT 
	CATEGORY,
	COUNT(DISTINCT CUSTOMER_ID) AS CUS_UNIQUE
	FROM
		retail_sales
	GROUP BY
	 		1
	 ;

-- Q. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale AS (
    SELECT *,
        CASE 
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening' 
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

-- END OF PROJECT --


	 