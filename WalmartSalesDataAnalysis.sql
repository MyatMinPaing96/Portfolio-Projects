SELECT * FROM salesdatawalmart.sales;

-- FINDING DUPLICATES

SELECT invoice_id , COUNT(*)
FROM sales
GROUP BY invoice_id
HAVING COUNT(*) > 1;

SELECT COUNT(*)
FROM sales;

-- Add a column for time of day 
SELECT 
	time,
    (CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
        END
	) AS time_of_date
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
        END
);

-- Add a column for Day's Name

SELECT date,
dayname(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_names VARCHAR(20);

UPDATE sales 
SET day_names = dayname(date);

-- Add a column for Month's Name

SELECT date,
monthname(date) AS MONTH_NAME
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

----------------------------------------------------------------------------


--  How many unique cities does the data have?

SELECT DISTINCT city
FROM sales;

-- In which city is each branch?

SELECT DISTINCT branch
FROM sales;

SELECT DISTINCT city,branch 
FROM sales;

-- -----------------------------------------------------

-- How many unique product lines does the data have?
SELECT 
	COUNT(DISTINCT product_line)
FROM sales;

-- What is the most common payment method?
SELECT
	payment_method,
    COUNT(payment_method) as cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;

-- What is the most selling product line?

SELECT 
	product_line,
    COUNT(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total revenue by month?

SELECT 
	month_name AS month,
    SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGS?

SELECT 
	month_name AS month,
    SUM(cogs) AS Total_COGS
FROM sales
GROUP BY month
ORDER BY Total_COGS DESC
LIMIT 1
;

-- What product line had the largest revenue?

SELECT 
	product_line,
    SUM(total) As Total_Revenue
FROM sales
GROUP BY product_line
ORDER BY Total_Revenue DESC
LIMIT 1
;

-- What is the city with the largest revenue?

SELECT
	city,
    SUM(total) As Total_Revenue
FROM sales
GROUP BY city
ORDER BY Total_Revenue DESC;

-- What product line had the largest VAT?

SELECT 
	product_line,
    SUM(VAT) as Total_VAT
FROM sales
GROUP BY product_line
ORDER BY Total_VAT DESC;

-- -----------------------------------------------------
-- SALES ANALYST
-- -----------------------------------------------------

-- Number of sales made in each time of the day per weekday

SELECT 
	time_of_day,
    SUM(total) As Total_Sales
FROM sales
GROUP BY time_of_day
ORDER BY Total_Sales;

-- Which of the customer types brings the most revenue?

SELECT 
	customer_type,
    SUM(total) As Total_Revenue
FROM sales
GROUP BY customer_type
ORDER BY Total_Revenue DESC;

-- Which customer type pays the most in VAT?

SELECT 
	customer_type,
    SUM(VAT) as Total_VAT
FROM sales
GROUP BY customer_type
ORDER BY Total_VAT DESC
;


-- ---------------------------------------------------
-- CUSTOMER
-- ---------------------------------------------------

-- How many unique customer types does the data have?

SELECT 
	DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?

SELECT 
	DISTINCT payment_method
FROM sales;

-- What is the most common customer type?

SELECT 
	customer_type,
    COUNT(*) as cnt
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?

SELECT 
	gender,
    COUNT(*) AS cnt
FROM sales
GROUP BY gender;

-- Which time of the day do customers give most ratings?

SELECT
	time_of_day,
    AVG(rating) as AVG_Rating
FROM sales
GROUP BY time_of_day
ORDER BY AVG_Rating DESC;


-- Which day fo the week has the best avg ratings?

SELECT 
	day_names,
    AVG(rating) AS Avg_Rating
FROM sales
GROUP BY day_names
ORDER BY Avg_Rating DESC;


