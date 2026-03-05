# Sales Data Analysis & Star Schema Modeling

## Business Problem
Analyze sales performance across states, regions, categories, and segments 
to identify revenue drivers and customer retention trends.

## Objectives
- Analyze revenue trends and YoY growth
- Identify top-performing regions and categories
- Measure customer retention performance

## Tools Used
- Excel
- SQL Server
- Power BI

## Excel Skills Demonstrated
- Data validation and cleaning (duplicates, NULL checks)
- Ensured data integrity
  
## SQL Skills Demonstrated
- Data validation and cleaning (duplicates, NULL checks)
- Aggregations
- Window Functions (YOY, Retention)
- CTEs
- Modeling

## Power BI Skills Demonstrated
- Star Schema
- DAX measures for KPI calculation
- Dashboard Visualization
  
## Key Insights
- Revenue Growth: Increased steadily from 2015 to 2018, with strong YoY growth in 2017–2018
- Regional Performance: West region contributes the highest revenue share (32.9%)
- Category Performance: Technology and Office Supplies are the top revenue contributors
- Customer Retention: Improved from 75% in 2016 to 87% in 2018
- Segment Analysis: Consumer segment is the primary revenue driver
## Files Included
- Database.cvs: Backup script of the sales data
- Sales_analysis.sql: SQL queries for data cleaning, aggregation, and modeling
- PowerBI_dashboard.pbix: Interactive Power BI dashboard
- Dashboard_screenshot.png: Static snapshot of the dashboard

## Data Cleaning & Modeling Note
During the data modeling stage, duplicate Customer_ID and Product_ID values were discovered in the dimension tables.
This prevented the creation of proper primary keys and caused issues when building relationships in the data model.
Resolution:
- Rebuilt dimension tables by aggregating attributes and grouping by Customer_ID and Product_ID to ensure uniqueness
- Ensured valid primary keys for Dim_Customer and Dim_Product
- Established proper one-to-many relationships between dimension tables and Fact_Sales
- Produced a clean star schema ready for Power BI analysis

## Business Insight
- Overall Performance: Revenue growth driven by customer acquisition and improved retention
- Retention Insight: Customer retention improved by 12% from 2016 to 2018, indicating stronger repeat purchasing behavior
- Regional Insight: West region shows strong market penetration relative to other regions
- Category Insight: Technology and Office Supplies dominate revenue, highlighting primary business drivers
- Segment Insight: The Consumer segment is the top revenue contributor

<img width="1316" height="733" alt="Super Store Dashboard" src="https://github.com/user-attachments/assets/a99b36b9-0906-4355-9439-b01a37b04e2f" /><img width="1466" height="738" alt="Star Schema" src="https://github.com/user-attachments/assets/315b3bba-ecf3-423e-a684-40ee5d79fc50" />

