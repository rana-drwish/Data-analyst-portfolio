SELECT  [Row_ID]
      ,[Order_ID]
      ,[Order_Date]
      ,[Ship_Date]
      ,[Ship_Mode]
      ,[Customer_ID]
      ,[Customer_Name]
      ,[Segment]
      ,[Country]
      ,[City]
      ,[State]
      ,[Postal_Code]
      ,[Region]
      ,[Product_ID]
      ,[Category]
      ,[Sub_Category]
      ,[Product_Name]
      ,[Sales]
  FROM [dbo].[new.Sales.Orders]


  -- =========================================
-- Data Quality Checks
-- =========================================

-- Total Rows
SELECT COUNT(*) AS Total_Rows
FROM [dbo].[new.Sales.Orders];

-- Check for Duplicates
SELECT 
    Order_ID,
    Product_ID,
    Customer_ID,
    COUNT(*) AS Duplicate_Count
FROM [dbo].[new.Sales.Orders]
GROUP BY Order_ID, Product_ID, Customer_ID
HAVING COUNT(*) > 1;

-- Check for NULL values
SELECT *
FROM [dbo].[new.Sales.Orders]
WHERE Customer_ID IS NULL
   OR Order_Date IS NULL
   OR Sales IS NULL
   OR Order_ID IS NULL
   OR Product_ID IS NULL;

-- =========================================
-- Basic Aggregations & KPIs
-- =========================================

-- Total Revenue
SELECT SUM(Sales) AS Total_Revenue
FROM [dbo].[new.Sales.Orders];

-- Total Revenue by Region
SELECT 
    Region,
    SUM(Sales) AS Total_Revenue
FROM [dbo].[new.Sales.Orders]
GROUP BY Region
ORDER BY Total_Revenue DESC;

-- Total Revenue by Category
SELECT 
    Category,
    SUM(Sales) AS Total_Revenue
FROM [dbo].[new.Sales.Orders]
GROUP BY Category
ORDER BY Total_Revenue DESC;

-- =========================================
-- Monthly Sales Trend
-- =========================================
SELECT  
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,
    SUM(Sales) AS Monthly_Sales
FROM [dbo].[new.Sales.Orders]
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Order_Year, Order_Month;

-- =========================================
-- Year-over-Year (YOY) Growth
-- =========================================
SELECT 
    YEAR(Order_Date) AS Order_Year,
    SUM(Sales) AS Total_Sales,
    LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date)) AS Prev_Year_Sales,
    (SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date))) * 1.0 /
    LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date)) AS YOY_Growth_Percentage
FROM [dbo].[new.Sales.Orders]
GROUP BY YEAR(Order_Date)
ORDER BY Order_Year;

-- =========================================
-- Top Products
-- =========================================

-- Rank Products by Sales
SELECT 
    Product_Name,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM [dbo].[new.Sales.Orders]
GROUP BY Product_Name;

-- Top 5 Products by Revenue
SELECT TOP 5 
    Product_Name,
    SUM(Sales) AS Total_Sales
FROM [dbo].[new.Sales.Orders]
GROUP BY Product_Name
ORDER BY Total_Sales DESC;

-- =========================================
-- Create Dimension Tables
-- =========================================

-- Customer Dimension
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    MAX(Segment) AS Segment,
    MAX(Country) AS Country,
    MAX(City) AS City,
    MAX(State) AS State,
    MAX(Region) AS Region
INTO Dim_Customer
FROM [dbo].[new.Sales.Orders]
GROUP BY Customer_ID;

-- Product Dimension
SELECT 
    Product_ID,
    MAX(Product_Name) AS Product_Name,
    MAX(Category) AS Category,
    MAX(Sub_Category) AS Sub_Category
INTO Dim_Product
FROM [dbo].[new.Sales.Orders]
GROUP BY Product_ID;

-- =========================================
-- Create Fact Table
-- =========================================
SELECT  
    Order_ID,
    Product_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID,
    Sales
INTO Fact_Sales
FROM [dbo].[new.Sales.Orders];

-- =========================================
-- Add Primary and Foreign Keys
-- =========================================

ALTER TABLE Dim_Customer
ADD CONSTRAINT PK_DimCustomer PRIMARY KEY (Customer_ID);

ALTER TABLE Dim_Product
ADD CONSTRAINT PK_DimProduct PRIMARY KEY (Product_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_FactCustomer FOREIGN KEY (Customer_ID)
REFERENCES Dim_Customer(Customer_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_FactProduct FOREIGN KEY (Product_ID)
REFERENCES Dim_Product(Product_ID);