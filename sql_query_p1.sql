--SQL Retail sales analysis - P1
Create database SQL_Project_p2;

--Create Table
	Drop table if exists Retail_Sales;
Create table Retail_Sales(
              transactions_id int Primary key,
              sale_date Date ,
			  sale_time Time,	
			  customer_id Int,	
			  gender Varchar(10),	
			  age Int,	
			  category varchar(30),
			  quantiy Int,	
			  price_per_unit Float,
			  cogs Float,
			  total_sale Float
);
Select * from Retail_Sales
Limit 10
Select Count(*) from Retail_Sales;

---Check for null values
Select * from Retail_Sales
Where transactions_id= null;

Select * from Retail_Sales
Where sale_date= null;

Select * from Retail_Sales
Where sale_time= null;

Select * from Retail_Sales
Where customer_id= null;

--Finding null from multiple columns
Select * from Retail_Sales
Where 
transactions_id is null
OR
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
OR
age is null
OR
category is null
OR
quantiy is null 	
OR
price_per_unit is null
OR
cogs is null
OR
total_sale is null;

--Delete null value rows

Delete from Retail_Sales
Where 
transactions_id is null
OR
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
OR
age is null
OR
category is null
OR
quantiy is null 	
OR
price_per_unit is null
OR
cogs is null
OR
total_sale is null;

--Data exploration

--How many sales we have?
Select count(*) as total_sale from Retail_Sales

--How many customers we have(Unique)
Select count(Distinct customer_id) as total_sale from Retail_Sales
155

--How many categories are there
Select Distinct category from Retail_Sales
3

Alter table retail_sales
Rename column quantiy to quantity;

--Data analysis and business key problems and answers
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
Select * from Retail_Sales Where sale_date = '2022-11-05';
Select * from Retail_Sales Where sale_date = '2022-11-05'
Order by transactions_id ASC;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-
Select * from Retail_Sales
Where
category='Clothing'
AND
Sale_date>= Date '2022-11-01'
AND Sale_date< Date '2022-12-01'
AND quantity>=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
Select category, sum(total_sale)as net_sales,Count(*) as total_orders
from retail_sales
Group by Category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
Select AVG(age) as Avg_age from Retail_Sales
Where category='Beauty';
--other one
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
Select * from Retail_Sales
where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
Select gender, category, count(transactions_id) as total_orders
From Retail_Sales
Group by gender, category;

- other way below

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
Select 
TO_CHAR(sale_date, 'YYYY-MM') as year_month,
avg(total_sale) as avg_sale
From retail_sales
Group by TO_CHAR(sale_date, 'YYYY-MM')
order by year_month;

--OTHER WAY BELOW

SELECT 
    TO_CHAR(sale_date, 'YYYY-MM') AS year_month,
    AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY year_month ASC;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
Select customer_id, Max(total_sale) as Highest_sale
From retail_sales
Group by customer_id
Order by Highest_sale DESC
Limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
Select category, Count (distinct customer_id) AS Unique_cust
From retail_sales
Group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) > 12 
             AND EXTRACT(HOUR FROM sale_time) <= 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift
ORDER BY shift;

--To calculate total sales is high or low
Select total_sale,
Case
When total_sale>1000 then 'high'
When total_sale>500 then 'medium'
else 'low'
End as sale_category
From Retail_sales
Order by total_sale Asc

---End of project