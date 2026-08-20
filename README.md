# Enterprise Banking Fraud Detection & Risk Intelligence Dashboard

## Project Title

**Enterprise Banking Fraud Detection & Risk Intelligence Dashboard**

## Project Overview

The **Banking Fraud Intelligence Dashboard** is a five-page interactive
Power BI Business Intelligence project developed to analyze fraudulent
banking transactions, customer risk, branch and ATM risk, digital
banking threats, fraud investigations, and financial impact.

The project uses a relational **MySQL** database as the data layer and
**Power BI** for data modeling, analysis, visualization, and reporting.
**Power Query** is used for ETL and data cleaning, while **DAX** is used
to create KPIs, ratios, rankings, and dynamic analytical measures.

The dataset is **synthetic**, created for educational and portfolio
purposes. It does not contain real customer, account, or transaction
information.

The five dashboard pages are:

1.  Executive Fraud Overview
2.  Customer & Transaction Risk
3.  Branch, ATM & Merchant Risk
4.  Digital Banking & Investigation
5.  Financial Impact & Recommendations

## Project Objectives

-   Analyze fraudulent banking transactions and identify major fraud
    patterns.
-   Monitor fraud volume, fraud rate, fraud amount, and financial loss.
-   Identify high-risk customers and suspicious transaction behavior.
-   Detect operational hotspots across branches, ATMs, merchants,
    cities, and regions.
-   Analyze suspicious login activity and digital device risk.
-   Monitor fraud case status and investigator workload.
-   Measure recovered amounts and recovery effectiveness.
-   Provide interactive dashboards for evidence-based decision-making.
-   Validate Power BI results against SQL analysis.
-   Demonstrate an end-to-end Business Intelligence workflow from
    database design to dashboard reporting.

## Tools & Technologies

  -----------------------------------------------------------------------
  Tool / Technology                   Purpose
  ----------------------------------- -----------------------------------
  **MySQL / MySQL Workbench**         Relational database, tables, keys,
                                      relationships, and SQL analysis

  **Power BI Desktop**                Data modeling, dashboards, visuals,
                                      filters, and report navigation

  **Power Query**                     ETL, data cleaning, data type
                                      correction, and transformation

  **DAX**                             KPI calculations, ratios, rankings,
                                      and dynamic analysis

  **Excel / CSV**                     Synthetic source data and bulk data
                                      import
  -----------------------------------------------------------------------

## Dataset Description

The dataset is synthetic and simulates realistic banking operations and
fraud patterns.

It contains:

-   Bank information
-   Geographic/location information
-   Customer information and risk categories
-   Account information
-   Card information
-   Branch information
-   ATM information
-   Merchant information
-   Digital device information
-   Employee/investigator information
-   Calendar/date information
-   Banking transactions
-   Login events
-   Fraud cases
-   Financial loss and recovery information

### Main Synthetic Fraud Patterns

The dataset includes scenarios such as:

-   High-value transactions
-   Repeated fraud attempts
-   Suspicious logins
-   High-risk customers
-   High-risk ATMs
-   High-risk merchants
-   Different fraud types and channels
-   Open and closed fraud investigations
-   Financial loss and recovered amounts

> **Important:** This project uses synthetic data generated for
> educational and portfolio use. It must not be represented as real
> banking data.

### Database Structure

The MySQL model follows a star-schema-oriented structure.

**Dimension tables:**

-   `DimBank`
-   `DimLocation`
-   `DimCustomer`
-   `DimBranch`
-   `DimAccount`
-   `DimCard`
-   `DimATM`
-   `DimMerchant`
-   `DimDevice`
-   `DimEmployee`
-   `DimCalendar`

**Fact tables:**

-   `FactTransactions`
-   `FactLogins`
-   `FactFraudCases`

**Supporting table:**

-   `RecoveryStatus`

## SQL Analysis

MySQL is used as the relational data layer for storing and analyzing the
banking fraud data.

The SQL analysis focuses on:

-   Transaction volume analysis
-   Fraud transaction identification
-   Fraud amount aggregation
-   Customer risk analysis
-   Branch and ATM fraud analysis
-   Merchant risk analysis
-   Suspicious login analysis
-   Fraud case status analysis
-   Financial loss analysis
-   Recovery amount analysis
-   Validation of relationships and key fields
-   Reconciliation of SQL results with Power BI results

