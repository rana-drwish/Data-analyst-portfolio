SELECT  [Patient_ID]
       ,[Name]
      ,[Age]
      ,[Gender]
      ,[Blood_Type]
      ,[Medical_Condition]
      ,[Date_of_Admission]
      ,[Doctor]
      ,[Hospital]
      ,[Insurance_Provider]
      ,[Billing_Amount]
      ,[Admission_Type]
      ,[Discharge_Date]
      ,[Medication]
      ,[Test_Results]
  FROM [healthcare]

-- =========================================
-- Data Preparation
-- =========================================

-- Add Primary Key
ALTER TABLE healthcare
ADD Patient_ID INT IDENTITY(1,1) PRIMARY KEY;

-- Fix Billing Amount Data Type
ALTER TABLE healthcare
ALTER COLUMN Billing_Amount DECIMAL(10,2);



-- =========================================
-- Data Quality Check: Duplicates
-- =========================================

SELECT 
    Name,
    Medical_Condition,
    Billing_Amount,
    Date_of_Admission,
    COUNT(*) AS Duplicate_Count
FROM healthcare
GROUP BY 
    Name,
    Medical_Condition,
    Billing_Amount,
    Date_of_Admission
HAVING COUNT(*) > 1;



-- =========================================
-- Remove Duplicate Records
-- =========================================

WITH DuplicateCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Name, Date_of_Admission, Medical_Condition
               ORDER BY (SELECT NULL)
           ) AS RowNum
    FROM healthcare
)
DELETE
FROM DuplicateCTE
WHERE RowNum > 1;



-- =========================================
-- Data Quality Check: Null Values
-- =========================================

SELECT *
FROM healthcare
WHERE Name IS NULL
   OR Age IS NULL
   OR Gender IS NULL
   OR Blood_Type IS NULL;



-- =========================================
-- Remove Records with Missing Names
-- =========================================

DELETE FROM healthcare
WHERE Name IS NULL;



-- =========================================
-- Basic Aggregations & KPIs
-- =========================================

SELECT 
    Insurance_Provider,
    SUM(Billing_Amount) AS Total_Revenue,
    AVG(Billing_Amount) AS Avg_Claim_Value
FROM healthcare
GROUP BY Insurance_Provider
ORDER BY Total_Revenue DESC;



-- =========================================
-- Operational Efficiency (Length of Stay)
-- =========================================

SELECT 
    Medical_Condition,
    AVG(DATEDIFF(DAY, Date_of_Admission, Discharge_Date)) AS Avg_Stay_Days
FROM healthcare
GROUP BY Medical_Condition
ORDER BY Avg_Stay_Days DESC;



-- =========================================
-- Patient Demographics & Market Segmentation
-- =========================================

SELECT 
    CASE
        WHEN Age < 18 THEN 'Pediatric'
        WHEN Age BETWEEN 18 AND 64 THEN 'Adult'
        ELSE 'Senior'
    END AS Age_Group,
    Medical_Condition,
    COUNT(*) AS Patient_Count
FROM healthcare
GROUP BY 
    CASE
        WHEN Age < 18 THEN 'Pediatric'
        WHEN Age BETWEEN 18 AND 64 THEN 'Adult'
        ELSE 'Senior'
    END,
    Medical_Condition
ORDER BY Patient_Count DESC;



-- =========================================
-- Top Billing Patients per Medical Condition
-- =========================================

WITH RankedBilling AS (
    SELECT
        Name,
        Medical_Condition,
        Billing_Amount,
        DENSE_RANK() OVER (
            PARTITION BY Medical_Condition
            ORDER BY Billing_Amount DESC
        ) AS Billing_Rank
    FROM healthcare
)

SELECT *
FROM RankedBilling
WHERE Billing_Rank <= 3;



-- =========================================
-- Dimension Table: Patients
-- =========================================

SELECT DISTINCT
    Patient_ID,
    Name,
    Age,
    Gender,
    Blood_Type,
    Insurance_Provider
INTO Patients
FROM healthcare;



-- =========================================
-- Dimension Table: Hospitals
-- =========================================

SELECT DISTINCT
    Hospital,
    Doctor
INTO Hospitals
FROM healthcare;

ALTER TABLE Hospitals
ADD Hospital_ID INT IDENTITY(1,1) PRIMARY KEY;



-- =========================================
-- Fact Table: Admissions
-- =========================================

SELECT
    Patient_ID,
    Hospital,
    Admission_Type,
    Date_of_Admission,
    Discharge_Date,
    Billing_Amount,
    Medication,
    Test_Results
INTO Fact_Admissions
FROM healthcare;



-- =========================================
-- Add Hospital Foreign Key
-- =========================================

ALTER TABLE Fact_Admissions
ADD Hospital_ID INT;



-- =========================================
-- Populate Hospital_ID
-- =========================================

UPDATE a
SET a.Hospital_ID = h.Hospital_ID
FROM Fact_Admissions a
JOIN Hospitals h
   ON a.Hospital = h.Hospital;



-- =========================================
-- Remove Redundant Column
-- =========================================

ALTER TABLE Fact_Admissions
DROP COLUMN Hospital;



-- =========================================
-- Update Patient Dimension with Medical Condition
-- =========================================

ALTER TABLE Patients
ADD Medical_Condition VARCHAR(50);

UPDATE p
SET p.Medical_Condition = h.Medical_Condition
FROM Patients p
JOIN healthcare h
ON p.Patient_ID = h.Patient_ID;
