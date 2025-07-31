# SQL Project Portfolio

## Bank Customer Analysis & KPI Reporting

Tools Used
- SQL: Subqueries, Joins, Aggregations, Views
- Entity-Relationship (ER) Modeling

Dataset Focus
Customer activity data across checking and credit card products.

Project Overview
Developed a dynamic KPI reporting system to evaluate customer engagement across multiple banking products. Leveraged normalized datasets to derive key performance indicators, including:
- Customer Tenure
- Total Active Accounts
- Aggregate Assets
- Product Join Dates

Key Features & Highlights
- Customer Relationship Start Date
Identified the earliest interaction date across multiple product tables for accurate tenure calculation.
- Account Activity Aggregation
Calculated total number of active accounts per customer, spanning checking and credit card products.
- Asset Summation
Computed total customer assets across account types, including support for both positive and negative balances.
- Optimized Query Design
Crafted efficient SQL queries using JOINs and aggregations tailored for financial data analysis and real-world reporting.


## Product Sales & POS Transaction Analysis

Tools Used
SQL (CTEs, Aggregates, UNION, Joins)

Database Focus
Product sales and POS transaction data across multiple tables

Overview
Analyzed multi-source product sales data by merging and cleaning records. Generated insights such as total and average sales per product, duplicates identification, and transaction-level aggregation across POS systems.

Key Features
Identified and cleaned duplicate entries between product datasets.
Created merged views using UNION and cleaned datasets using DISTINCT.
Generated consolidated sales summaries across three POS tables.
Computed KPIs including total sales, number of transactions, and averages per product.

## Transaction & Account Management Analytics

Tools Used
SQL (Window Functions, Joins, Group By, Case Statements)

Database Focus
Transaction log and customer account data

Overview
Built queries to classify, summarize, and analyze customer transaction behavior. Derived credit/debit stats, recent account activity, and customer summaries by combining transactional and account-level data.

Key Features
Extracted latest accounts per customer using MAX(create_date).
Classified transaction types as credit or debit with CASE statements.
Joined account and transaction tables to produce unified customer reports.
Handled customers with missing account records using LEFT JOIN logic.

## Library Management System - Database Design & Querying
Tools Used
SQL (DDL, DML, Query Logic, Relational Joins)

Database Focus
Library management schema design and advanced querying

Overview
Designed and implemented a relational database schema for a library system. Populated tables with sample data and wrote complex SQL queries to simulate real-world operations such as loan tracking, book availability, and borrower behavior.

Key Features
Designed schema with normalized tables (books, authors, branches, borrowers, loans).
Populated database using INSERT statements with realistic values.
Executed complex queries including:
Borrowers by branch
Average copies and loaned books
Books borrowed by author or city
Ranking of library branches based on loan activity

Performed data manipulation tasks
UPDATE branch info, DELETE books by publisher, INSERT new titles.
