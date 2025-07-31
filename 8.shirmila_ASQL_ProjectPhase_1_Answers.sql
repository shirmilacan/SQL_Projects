/*
======================================
 Advanced SQL Project Phase I
 Name: Shirmila Hewapathirana
======================================

SQL DESCRIPTIVE AND POPULAR INTERVIEW QUESTIONS

1.What is the difference between Primary Key (PK) and Foreign Key (FK)?

A Primary Key (PK):
-------------------
is a column or set of columns in a table that uniquely identifies each row in that table. 
It cannot contain NULL values, and each value must be unique within the table.

A Foreign Key (FK): 
-------------------
is a column or set of columns in one table that references the Primary Key in another table. 
It is used to establish and enforce a link between the data in the two tables, ensuring referential integrity

Summary:
--------

Feature			 Primary Key (PK)					Foreign Key (FK)
--------		 ----------------					-------------------
Uniqueness		 Must be unique within its table	Can have duplicate values
Null Values		 Not allowed						Allowed (unless specified otherwise)
Purpose	Uniquely identifies each row				Establishes relationship with another table
Relationship	 Defined within the table			References PK in another table

---------------------------------------------------------------------------------------------------
2.What is the difference between a View, a Table, and a Temporary Table?

Table: 
------
A physical storage structure in the database that holds persistent data.

View : 
------
A virtual table based on a SQL query. It does not store data itself but presents 
data from one or more tables through a saved SELECT statement. No data is stored 
unless it is a materialized view.

Temporary Table: 
----------------
A table that exists temporarily during a session or transaction. 
It is used to store intermediate results and is deleted automatically 
when the session ends

Summary:
--------

Feature				Table		View							Temporary Table
-------				------		-----							----------------
Storage	Physical,	persistent	Virtual, no data stored			Physical, session-based
Lifetime			Permanent	Permanent (definition only)		Temporary (session/transaction)
Use Case			Store data	Simplify complex queries		Store intermediate results

---------------------------------------------------------------------------------------------------
3.What is the difference between Clustered and Non-clustered Indexes?

Clustered Index: 
----------------
Determines the physical order of data in the table. Each table can have only one clustered 
index because the data rows themselves can be sorted in only one order. The data rows are 
stored on disk in the same order as the clustered index.

Non-clustered Index: 
--------------------
Maintains a separate structure from the data rows. It contains index key values and pointers 
(row locators) to the actual data rows. A table can have multiple non-clustered indexes

Summary:
--------

Feature				Clustered Index							Non-clustered Index
--------			---------------							--------------------
Data Storage		Sorts and stores data rows physically	Separate structure from data rows
Number per Table	Only one								Multiple allowed
Use Case			Fast retrieval by primary key			Fast retrieval by other columns

---------------------------------------------------------------------------------------------------
4.What is the difference between Stored Procedures and Functions?

Stored Procedure: 
-----------------
A group of SQL statements that can perform operations such as data modification, business logic, 
and transaction management. It can return zero, one, or multiple values and supports input/output 
parameters. Stored procedures cannot be used directly in SELECT statements.

Function: 
--------
Returns a single value or a table and is generally used for computations. Functions can be used 
within SELECT statements and only accept input parameters. They cannot perform data modification 
operations or manage transactions

Summary:
--------

Feature					Stored Procedure				Function
-------					----------------				---------
Return Value			Zero, one, or multiple values	Single value (scalar) or table
Use in SELECT			No								Yes
Data Modification		Yes								No
Transaction Support		Yes								No
Input/Output Params		Both							Input only

---------------------------------------------------------------------------------------------------
5.What is the ACID property in a database?

Atomicity: 
----------
Each transaction is all-or-nothing—either all operations succeed, or none do.

Consistency: 
------------
Transactions bring the database from one valid state to another, maintaining 
all predefined rules.

Isolation: 
----------
Concurrent transactions do not interfere with each other; intermediate states 
are not visible to other transactions.

Durability: 
-----------
Once a transaction is committed, its results are permanent, even in the event 
of a system failure

These properties ensure reliable, predictable, and safe database transactions


SQL CODING QUESTIONS
Shopify co-op interview questions:
use the following link to write a query for following question:
https://www.w3schools.com/SQL/TRYSQL.ASP?FILENAME=TRYSQL_SELECT_ALL

*/
select * from ShopifyCategories
select * from ShopifyEmployees
select * from ShopifyOrderDetails
select * from ShopifyOrders
select * from ShopifyProducts
select * from ShopifyShippers
select * from ShopifySuppliers
select * from ShopyfyCustomers




