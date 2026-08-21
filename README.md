# 📉 Customer Churn & Retention Analysis

## End-to-End Data Analytics Project | Excel • SQL Server • Power BI

An end-to-end **Customer Churn & Retention Analytics** project built to answer a real business question:

> **Which customers are most likely to churn, why are they leaving, and where should the business focus its retention efforts?**

Using a telecom customer dataset of **7,000+ customer records**, this project combines **Excel for data cleaning and exploration, SQL Server for business-focused analysis, and Power BI for interactive decision-making dashboards**.

The analysis identified a clear high-risk segment: **month-to-month customers in their first year**, allowing retention efforts to be targeted toward a specific customer group rather than the entire customer base.

---

## 🎯 Business Problem

Customer churn directly impacts recurring revenue and customer lifetime value.

The goal of this project was not simply to calculate a churn percentage, but to understand:

* Which customer segments have the highest churn risk?
* How does churn change across the customer lifecycle?
* Which contract types are most vulnerable?
* Does payment method influence churn?
* Which services are associated with higher churn?
* How much revenue is potentially at risk?
* Which customers should the retention team prioritize?

The ultimate objective was to convert raw customer data into **decision-ready retention insights**.

---

## 🛠️ Tools & Technologies

| Tool                  | Purpose                                                  |
| --------------------- | -------------------------------------------------------- |
| **Microsoft Excel**   | Data cleaning, feature engineering, exploratory analysis |
| **SQL Server / SSMS** | Business analysis, segmentation, churn calculations      |
| **Power BI**          | Interactive dashboard and decision-support reporting     |
| **DAX**               | KPI and analytical measures                              |
| **GitHub**            | Version control, project documentation and presentation  |

---

## 🔄 End-to-End Analytics Workflow

```text
Raw Customer Data
        ↓
Data Audit & Cleaning — Excel
        ↓
Feature Engineering & Exploration
        ↓
SQL Server Data Modeling
        ↓
Business-Focused SQL Analysis
        ↓
Power BI Data Connection
        ↓
DAX Measures & Dashboard
        ↓
Insights & Retention Recommendations
```

---

# 1️⃣ Excel — Data Cleaning & Exploration

The first stage focused on making the raw dataset reliable and analysis-ready.

### Data Quality Checks

I audited the dataset for:

* Missing values
* Duplicate records
* Inconsistent category labels
* Incorrect data types
* Data-entry/import issues

One important issue was **11 customers with blank `TotalCharges` values**. Investigation showed that these were brand-new customers with **zero tenure**, meaning they had not yet been billed. Instead of deleting these records or guessing the values, they were set to **0** based on the underlying business context.

`TotalCharges` was also stored as text and converted into a numeric field so that financial calculations such as `SUM` and `AVERAGE` would work correctly.

### Feature Engineering

Three analysis-ready fields were created:

* **Tenure Group** — 0–12, 13–24, 25–48 and 49+ months
* **Estimated Customer Lifetime Value** — Monthly Charges × Tenure
* **High-Risk Flag** — Month-to-month customers with less than 12 months tenure

Excel PivotTables and PivotCharts were then used for an initial exploration of churn by contract type, tenure, payment method and internet service.

---

# 2️⃣ SQL Server — Business-Focused Analysis

The cleaned dataset was loaded into **SQL Server using SSMS** for deeper analysis.

### Data Modeling

The table schema was designed with appropriate data types, including `DECIMAL` for currency-related fields to maintain reliable financial aggregations.

### SQL Analysis

The analysis included:

* Churn rate by **contract type**
* Churn rate by **payment method**
* Churn rate by **internet service**
* **Revenue at risk**
* Tenure-based cohort analysis
* Customer risk segmentation
* Customer ranking within contract segments
* Comparison against segment-level averages

Conditional aggregation using `CASE` and `SUM` was used for segmented churn analysis.

A **CTE-based risk scoring model** classified customers into **High, Medium and Low risk** using contract type, tenure and monthly charges, followed by validation against the actual churn rate in each segment.

Window functions including `RANK()` and `AVG() OVER(PARTITION BY)` were also used to compare customers within their contract segments.

---

# 3️⃣ Power BI — Interactive Churn Dashboard

Power BI was connected directly to the **SQL Server database**, creating a reporting workflow based on the analytical source rather than a static CSV export.

