# Retail-Sales---Project-1 (MySQL Workbench)

**Project Overview**
**Project Title:** Retail Sales Analysis
**Database**: Retailsale

The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

**Objectives**
**Set up a retail sales database:** Create and populate a retail sales database with the provided sales data.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

# Project Structure
## 1. Database and Table Setup
**Database Creation:** The project starts by creating a database named Retailsale.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

##### Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
```sql
SELECT * FROM Retail_sales
WHERE Sale_date = "2022-11-05";
```

##### Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
```sql
SELECT * FROM Retail_Sales
WHERE Category = "Clothing" and Quantity >= 4 and Sale_date LIKE "2022-11%";
```

 ##### Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
```sql
SELECT Category,SUM(Total_Sale) as net_sale, Count(*) as Total_orders FROM retail_sales
GROUP BY Category;
```

##### Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
```sql
SELECT ROUND(avg(age),2) as Average_age FROM retail_Sales
WHERE Category = "Beauty";
```

##### Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

##### Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
```sql
SELECT Category,Gender,Count(Transactions_id) as total_Transactions FROM Retail_sales
GROUP BY Category, Gender
ORDER BY Total_Transactions ASC;
```

##### Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
```sql
SELECT Year,Month,Round(Avg_sale,2) FROM (
SELECT 
	extract(YEAR FROM sale_date) as year,
	extract(MONTH FROM sale_date) as Month,
	AVG(total_sale) as Avg_sale,
  RANK() OVER(Partition by extract(YEAR FROM Sale_date) ORDER BY AVG(total_sale) DESC) as Ranking
From Retail_sales
GROUP BY YEAR, MONTH
ORDER BY Year, AVG_sale DESC) as T1
WHERE Ranking = 1;
```

##### Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
```sql
SELECT customer_id, Sum(total_sale) as total_sale FROM retail_sales
GROUP BY Customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

##### Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
```sql
SELECT Category, Count(Distinct customer_id) as Count_of_unique_Customer FROM retail_sales
GROUP BY Category;
```

##### Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).
```sql
SELECT shift, count(*) as total_Orders FROM (
SELECT *,
	CASE 
		WHEN extract(Hour From sale_time) < 12 THEN "Morning"
		WHEN extract(Hour From sale_time) BETWEEN 12 and 17 THEN "Afternoon"
		ELSE "Evening"
	END AS Shift
FROM retail_sales) as T1
GROUP BY Shift;
```

-- End of Project --