--1.How many orders were shipped by Speedy Express in total?
select	s.ShipperName as Shipper_Name, 
		count(o.ShipperID) as Order_Count
FROM ShopifyOrders as o 
join ShopifyShippers as s on s.ShipperID = o.ShipperID
where s.ShipperName = 'Speedy Express'
group by s.ShipperName;

--2.What is the last name of the employee with the most orders?
select top 1 
	e.LastName, 
	count(o.employeeid) as [# most orders]
from ShopifyOrders as o join ShopifyEmployees e
on e.EmployeeID = o.EmployeeID 
group by e.LastName
order by count(o.EmployeeID) desc;

--3.What product was ordered the most by customers in Germany?
select	top 1 
	od.ProductID as ProductID, 
	p.ProductName as Produst_name,
	SUM(od.quantity) as mostOrderedProductQty
from ShopifyOrderDetails as od
left join shopifyOrders as o on o.OrderID = od.OrderID
left join ShopifyProducts as p on p.ProductID = od.ProductID
left join ShopyfyCustomers c on c.customerID = o.customerID
where c.country = 'Germany'
group by od.ProductID, p.ProductName
order by mostOrderedProductQty desc;

-----------------------------------------------------------------------
/*
Bank  Analysis Task:
---------------------
XYZ.Activity_checking Dataset:*/
create table activity_checking
(
Obs int primary key, 
Client_ID int, 
Account_ID int, 
Open_Date date, 
Assets int, 
Status varchar(10)
);

INSERT INTO activity_checking 
(Obs, Client_ID, Account_ID, Open_Date, Assets, Status) 
VALUES
    (1, 1001, 20032, '2019-11-02', 7744, 'Active'),
    (2, 1002, 20056, '2020-12-12', -12451, 'Inactive'),
    (3, 1003, 20032, '2019-01-12', 1274, 'Active'),
    (4, 1003, 20074, '2019-01-19', 7683, 'Active'),
    (5, 1002, 20793, '2017-09-17', -591, 'Active'),
    (6, 1004, 20142, '2017-02-16', 14144, 'Active'),
    (7, 1005, 21943, '2016-10-24', 13981, 'Active'),
    (8, 1006, 29371, '2008-06-09', 14049, 'Inactive'),
    (9, 1002, 29081, '2018-04-05', 2092, 'Active');


create table Activity_creditcard
(Obs int primary key, 
Client_ID int, 
Account_ID int, 
Open_Date date, 
Credit_Status varchar(10), 
Assets int
);

insert into Activity_creditcard
(Obs, Client_ID, Account_ID, Open_Date, Credit_Status, Assets)
values
(1,	1003,313058,'2015-12-17','Active',-4059),
(2,	1004,339524,'2019-01-16','Active',-4327),
(3,	1002,330572,'2019-09-26','Active',15392),
(4,	1003,396821,'2020-02-07','Inactive',-1359),
(5,	1004,375271,'2018-03-15','Active',-1601),
(6,	1003,373859,'2020-09-09','Active',16515),
(7,	1006,383733,'2017-11-08','Inactive',5226),
(8,	1006,353413,'2018-03-16','Inactive',13741),
(9,	1005,365605,'2017-06-25','Active',-4110)

select * from activity_checking
select * from Activity_creditcard

--Task: 
--Create a Summary Report Tracking KPI Metrics
--For each active client, create a summary report with the following metrics:
--1. XYZ_Since_Date: The first date when the customer started a relationship 
--   with XYZ (earliest Open_Date from both datasets).
select 
	a.Client_ID,  
	min(a.open_date) as Since_Date
from
(
	select client_id,  open_date 
	from activity_checking
	where Status = 'Active'

	union all 

	select client_id,  open_date 
	from activity_creditcard
	where credit_Status = 'Active'
) 
as a
group by a.client_id
;

--2. Product1_Since_Date: The first date when the customer joined Product1 
--   (checking accounts).
select 
	client_id, 
	MIN(open_date) as Product1_Since_Date
from activity_checking
group by Client_ID
order by client_id, Product1_Since_Date

--EXTRA: above answer only for acrive accounts
select 
	client_id, 
	MIN(open_date) as Product1_Since_Date
from activity_checking
where Status = 'Active'
group by Client_ID
order by client_id, Product1_Since_Date

--3. Product2_Since_Date: The first date when the customer joined Product2 
--   (credit card accounts).
select 
	client_id, 
	MIN(open_date) as Product2_Since_Date
from Activity_creditcard
group by Client_ID
order by client_id, Product2_Since_Date

--EXTRA: above answer only for acrive accounts
select 
	client_id, 
	MIN(open_date) as Product2_Since_Date
from Activity_creditcard
where Credit_Status = 'Active'
group by Client_ID
order by client_id, Product2_Since_Date

--4. Total_Actives: The total number of active accounts under the customer.
select 
	a.client_id, 
	COUNT(distinct(a.account_id)) as count
from
(
	select c.client_id,  c.Account_ID, c.Status
	from activity_checking c
	where c.Status = 'Active'

	union all 

	select cc.client_id,  cc.Account_ID, cc.Credit_Status
	from activity_creditcard cc
	where cc.credit_Status = 'Active'
) as a
group by a.Client_ID

--5. Total_Assets: The total assets for each customer.
select 
	Client_ID,	
	SUM(assets) as Total_Assets
from activity_checking
group by Client_ID

--6. Explain how you would create and insert data into the tables provided for 
--   the XYZ activity datasets.

--When creating a table first give it a name then add required attributes and give it names and assign correct data type.
--next, input data into the created table.
--general syntax is as follows;

create table activity_checking1
(
obs int primary key, 
client_id int, 
Account_id int,
open_date date, 
assets int, 
status varchar(10)
);
insert into activity_checking1		
(obs, client_id, Account_id, open_date, assets, status)
values								
(9,1007,29372,'2025-06-07', 2520, 'Active'),
(10,1008,29373,'2025-06-05', 25020, 'Active')

---activity_creditcard1
create table activity_creditcard1
(obs			int, 
client_id		int, 
account_id		int, 
open_date		date, 
credit_status	varchar(10), 
assets			int)

insert into activity_creditcard1
(obs, client_id, account_id, open_date, credit_status, assets)
values
(1, 2001, 123, '2025-06-01', 'Active', -2256),
(2, 2002, 124, '2025-06-02', 'Inactive', -56456);

--7. How would you track the first relationship date (XYZ_Since_Date) for a 
--   customer across both checking and credit card datasets?
/*
To track the first relationship date (XYZ_Since_Date) for a customer across 
both checking and credit card datasets, we can use the MIN(open_date) function 
while combining data from both tables.

Approach
we need to:
- Merge the two datasets (activity_checking and activity_creditcard).
- Identify the earliest open_date for each client_id across both datasets.
- Use GROUP BY and MIN(open_date) to extract the first relationship date
*/
select client_id, min(open_date) as Since_Date
from 
(
    select client_id, open_date from activity_checking
    union all
    select client_id, open_date from activity_creditcard
) as combined_data
group by client_id;

--8. Describe the SQL query you would write to find the first date a customer 
--   joined Product1 (checking accounts).
--here the goal is to find the earliest 'Open_date' a customer opened an account
--Hence, I need to find the date minimum 'open_date' inrespect of each 'client_id'. 
--by grouping the result by client_id it avoids duplicates
--I can use below chunk of code to achieve that goal.

select Client_ID, MIN(open_date) as Since_Date
from activity_checking
group by Client_ID

--9. How can you calculate the total number of active accounts for each client 
--   using data from both datasets?
--Here my goal is to count active accounts per each customer(group by client_id)
--first I need to filter active accounts in both the tables
--then I can merge both tables as i need to count accounts in both the tables
--Here to achieve this I can count account_id and group by client_id to achieve this goal,
--as a precaution to avoid counting duplicated account_IDs, if any in the table, I used distinct(account_id)

select 
a.client_id, 
count(distinct(a.account_id)) as No_of_accounts
from
(
select 
c.client_id, 
c.account_id, 
c.status
from activity_checking as c
where c.Status = 'Active'

union

select 
cc.client_id, 
cc.account_id, 
cc.credit_status
from activity_creditcard as cc
where cc.Credit_Status = 'Active'
) 
as a
group by a.Client_ID

--10.What approach would you use to calculate the total assets for each client, 
--   considering both positive and negative asset values?
--To achieve this, I can merger 2 tables first and then total the assets (+ve and -ve) for each client 
--
select a.Client_ID, sum(a.assets) as TotalAsets
from (
select c.client_id, c.assets
from activity_checking as c

union

select cc.Client_ID, cc.assets
from Activity_creditcard as cc
) as a
group by a.client_id

--11.How would you optimize your SQL queries to handle large datasets efficiently?
/*
- Select only necessary columns (avoid SELECT *).
- Use indexes smartly:
  For example, adding CREATE INDEX idx_client_id ON activity_checking(client_id); speeds up lookups and joins.
- Use proper filtering with WHERE to reduce the number of rows.
- Limit the result set using LIMIT / TOP for previews.
- Avoid nested subqueries where joins or Common Table Expressions(CTEs) (WITH statements) can be used instead.
- Use EXPLAIN PLAN to understand and troubleshoot query performance.
- Partition large tables for more efficient reads.
- Avoid functions on indexed columns in the WHERE clause
*/
--12.What methods can you use to handle missing data or inconsistencies when 
--   generating reports from these datasets?
/*
- Use COALESCE() or ISNULL() to replace NULL values with defaults:
  SELECT COALESCE(salary, 0) AS salary FROM employees;
- Filter out NULLs using WHERE column IS NOT NULL.
- Use conditional logic with CASE WHEN to flag or clean inconsistent values.
- Data validation rules can be applied during ETL to catch and fix anomalies.
- Deduplicate using ROW_NUMBER() or DISTINCT if duplicate records exist.
- Create views with cleaned or defaulted values for consistent reporting
*/

--13.Describe how you can join multiple tables in SQL to create a consolidated 
--   report for customer metrics.
/*
Example Use Case:
Suppose we have:
	customers(customer_id, name)
	orders(order_id, customer_id, order_date)
	payments(payment_id, order_id, amount)

we can use JOINs like below:
*/
SELECT 
    c.customer_id,
    c.name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.amount) AS total_payments
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.name;
--This consolidated report shows order counts and total payments per customer.