The database uses primary and foreign keys to connect dimension and fact
tables. Related IDs are validated for compatible data types before Power
BI modeling.

Typical analysis areas include:

``` sql
-- Total transactions
SELECT COUNT(*) AS TotalTransactions
FROM FactTransactions;

-- Fraud transactions
SELECT COUNT(*) AS FraudTransactions
FROM FactTransactions
WHERE FraudFlag = TRUE;

-- Fraud amount
SELECT SUM(Amount) AS FraudAmount
FROM FactTransactions
WHERE FraudFlag = TRUE;

-- Financial loss
SELECT SUM(FinancialLoss) AS FinancialLoss
FROM FactFraudCases;

-- Recovered amount
SELECT SUM(RecoveredAmount) AS RecoveredAmount
FROM FactFraudCases;
```

These examples represent the type of SQL aggregation used for analytical
validation. The final project should use the actual SQL scripts stored
in the repository if available.

## Power BI Dashboard

The Power BI report contains five focused pages. Each page addresses a
specific business question.

### 1. Executive Fraud Overview

**Business question:** What is happening with fraud?

**Slicers:**

-   Year
-   MonthName
-   BankName
-   Region

**KPI Cards:**

-   Total Transactions
-   Fraud Transactions
-   Fraud Rate
-   Fraud Amount
-   Financial Loss

**Visuals:**

-   Monthly Fraud Trend
-   Fraud by Channel
-   Fraud by Type
-   Fraud by Region

### 2. Customer & Transaction Risk

**Business question:** Who and what is at higher risk?

**Slicers:**

-   Customer Segment
-   Transaction Type
-   Fraud Type
-   Channel
-   Risk Category

**KPI Cards:**

-   Velocity Alerts
-   Fraud Customers
-   High Value Transactions
-   Average Transaction Value
-   High Risk Customers

**Visuals:**

-   Customer Risk Distribution
-   Customer Fraud Amount
-   Transaction Trend by Channel
-   Risk vs Amount Scatter Plot

### 3. Branch, ATM & Merchant Risk

**Business question:** Where are the operational fraud hotspots?

**Slicers:**

-   Merchant Category
-   City
-   Branch Name
-   State
-   Region

**KPI Cards:**

-   Fraud Branches
-   Fraud ATMs
-   High-Risk ATM
-   High-Risk Merchants
-   Fraud Amount

**Visuals:**

-   Fraud by City
-   Branch Fraud Transactions
-   Branch Fraud Amount
-   ATM Fraud Analysis
-   Merchant Risk Analysis
-   Branch Risk Table

### 4. Digital Banking & Investigation

**Business question:** What digital activity is suspicious and how are
cases progressing?

**Slicers:**

-   Login Status
-   Fraud Status
-   Risk Level
-   Operating System
-   Device Type

**KPI Cards:**

-   Suspicious Logins
-   Failed Logins
-   Open Fraud Cases
-   Resolved Fraud Cases
-   Average Investigation Hours

**Visuals:**

-   Suspicious Login Trend
-   Device Risk Analysis
-   Fraud Case Status
-   Investigator Workload

> In the current data, completed fraud cases use the status **Closed**.
> Therefore, the Resolved Fraud Cases KPI filters
> `FraudStatus = "Closed"`.

### 5. Financial Impact & Recommendations

**Business question:** How much money is exposed and where is the
financial impact concentrated?

**Slicers:**

-   MonthName
-   Risk Level
-   Fraud Status
-   Fraud Type

A Year page-level filter is also applied.

**KPI Cards:**

-   Fraud Amount
-   Recovered Amount
-   Financial Loss
-   Recovery Rate
-   Open Financial Exposure

**Visuals:**

-   Monthly Fraud and Recovery
-   Loss by Fraud Type
-   Financial Loss by Channel
-   Recovery Performance

## Key KPIs

