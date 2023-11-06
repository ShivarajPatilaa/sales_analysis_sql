-- Create database
CREATE DATABASE IF NOT EXISTS Sales_walmart;

USE Sales_walmart;

-- Create table
CREATE TABLE IF NOT EXISTS Orders(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    quantity INT NOT NULL,
    product_category VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    gross_margin FLOAT(11, 9),
    gross_income DECIMAL(12, 4),
    paymenttype VARCHAR(15) NOT NULL,
    branch_code CHAR(1) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30),
    rating FLOAT(2, 1),
    date DATETIME NOT NULL,
    time TIME NOT NULL);
    
-- Table Overview

DESCRIBE Orders;
    
SELECT * 
FROM Orders;

SELECT  count(*) as 'Total orders',
		SUM(quantity) as 'Total Quantity',
        round(SUM(total)) as 'Total Sales', 
		round(SUM(cost)) as 'Total cost', 
        round(SUM(total) - SUM(cost)) as 'Total Tax'
FROM Orders;

DELIMITER $$
CREATE PROCEDURE getdistinctvalue()
BEGIN
SELECT DISTINCT YEAR(date)
from orders;

SELECT DISTINCT product_category
from orders;

SELECT DISTINCT customer_type
from orders;

SELECT DISTINCT paymenttype
from orders;

SELECT DISTINCT branch_code
from orders;

SELECT DISTINCT city
from orders;

SELECT DISTINCT gender
from orders;
END;
DELIMITER;

CALL getdistinctvalue;

-- *************************************************************** 

-- Add new features column

-- ***********************************************************
ALTER TABLE Orders 
ADD COLUMN time_of_day VARCHAR(10);

-- adding values to time_of_day column based on time of purchase that categorizes sales data by time of day (Morning, Afternoon, or Evening)

UPDATE orders
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- Retrieve count of orders for orders by time of day
select time_of_day, count(*) as 'No_of_orders'
from orders
group by time_of_day;


-- Add a new column 'Day_name' to the 'orders' table with a data type of VARCHAR(10).
ALTER TABLE orders
ADD COLUMN Day_name VARCHAR(10);

-- Update the 'Day_name' column with the day names extracted from the 'date' column.
UPDATE orders
SET Day_name = DAYNAME(date);

-- Retrieve the day names and the count of orders for each day, ordering the results by the number of orders in descending order.
SELECT Day_name, COUNT(*) AS 'No_Of_orders'
FROM Orders
GROUP BY Day_name
ORDER BY No_Of_orders DESC;



ALTER TABLE Orders 
ADD COLUMN Month_name VARCHAR(10);

UPDATE Orders
SET Month_name = MONTHNAME(date);

SELECT Month_name , COUNT(*) AS 'No_Of_orders'
FROM Orders
GROUP BY Month_name 
ORDER BY No_Of_orders DESC;

-- ********************************************************************

-- Sales

-- ********************************************************************

SELECT  Month(date) as 'Month',
		month_name,
		count(*) as 'Total orders',
		SUM(quantity) as 'Total Quantity',
        round(SUM(cost)) as 'Total cost' ,
        round(SUM(total)) as 'Total Sales', 
		round((ROUND(SUM(total)) - LAG(ROUND(SUM(total))) OVER (ORDER BY Month(date))) / ROUND(SUM(total))*100, 2) AS 'Sales Change Percentage'
FROM Orders
GROUP BY month, month_name
ORDER BY month;


SELECT  Day_name,
		count(*) as 'Total orders',
		SUM(quantity) as 'Total Quantity',
        round(SUM(cost)) as 'Total cost' ,
        round(SUM(total)) as 'Total Sales'
FROM Orders
GROUP BY Day_name
ORDER BY round(SUM(total));



SELECT  DAY(date),
		count(*) as 'Total orders',
		SUM(quantity) as 'Total Quantity',
        round(SUM(cost)) as 'Total cost' ,
        round(SUM(total)) as 'Total Sales', 
		round((ROUND(SUM(total)) - LAG(ROUND(SUM(total))) OVER (ORDER BY DAY(date))) / ROUND(SUM(total))*100, 2) AS 'Sales Change Percentage'
FROM Orders
GROUP BY DAY(date)
ORDER BY DAY(date);