--14.What indexing strategies would you recommend to improve query performance 
--   in this scenario?
--Primary keys and foreign keys should always be indexed.
--Composite indexes on frequently filtered or joined columns:
  CREATE INDEX idx_customer_order ON orders(customer_id, order_date);

--15.How can SQL aggregate functions like SUM, MIN, and COUNT help in calculating 
--   the required KPIs?
/*
Uses of Aggregates in KPI Reporting:
SUM: Total revenue, total payments, or total sales..
MIN / MAX: Earliest and latest order date, or minimum and maximum transaction value.
COUNT: Number of orders, customers, or product returns.
*/
SELECT 
    COUNT(*) AS total_customers,
    SUM(sales_amount) AS total_revenue,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM orders;
--These functions help derive meaningful business metrics from raw transactional data.

--Product Sales Analysis Task:
------------------------------
--You are provided with the following sample data tables:

--Table 1: Product Sales Data
CREATE TABLE Product_Sales1 (
    product INT,
    no INT,
    q INT,
    price DECIMAL(10, 2)
);

INSERT INTO Product_Sales1 
VALUES
(23, 3, 12, 250.00),
(23, 15, 24, 450.00),
(23, 25, 16, 346.00),
(46, 45, 25, 560.00);

--Table 2: Additional Product Sales Data
CREATE TABLE Product_Sales2 (
    product INT,
    no INT,
    price DECIMAL(10, 2)
);

