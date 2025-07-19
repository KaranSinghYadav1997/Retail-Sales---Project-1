CREATE DATABASE Retailsale;
USE Retailsale;

CREATE TABLE retail_sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

Select * From retail_sales;
Select count(*) From retail_sales;


-- How many sales we have?
Select count(total_sale) from retail_sales;

-- How many unique customers we have?
Select count(distinct Customer_id) from retail_sales;	


-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM Retail_sales
WHERE Sale_date = "2022-11-05";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
SELECT * FROM Retail_Sales
WHERE Category = "Clothing" and Quantity >= 4 and Sale_date LIKE "2022-11%";

 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT Category,SUM(Total_Sale) as net_sale, Count(*) as Total_orders FROM retail_sales
GROUP BY Category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(avg(age),2) as Average_age FROM retail_Sales
WHERE Category = "Beauty";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT Category,Gender,Count(Transactions_id) as total_Transactions FROM Retail_sales
GROUP BY Category, Gender
ORDER BY Total_Transactions ASC;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT Year,Month,Avg_sale FROM (
SELECT 
	extract(YEAR FROM sale_date) as year,
	extract(MONTH FROM sale_date) as Month,
	AVG(total_sale) as Avg_sale,
    RANK() OVER(Partition by extract(YEAR FROM Sale_date) ORDER BY AVG(total_sale) DESC) as Ranking
From Retail_sales
GROUP BY YEAR, MONTH
ORDER BY Year, AVG_sale DESC) as T1
WHERE Ranking = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, Sum(total_sale) as total_sale FROM retail_sales
GROUP BY Customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT Category, Count(Distinct customer_id) as Count_of_unique_Customer FROM retail_sales
GROUP BY Category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT shift, count(*) as total_Orders FROM (
SELECT *,
	CASE 
		WHEN extract(Hour From sale_time) < 12 THEN "Morning"
		WHEN extract(Hour From sale_time) BETWEEN 12 and 17 THEN "Afternoon"
		ELSE "Evening"
	END AS Shift
FROM retail_sales) as T1
GROUP BY Shift;

        
-- End of Project --

