The project includes the following major KPIs:

  -----------------------------------------------------------------------
  KPI                                 Purpose
  ----------------------------------- -----------------------------------
  **Total Transactions**              Measures total transaction volume

  **Fraud Transactions**              Counts transactions marked as
                                      fraudulent

  **Fraud Rate %**                    Measures fraudulent transactions as
                                      a percentage of total transactions

  **Total Customers**                 Counts unique customers

  **High-Risk Customers**             Counts customers classified as high
                                      risk

  **Fraud Amount**                    Measures the monetary value of
                                      fraudulent transactions

  **Recovered Amount**                Measures the amount recovered from
                                      fraud cases

  **Financial Loss**                  Measures financial loss associated
                                      with fraud cases

  **Open Fraud Cases**                Counts currently open fraud
                                      investigations

  **Resolved Fraud Cases**            Counts fraud cases with `Closed`
                                      status

  **Suspicious Logins**               Measures suspicious digital login
                                      activity

  **Failed Logins**                   Measures failed login activity

  **Average Investigation Hours**     Measures investigation effort

  **Recovery Rate**                   Measures recovery effectiveness

  **Open Financial Exposure**         Measures currently exposed
                                      financial value
  -----------------------------------------------------------------------

### Core DAX Measures

``` dax
Total Transactions =
COUNTROWS(FactTransactions)

Fraud Transactions =
CALCULATE(
    [Total Transactions],
    FactTransactions[FraudFlag] = TRUE()
)

Fraud Rate % =
DIVIDE(
    [Fraud Transactions],
    [Total Transactions],
    0
)

Total Customers =
DISTINCTCOUNT(DimCustomer[CustomerID])

High Risk Customers =
CALCULATE(
    DISTINCTCOUNT(DimCustomer[CustomerID]),
    DimCustomer[RiskCategory] = "High"
)

Fraud Amount =
CALCULATE(
    SUM(FactTransactions[Amount]),
    FactTransactions[FraudFlag] = TRUE()
)

Recovered Amount =
COALESCE(
    SUM(FactFraudCases[RecoveredAmount]),
    0
)

Financial Loss =
COALESCE(
    SUM(FactFraudCases[FinancialLoss]),
    0
)

Open Fraud Cases =
CALCULATE(
    COUNTROWS(FactFraudCases),
    FactFraudCases[FraudStatus] = "Open"
)

Resolved Fraud Cases =
CALCULATE(
    COUNTROWS(FactFraudCases),
    FactFraudCases[FraudStatus] = "Closed"
)
```

## Key Insights

The dashboard is designed to identify the following business insights:

### Fraud Concentration

Identify channels, regions, fraud types, and customer groups with high
fraud activity.

### Financial Concentration

Identify fraud types and channels associated with higher financial
losses.

### Customer Risk

Identify high-risk customers, high-value transactions, and fraud-prone
customers.

### Operational Hotspots

Use city, branch, ATM, and merchant analysis to locate repeated fraud
activity.

### Digital Risk

Identify suspicious login patterns and device-level risk.

### Investigation Efficiency

Compare open and closed fraud cases, investigator workload, and average
investigation hours.

### Recovery Effectiveness

Compare fraud amount, recovered amount, recovery rate, and open
financial exposure.

> **Note:** Numerical rankings and actual findings should be taken
> directly from the populated Power BI dashboard. Numerical results
> should not be invented or assumed.

## Project Workflow

``` text
Requirement Analysis
        ↓
Dataset Design
        ↓
Synthetic Data Creation
        ↓
MySQL Database Development
        ↓
Data Loading & Validation
        ↓
Power BI Connection
        ↓
Power Query ETL & Data Cleaning
        ↓
Data Modeling / Star Schema
        ↓
DAX KPI Development
        ↓
Dashboard Design
        ↓
SQL vs Power BI Validation
        ↓
Insight Generation
        ↓
Documentation
```

### Workflow Steps

1.  Define the banking fraud problem and required business decisions.
2.  Design fact and dimension tables.
3.  Create synthetic banking records.
4.  Build the MySQL database and relationships.
5.  Load and validate the data.
6.  Connect MySQL to Power BI.
7.  Clean and transform data using Power Query.
8.  Build and validate the star-schema-oriented model.
9.  Create DAX measures and KPIs.
10. Build five focused dashboard pages.
11. Validate Power BI results against SQL.
12. Analyze trends, rankings, risk, and financial exposure.
13. Document the technical implementation and findings.

## Repository Structure

A recommended repository structure is:

``` text
Banking-Fraud-Intelligence-Dashboard/
│
├── README.md
│
├── data/
│   ├── raw/
│   │   └── synthetic_banking_fraud_data.csv
│   └── processed/
│
├── sql/
│   ├── database_schema.sql
│   ├── table_creation.sql
│   ├── data_validation.sql
│   └── fraud_analysis.sql
│
├── powerbi/
│   └── Banking-Fraud-Intelligence-Dashboard.pbix
│
├── screenshots/
│   ├── executive-fraud-overview.png
│   ├── customer-transaction-risk.png
│   ├── branch-atm-merchant-risk.png
│   ├── digital-banking-investigation.png
│   └── financial-impact.png
│
├── documentation/
│   └── banking-fraud-dashboard-documentation.docx
│
└── assets/
    └── project-images/
```

> Update filenames in this structure to match the actual files uploaded
> to the repository. Do not commit sensitive credentials or real
> banking/customer data.

## Dashboard Screenshots

Add the five Power BI dashboard screenshots to the `screenshots/`
folder.

### Executive Fraud Overview

<img width="1317" height="745" alt="Executive Fraud Overview" src="https://github.com/user-attachments/assets/7993bfcc-4257-4630-a101-386610f4d573" />


### Customer & Transaction Risk

<img width="1318" height="742" alt="Customer   Transaction Risk" src="https://github.com/user-attachments/assets/9f6e640c-01d9-4c72-bd40-70530ea83e8d" />


### Branch, ATM & Merchant Risk

<img width="1318" height="740" alt="Branch,ATM   Merchant Risk" src="https://github.com/user-attachments/assets/35db03f2-502f-4f76-9a12-8988c3ac133c" />


### Digital Banking & Investigation

<img width="1316" height="742" alt="Digital Banking   Investigation" src="https://github.com/user-attachments/assets/2d458d5a-6b09-4d2e-b844-69c895ddbf4f" />


### Financial Impact & Recommendations

<img width="1321" height="745" alt="Financial Impact   Recommendation" src="https://github.com/user-attachments/assets/9eb23826-ee25-47de-b12c-d49b1bf27267" />


## How to Run the Project

### Prerequisites

Install or have access to:

-   MySQL / MySQL Workbench
-   Power BI Desktop
-   Excel or a compatible CSV tool

### Step 1 -- Set Up MySQL

1.  Install and open MySQL.
2.  Create the banking fraud database.
3.  Execute the database/table creation SQL scripts.
4.  Load the synthetic dataset.
5.  Validate primary keys, foreign keys, data types, and row counts.

### Step 2 -- Connect Power BI to MySQL

1.  Open **Power BI Desktop**.
2.  Select **Get Data → MySQL database**.
3.  Enter the MySQL server and database name.
4.  Authenticate with the database.
5.  Select the required Banking Fraud tables.
6.  Select **Transform Data**.
7.  Perform the required Power Query cleaning and transformations.
8.  Select **Close & Apply**.

### Step 3 -- Validate the Data Model

Open **Model view** in Power BI and verify:

-   Dimension-to-fact relationships
-   Primary and foreign key compatibility
-   Date relationships
-   `DimCalendar` as the date table
-   No unintended duplicate relationships

### Step 4 -- Create / Verify DAX Measures

Create or verify the KPI measures described in this README.

### Step 5 -- Open the Dashboard

Open the `.pbix` file and review all five pages:

-   Executive Fraud Overview
-   Customer & Transaction Risk
-   Branch, ATM & Merchant Risk
-   Digital Banking & Investigation
-   Financial Impact & Recommendations

### Step 6 -- Validate Results

Compare key Power BI results with SQL analysis to ensure that:

-   Transaction counts match
-   Fraud counts match
-   Fraud amounts are correct
-   Financial loss is not double-counted
-   Recovery amounts are correct
-   Filters and relationships behave as expected

## Author

**N V Sanjai**

**Project:** Enterprise Banking Fraud Detection & Risk Intelligence
Dashboard

**Industry:** Banking and Financial Services

**Technologies:** MySQL, Power BI, Power Query, DAX

------------------------------------------------------------------------

## Project Notes

This project is an educational and portfolio-oriented Business
Intelligence simulation. It demonstrates database design, SQL analysis,
ETL, data cleaning, data modeling, DAX, Power BI visualization,
validation, and business insight generation.

The project documentation emphasizes that the dataset is synthetic and
should not be presented as real banking data.