### Dashboard Features

The report was structured into multiple pages:

### Executive Summary

* Total Customers
* Churn Rate
* Revenue at Risk
* Average Tenure
* Key business insights

### Customer Segmentation

* Churn by Contract Type
* Churn by Tenure Group
* Churn by Payment Method
* Churn by Internet Service

### At-Risk Customer View

* High-risk customer segments
* Interactive filters
* Detailed customer-level analysis

DAX measures were created for key metrics including **churn rate, revenue at risk and average tenure**.

Insight callouts were also incorporated so the dashboard communicates the **"so what?"** rather than simply displaying charts.

---

# 📊 Key Findings

The analysis revealed several important churn patterns.

### 1. Contract Type Is a Major Churn Driver

**Month-to-month customers churn substantially more than customers on longer-term contracts**, with churn roughly **15× higher than two-year contract customers**.

### 2. Churn Is Highest During the First Year

Churn is concentrated among customers in their **first 12 months** and declines as customer tenure increases.

### 3. Payment Method Matters

Customers using **electronic check** show noticeably higher churn compared with customers using autopay methods such as bank transfer or credit card.

### 4. Fiber Optic Customers Show Higher Churn

Despite being a premium service, fiber optic customers have a higher churn rate than DSL customers, creating a potential question around **service quality, pricing or customer expectations**.

### 5. Churned Customers Have Higher Monthly Charges

Customers who churned had a higher average monthly charge than customers who stayed, suggesting that **price sensitivity may contribute to churn**.

---

# 💡 Business Recommendation

Based on the analysis, the retention team should prioritize:

> **Month-to-month customers in their first year, particularly customers paying by electronic check.**

This represents a more targeted retention strategy than applying the same campaign to the entire customer base. Potential actions include incentives to encourage customers to:

* Move to longer-term contracts
* Switch to autopay
* Engage earlier during the first year of their customer lifecycle

The project therefore moves from **descriptive analysis → customer segmentation → business recommendation**.

---

# 📁 Repository Structure

```text
Customer-Churn-Retention-Analysis/
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── excel/
│   └── Churn_Analysis.xlsx
│
├── sql/
│   └── Churn_Analysis.sql
│
├── powerbi/
│   └── Customer_Churn_Dashboard.pbix
│
├── images/
│   ├── executive_dashboard.png
│   ├── segmentation_dashboard.png
│   └── risk_dashboard.png
│
└── README.md
```

---

# 🧠 Key Skills Demonstrated

### Excel

* Data Cleaning
* Data Validation
* Feature Engineering
* PivotTables
* PivotCharts
* Exploratory Data Analysis

### SQL

* `CASE`
* Conditional Aggregation
* `GROUP BY`
* CTEs
* Window Functions
* `RANK()`
* `AVG() OVER(PARTITION BY)`
* Customer Segmentation
* Revenue-at-Risk Analysis

### Power BI

* Data Modeling
* DAX Measures
* KPI Development
* Interactive Filters
* Dashboard Design
* Business Storytelling

### Analytics

* Churn Analysis
* Customer Segmentation
* Retention Analysis
* Risk Identification
* Revenue Impact Analysis
* Actionable Business Recommendations

---

# ✅ Data Validation

To maintain consistency across the analytics pipeline, key results were cross-checked between **Excel PivotTables and SQL analysis** before being used in the Power BI dashboard.

This ensured that important metrics and segment-level findings remained consistent across the different stages of the project.

---

# 🚀 Future Improvements

The current project uses a rule-based risk segmentation approach. A natural next step would be to build a **predictive churn model**, such as logistic regression, to estimate the probability of churn for individual customers.

Additional improvements could include incorporating time-series data to monitor churn trends over time instead of analyzing a single snapshot.

---

# 💼 Why This Project Matters

This project demonstrates more than the ability to create charts.

It showcases an end-to-end analytical workflow:

**Business Problem → Data Cleaning → Feature Engineering → SQL Analysis → BI Dashboard → Insights → Business Recommendation**

The project was designed so that a stakeholder could understand the business impact without needing to inspect the underlying code or dataset.

---

## 👤 Author

**Thrishin R**

**Aspiring Data Analyst**

Skills: **Excel • SQL • Power BI • Data Analytics**

---

⭐ **If you found this project useful, consider starring the repository.**