INSERT INTO Product_Sales2 
VALUES
(46, 23, 250.00),
(27, 15, 450.00),
(37, 25, 36.00),
(46, 50, 700.00);

--POS Tables: Sales Data

--POS1 Table:
CREATE TABLE POS1 (
    date DATE,
    sales DECIMAL(10, 2),
    product INT,
    no INT
);

INSERT INTO POS1 VALUES
('2001-01-22', 250.00, 23, 3),
('2002-01-22', 300.00, 27, 15);

--POS2 Table:
CREATE TABLE POS2 (
    date DATE,
    sales DECIMAL(10, 2),
    product INT,
    no INT
);

INSERT INTO POS2 VALUES
('2001-01-22', 280.00, 23, 3),
('2002-01-22', 150.00, 37, 25);

--POS3 Table:
CREATE TABLE POS3 (
    date DATE,
    sales DECIMAL(10, 2),
    product INT,
    no INT
);

INSERT INTO POS3 VALUES
('2001-01-22', 280.00, 23, 3),
('2002-01-22', 400.00, 27, 15);

--SQL Questions for Product Sales Analysis:
-----------------------------------------
--1.Find Duplicates: Write a query to identify common products 
--	and records duplicated between Table 1 and Table 2.

--In these 2 tables we only have 3 common columns which are products, no and price
--hence, I can inner join these 2 tables based on 2 of these columns to find whether there is any duplicate record.

