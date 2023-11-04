# Sales Data Analysis SQL Project

## Overview

This SQL project focuses on analyzing sales data from the fictional "Sales_walmart" database. It covers a wide range of analyses, including database creation, table structure, data insights, and various aspects of sales, product, customer, payment, and branch analysis. The project aims to extract valuable information and insights from the provided sales data.

## Table of Contents

1. [Database Creation](#database-creation)
2. [Table Structure](#table-structure)
3. [Data Analysis](#data-analysis)
    - [Distinct Values](#distinct-values)
    - [Time of Day](#time-of-day)
    - [Day of the Week](#day-of-the-week)
    - [Month Analysis](#month-analysis)
4. [Sales Analysis](#sales-analysis)
    - [Monthly Sales Trends](#monthly-sales-trends)
    - [Daily Sales Trends](#daily-sales-trends)
    - [Average Customer Ratings](#average-customer-ratings)
5. [Product Analysis](#product-analysis)
    - [Product Sales by Category](#product-sales-by-category)
    - [Product Sales Trends](#product-sales-trends)
6. [Customer Analysis](#customer-analysis)
    - [Customer Types](#customer-types)
    - [Customer Gender](#customer-gender)
    - [Customer Types and Gender](#customer-types-and-gender)
    - [Customer Location and Branch](#customer-location-and-branch)
7. [Payment Analysis](#payment-analysis)
    - [Payment Types](#payment-types)
8. [Branch Analysis](#branch-analysis)
    - [Branch Performance](#branch-performance)
    - [Branch and Payment Analysis](#branch-and-payment-analysis)
9. [Contributors](#contributors)
10. [License](#license)

---

## Database Creation

The project begins with the creation of the "Sales_walmart" database. The database houses a single table, "Orders," which stores various sales-related information.

### Table Structure

The "Orders" table includes the following fields:

- `invoice_id`: Unique identifier for each sale
- `quantity`: Number of items sold
- `product_category`: Category of the product sold
- `unit_price`: Price per unit of the product
- `cost`: Cost of the product
- `tax_pct`: Tax percentage applied to the sale
- `total`: Total sales amount
- `gross_margin`: Gross margin for the sale
- `gross_income`: Gross income from the sale
- `paymenttype`: Payment type used
- `branch_code`: Code for the branch where the sale occurred
- `city`: City where the sale took place
- `customer_type`: Type of customer (e.g., Wholesale, Retail)
- `gender`: Gender of the customer
- `rating`: Customer rating
- `date`: Date of the sale
- `time`: Time of the sale

## Data Analysis

### Distinct Values

A stored procedure, `getdistinctvalue()`, is used to retrieve distinct values from the dataset:

- Years
- Product categories
- Customer types
- Payment types
- Branch codes
- Cities
- Gender

### Time of Day

A new feature, "time_of_day," is added to categorize sales data based on the time of purchase:

- "Morning" for sales between 00:00:00 and 12:00:00
- "Afternoon" for sales between 12:01:00 and 16:00:00
- "Evening" for other times

### Day of the Week

A new column, "Day_name," is added to the "Orders" table to capture the day names extracted from the "date" column. The number of orders for each day is presented in descending order.

### Month Analysis

A new column, "Month_name," is added to the "Orders" table to store the month names. Monthly sales trends, including the total number of orders and sales, are analyzed, and the percentage change in sales is calculated.

---

## Sales Analysis

### Monthly Sales Trends

- Analysis of monthly sales trends, including:
  - Total quantity sold
  - Total cost
  - Total sales
  - Percentage change in sales compared to the previous month

### Daily Sales Trends

- Analysis of daily sales trends, including:
  - Total quantity sold
  - Total cost
  - Total sales
  - Percentage change in sales compared to the previous day

### Average Customer Ratings

- Calculation of the average customer rating based on the dataset.

---

## Product Analysis

### Product Sales by Category

- Analysis of sales data by product category, including:
  - Total quantity sold
  - Total cost
  - Total sales
  - Average rating

### Product Sales Trends

- Analysis of monthly product sales trends, considering changes in sales percentages.

---

## Customer Analysis

### Customer Types

- Analysis of customer types, including:
  - Number of customers
  - Total sales
  - Breakdown by customer type

### Customer Gender

- Analysis of customer gender, including:
  - Number of customers
  - Total sales
  - Breakdown by gender

### Customer Types and Gender

- Combined analysis of customer types and gender, including:
  - Number of customers
  - Total sales
  - Breakdown by customer type and gender

### Customer Location and Branch

- Analysis of customer location and branch, including:
  - Number of customers
  - Total sales
  - Breakdown by customer type, city, and branch code

---

## Payment Analysis

### Payment Types

- Analysis of payment types, including:
  - Number of transactions
  - Total transaction amount

---

## Branch Analysis

### Branch Performance

- Analysis of branch performance, including:
  - Number of orders
  - Total quantity sold
  - Total cost
  - Total sales
  - Branch codes and cities

### Branch and Payment Analysis

- Combined analysis of branch and payment types, including:
  - Number of transactions
  - Total transaction amount
  - Branch codes

This README file provides an extensive overview of the SQL project, its components, and the insights derived from the analysis of the "Sales_walmart" dataset. Users can refer to the individual sections for detailed information on each aspect of the analysis.
