/* =====================================================
   PROJECT: SALES DATA ANALYSIS
   DATABASE: sales_project
   ===================================================== */

-------------------------------------------------------
-- 1. CREATE DATABASE
-------------------------------------------------------

CREATE DATABASE IF NOT EXISTS sales_project;

USE sales_project;

-------------------------------------------------------
-- 2. CREATE TABLE
-------------------------------------------------------

CREATE TABLE IF NOT EXISTS sales_data (
    `Row ID` INT PRIMARY KEY,
    `Order ID` VARCHAR(50),
    `Order Date` DATETIME,
    `Ship Date` DATETIME,
    `Ship Mode` VARCHAR(50),
    `Customer ID` VARCHAR(50),
    `Customer Name` VARCHAR(100),
    `Segment` VARCHAR(50),
    `Country` VARCHAR(100),
    `City` VARCHAR(100),
    `State` VARCHAR(100),
    `Postal Code` INT,
    `Region` VARCHAR(50),
    `Product ID` VARCHAR(100),
    `Category` VARCHAR(50),
    `Sub-Category` VARCHAR(50),
    `Product Name` VARCHAR(255),
    `Sales` DOUBLE,
    `Quantity` INT,
    `Discount` DOUBLE,
    `Profit` DOUBLE,
    `Order Year` INT,
    `Order Month` INT
);

-------------------------------------------------------
-- 3. LOAD CSV DATA INTO TABLE
-------------------------------------------------------

LOAD DATA INFILE 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_superstore.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-------------------------------------------------------
-- 4. DATA VALIDATION
-------------------------------------------------------

-- Total number of rows
SELECT COUNT(*) AS total_rows
FROM sales_data;

-- Preview first few records
SELECT *
FROM sales_data
LIMIT 10;

-------------------------------------------------------
-- 5. BASIC BUSINESS METRICS
-------------------------------------------------------

-- Total Sales
SELECT 
ROUND(SUM(Sales),2) AS total_sales
FROM sales_data;

-- Total Profit
SELECT 
ROUND(SUM(Profit),2) AS total_profit
FROM sales_data;

-- Total Orders
SELECT 
COUNT(*) AS total_orders
FROM sales_data;

-- Average Order Value
SELECT 
ROUND(AVG(Sales),2) AS avg_order_value
FROM sales_data;

-------------------------------------------------------
-- 6. SALES ANALYSIS BY CATEGORY
-------------------------------------------------------

-- Sales by Category
SELECT 
Category,
ROUND(SUM(Sales),2) AS total_sales
FROM sales_data
GROUP BY Category
ORDER BY total_sales DESC;

-- Profit by Category
SELECT 
Category,
ROUND(SUM(Profit),2) AS total_profit
FROM sales_data
GROUP BY Category
ORDER BY total_profit DESC;

-------------------------------------------------------
-- 7. REGIONAL PERFORMANCE ANALYSIS
-------------------------------------------------------

-- Sales by Region
SELECT 
Region,
ROUND(SUM(Sales),2) AS total_sales
FROM sales_data
GROUP BY Region
ORDER BY total_sales DESC;

-- Profit by Region
SELECT 
Region,
ROUND(SUM(Profit),2) AS total_profit
FROM sales_data
GROUP BY Region
ORDER BY total_profit DESC;

-------------------------------------------------------
-- 8. PRODUCT PERFORMANCE ANALYSIS
-------------------------------------------------------

-- Top 10 products by Sales
SELECT 
`Product Name`,
ROUND(SUM(Sales),2) AS total_sales
FROM sales_data
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 products by Profit
SELECT 
`Product Name`,
ROUND(SUM(Profit),2) AS total_profit
FROM sales_data
GROUP BY `Product Name`
ORDER BY total_profit DESC
LIMIT 10;

-- Top 10 loss-making products
SELECT 
`Product Name`,
ROUND(SUM(Profit),2) AS total_profit
FROM sales_data
GROUP BY `Product Name`
ORDER BY total_profit ASC
LIMIT 10;

-------------------------------------------------------
-- 9. TIME-BASED SALES ANALYSIS
-------------------------------------------------------

-- Monthly Sales Trend
SELECT 
`Order Year`,
`Order Month`,
ROUND(SUM(Sales),2) AS monthly_sales
FROM sales_data
GROUP BY `Order Year`,`Order Month`
ORDER BY `Order Year`,`Order Month`;

-------------------------------------------------------
-- 10. SAMPLE DATA CHECK
-------------------------------------------------------

-- View unique product names
SELECT DISTINCT `Product Name`
FROM sales_data
LIMIT 20;