SELECT *
--ps1.product, 
--ps1.no
FROM Product_Sales1 ps1
INNER JOIN Product_Sales2 ps2
ON ps1.product = ps2.product AND ps1.no = ps2.no;

----METHOD:2---------
SELECT
    product,
    no,
    COUNT(*) AS duplicates
FROM (
    SELECT product, no FROM Product_Sales1
    UNION ALL
    SELECT product, no FROM Product_Sales2
) AS uniontable
GROUP BY product, no
HAVING COUNT(*) > 1;

select * from Cleaned_Table
select * from Merged_Table

--However, if the question meant us to find the instances where 
--procuct has reflected in many occations my answer is as follows;
select a.product, count(a.product) as Count_of_Prod
from (
SELECT product, no, price FROM Product_Sales1
union all
select product, no, price from Product_Sales2
) as a
group by a.product
having count(a.product) >1

--2.Merge Tables: Write a query to merge the two product tables, 
--	including duplicate records, into a new table (Merged_Table).

CREATE TABLE Merged_Table (
    product INT,
    no INT,
    q INT,
    price DECIMAL(10, 2)
);

INSERT INTO Merged_Table
SELECT product, no, q, price FROM Product_Sales1
UNION ALL
SELECT product, no, NULL AS q, price FROM Product_Sales2;

select * from Merged_Table
--drop table Merged_Table

--3.Remove Duplicates: Write a query to create a new table (Cleaned_Table) 
--	by removing duplicate records from Merged_Table.
create table Cleaned_Table (
    product int,
    no int,
    q int,
    price decimal(10, 2)
);

insert into Cleaned_Table
select 
distinct product, 
no, 
q, 
price 
from Merged_Table;

select * from Cleaned_Table
select * from Merged_Table
--there is no change as there are no duplicates

--4.Sales Summary: Create a temporary table to calculate the sum of sales 
--	for each product on each date using data from POS1, POS2, and POS3.

CREATE TABLE #Temp_Sales_Summary (
    date DATE,
    product INT,
    total_sales DECIMAL(10, 2)
);

insert into #Temp_Sales_Summary
select date, product, SUM(sales) as total_sales
from (
    select date, product, sales from POS1
    union all
    select date, product, sales from  POS2
    union all
    select date, product, sales from POS3
) as combined_sales
group by date, product;

select * from #Temp_Sales_Summary

--5.Sales Aggregation: Write a query to calculate the total sales for 
--	each product across all dates using the temporary sales table created 
--	in the previous step.
select 
product, 
sum(total_sales) as Total_Sales
from #Temp_Sales_Summary
group by product

--6.Sales Report: Generate a report that lists each product along with:
----- Total sales (from all POS tables),
----- Total distinct transaction dates,
----- Average sales per transaction.
select 
    product,
    SUM(sales) as total_sales,
    count (distinct date) as total_distinct_transaction_dates,
    AVG(sales) AS avg_sales_per_transaction
from (
    select date, product, sales from POS1
    union all
    select date, product, sales from POS2
    union all
    select date, product, sales from  POS3
) as combined_sales
group by product;


--Bank Analysis Task: Transaction and Account Management Analysis
/*
You are provided with the following sample data:
------------------------------------------------
Txn_tbl:
Obs	customer_id	txn_id	Txn_type_key	amount
1	1			1001	3125			100
2	1			1002	3124			50
3	2			1003	3546			200
4	1			1004	3543			50
5	3			1005	14				30
6	2			1006	3125			20
7	2			1007	3600			10
8	1			1008	1600			20

Transaction Type Classification:
Credit Types: 
3125, 3124, 3600, 4500, 6577, 8900

Debit Types:
3546, 3543, 14, 1600, 8700, 8888

Account_tbl:
customer_id	account_id	create_date
1			101			01SEP2022
1			102			15NOV2023
1			103			01JAN2025
2			104			22OCT2018
3			105			18SEP2020

*/
create table Txn_tbl
(Obs int, 
customer_id	int, 
txn_id	int,  
Txn_type_key	
int, 
amount decimal(10,2));

insert into txn_tbl
values
(1,	1, 1001, 3125, 100),
(2,	1, 1002, 3124, 	50),
(3,	2, 1003, 3546, 	200),
(4,	1, 1004, 3543,	50),
(5,	3, 1005, 14, 30),
(6,	2, 1006, 3125, 20),
(7,	2, 1007, 3600, 10),
(8,	1, 1008, 1600, 20);

