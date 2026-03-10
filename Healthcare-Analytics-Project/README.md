# Healthcare Analytics Dashboard (SQL + Power BI)

## Project Overview
Analyze hospital admissions, medical conditions, insurance billing, and patient demographics to identify healthcare utilization patterns and cost drivers.

## Objectives
- Analyze hospital billing and revenue trends
- Identify the most common medical conditions among patients
- Measure operational efficiency using average length of hospital stay
- Understand patient demographics and healthcare utilization patterns

## Tools & Technologies
- Excel – Data validation and cleaning 
- SQL Server – data cleaning, transformation, and analysis
- Power BI – data modeling and dashboard development
- DAX – calculated measures and KPIs

## Data Cleaning (SQL)
- Data preparation steps included:
- Adding a Primary Key (Patient_ID)
- Fixing data types (Billing Amount → DECIMAL)
- Detecting and removing duplicate records
- Identifying and handling missing values
- Verifying data consistency before analysis

## SQL Skills Demonstrated
- Data validation and cleaning (duplicate detection, NULL checks)
- Data type correction and data integrity verification
- Aggregations and KPI calculations
- Window Functions (DENSE_RANK)
- CTEs for data cleaning
- Analytical queries for healthcare metrics
- Star schema modeling preparation

## Power BI Skills Demonstrated
- Star Schema data modeling
- DAX measures for KPI calculations
- Interactive dashboard development
- Data storytelling through visualization

## Files Included
- healthcare_analysis.sql: SQL queries for data cleaning, aggregation, and modeling
- healthcare_dashboard.pbix: Interactive Power BI dashboard
- dashboard_screenshot.png: Static preview of the dashboard

## Data Modeling
The dataset was transformed into a star schema to support efficient analytics in Power BI.
# Dimension Tables:
- Patients: Patient_ID, Name, Age, Gender, Blood Type, Insurance Provider, Medical Condition
- Hospitals: Hospital_ID, Hospital, Doctor
# Fact Table:
- Fact_Admissions: Patient_ID, Hospital_ID, Admission Type, Date of Admission, Discharge Date, Billing Amount, Medication, Test Results
This structure enables efficient relationships and improved performance for analytical queries and reporting.

## Business Insight
- Healthcare Demand: Chronic conditions such as arthritis and diabetes represent a significant share of patient admissions.
- Financial Insight: Insurance providers contribute relatively balanced billing amounts, with Medicare slightly leading total revenue.
- Operational Insight: Average length of stay remains stable across admission types, suggesting consistent treatment durations.
- Demographic Insight: Adult patients dominate hospital admissions, highlighting the primary healthcare service population.
- Clinical Insight: Test results are distributed across normal, abnormal, and inconclusive outcomes, reflecting varied diagnostic results.

<img width="1316" height="733" alt="Super Store Dashboard" src="https://github.com/user-attachments/assets/ec8ca39e-16b4-4154-894b-4fac0bb9e761" />
<img width="1466" height="738" alt="Star Schema" src="https://github.com/user-attachments/assets/4d844d9b-d622-41cf-8dd7-5c635ee28b1f" />