SELECT round(AVG(rating), 2)
FROM Orders;

-- ********************************************************************

-- Products

-- ********************************************************************

SELECT  product_category,
		count(*) as 'Total orders',
		SUM(quantity) as 'Total Quantity',
        round(SUM(cost)) as 'Total cost' ,
        round(SUM(total)) as 'Total Sales',
        round(AVG(rating))
FROM Orders
GROUP BY product_category
ORDER BY round(SUM(total)) desc ;

SELECT  Month(date) as 'Month',
		month_name, product_category,
		count(*) as 'Total orders',
		SUM(quantity) as 'Total Quantity',
        round(SUM(cost)) as 'Total cost' ,
        round(SUM(total)) as 'Total Sales', 
		round((ROUND(SUM(total)) - LAG(ROUND(SUM(total))) OVER (ORDER BY Month(date))) / ROUND(SUM(total))*100, 2) AS 'Sales Change Percentage'
FROM Orders
GROUP BY month, month_name, product_category
ORDER BY month;


SELECT  month_name, product_category,
		count(*) as 'Total orders',
		SUM(quantity) as 'Total Quantity',
        round(SUM(cost)) as 'Total cost' ,
        round(SUM(total)) as 'Total Sales'
        RANK() OVER (PARTITION BY month_name, product_category ORDER BY round(SUM(total)) DESC)
FROM Orders
GROUP BY month_name, product_category
ORDER BY round(SUM(total)) DESC


-- ********************************************************************

-- CUSTOMERS

-- *********************************************************************
SELECT customer_type, 
	COUNT(*) AS No_Of_Customers,
    round(SUM(total)) AS Sales
FROM Orders
GROUP BY customer_type;

SELECT gender, 
	COUNT(*) AS No_Of_Customers,
    round(SUM(total)) AS Sales
FROM Orders
GROUP BY gender;

SELECT customer_type, gender,
	COUNT(*) AS No_Of_Customers,
    round(SUM(total)) AS Sales
FROM Orders
GROUP BY customer_type, gender
ORDER BY customer_type

SELECT customer_type, city, branch_code,
	COUNT(*) AS No_Of_Customers,
    round(SUM(total)) AS Sales
FROM Orders
GROUP BY customer_type, city, branch_code
order by branch_code;

SELECT gender, city, branch_code,
	COUNT(*) AS No_Of_Customers,
    round(SUM(total)) AS Sales
FROM Orders
GROUP BY gender, city, branch_code
order by branch_code;

SELECT gender, product_category, SUM(quantity)
FROM Orders
GROUP BY gender, product_category
order by gender;


SELECT paymenttype,  COUNT(*) AS 'No_Of_Transactions',
	   ROUND(SUM(Total)) AS 'Total_Amount'
FROM Orders
GROUP BY paymenttype
ORDER BY ROUND(SUM(Total)) DESC;

SELECT gender, 
	   ROUND(AVG(rating), 2)
FROM Orders
GROUP BY gender;

SELECT customer_type, 
	   ROUND(AVG(rating), 2)
FROM Orders
GROUP BY customer_type;

-- ********************************************************************

-- Branch

-- ********************************************************************

SELECT  branch_code, city,
		count(*) as 'Total orders',
		SUM(quantity) as 'Total Quantity',
        round(SUM(cost)) as 'Total cost' ,
        round(SUM(total)) as 'Total Sales' 
FROM Orders
GROUP BY branch_code, city
ORDER BY round(SUM(total)) desc ;


select * from orders
SELECT  branch_code, product_category,
		count(*) as 'Total orders',
		SUM(quantity) as 'Total Quantity',
        round(SUM(cost)) as 'Total cost' ,
        round(SUM(total)) as 'Total Sales' 
FROM Orders
GROUP BY branch_code, product_category
ORDER BY  branch_code;

SELECT branch_code, paymenttype,  COUNT(*) AS 'No_Of_Transactions',
	   ROUND(SUM(Total)) AS 'Total_Amount'
FROM Orders
GROUP BY branch_code, paymenttype
ORDER BY branch_code ;

SELECT branch_code, 
	   ROUND(AVG(rating), 2)
FROM Orders
GROUP BY branch_code;