create table Account_tbl
(customer_id int, 
account_id int, 
create_date date);

insert into  Account_tbl
values
(1,	101, '2022-09-01'),
(1,	102, '2023-11-15'),
(1,	103, '2025-01-01'),
(2,	104, '2018-10-22'),
(3,	105, '2020-09-18');

--SQL Questions for Transaction and Account Management:

--1.Write a query to find the most recent account_id for each customer 
--  based on the create_date.

select customer_id, account_id as Most_recent_accountID, create_date
from Account_tbl
where create_date = 
(select 
	max(create_date) 
	from Account_tbl as a 
	where a.customer_id = Account_tbl.customer_id)
	order by customer_id;


--2.Join Txn_tbl with Account_tbl and return the transaction details 
--  along with the most recent account_id for each customer.

select 
	t.customer_id, 
	t.txn_id, 
	t.Txn_type_key, 
	t.amount, 
	a.account_id as Most_recent_accountID
from Txn_tbl t
	join Account_tbl a 
	on t.customer_id = a.customer_id
where a.create_date = (
    select max(create_date) 
		from Account_tbl as sub 
		where sub.customer_id = a.customer_id
);

select * from Account_tbl;
select * from txn_tbl;

--3.How can you calculate the total transaction amount for each customer 
--  and display it alongside their most recent account information?
select t.customer_id, 
       sum(t.amount) as total_amount, 
       a.account_id as Most_recent_accountID
from Txn_tbl t
	join Account_tbl a 
	on t.customer_id = a.customer_id
	and a.create_date = (select max(create_date) 
		from Account_tbl as sub 
		where sub.customer_id = a.customer_id
)
group by t.customer_id, a.account_id;

select * from Account_tbl;
select * from txn_tbl;
--4.Describe how you would handle cases where a customer has no account 
--  records in the Account_tbl.
select t.customer_id, 
       coalesce(a.account_id, 'NO Account') as Most_recent_accountID, 
       sum(t.amount) as total_amount
from Txn_tbl t
left join Account_tbl a 
on t.customer_id = a.customer_id
and a.create_date = (
    select max(create_date) 
    from Account_tbl AS sub 
    where sub.customer_id = a.customer_id
)
group by t.customer_id, a.account_id;

select * from Account_tbl;
select * from txn_tbl;

-- 5. Suggest an indexing strategy to optimize the query performance 
--    when joining the Txn_tbl and Account_tbl.

-- I can focus on creating indexes on the columns used in the join condition, 
-- which is customer_id in both tables.

-- Create an index on Txn_tbl.customer_id to speed up lookups 
-- during the join from the transaction side:
CREATE INDEX idx_txn_customer_id ON Txn_tbl(customer_id);

-- Similarly, create an index on Account_tbl.customer_id to improve performance 
-- when accessing matching records from the account side:
CREATE INDEX idx_account_customer_id ON Account_tbl(customer_id);

-- Example join query that will benefit from the above indexes:
SELECT 
    a.customer_id, 
    a.account_id, 
    t.txn_id, 
    t.amount, 
    t.Txn_type_key
FROM 
    Account_tbl a
JOIN 
    Txn_tbl t
    ON a.customer_id = t.customer_id;


select * from Account_tbl;
select * from txn_tbl;

--6.Write a query that returns one row for each customer with:
------ A column for the number of credit transactions,
------ A column for the total amount of credit transactions,
------ A column for the number of debit transactions,
------ A column for the total amount of debit transactions.

select
    Customer_ID,
    -- Credit transaction count and total
    sum (
	case
	when Txn_type_key in (3125, 3124, 3600, 4500, 6577, 8900) 
	then 1 else 0 end) as Credit_Txn_Count,
    sum(
	case
	when Txn_type_key in (3125, 3124, 3600, 4500, 6577, 8900) 
	then amount else 0 end) as Credit_Total_Amount,

    -- Debit transaction count and total
    sum(
	case 
	when Txn_type_key in (3546, 3543, 14, 1600, 8700, 8888) 
	then 1 else 0 end) as Debit_Txn_Count,
    sum(
	case 
	when Txn_type_key in (3546, 3543, 14, 1600, 8700, 8888) 
	then amount else 0 end) as Debit_Total_Amount
from 
    Txn_tbl
group by
	customer_id;

select * from Account_tbl;
select * from txn_tbl;
--Credit Types: 3125, 3124, 3600, 4500, 6577, 8900
--Debit Types : 3546, 3543, 14, 1600, 8700, 8888





