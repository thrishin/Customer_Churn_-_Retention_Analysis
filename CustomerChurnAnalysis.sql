--Selecting all rows from the tables
SELECT *
FROM dbo.customer_churn;

-- Counting all rows to check any missing rows
SELECT COUNT(*) FROM dbo.customer_churn;

-- Checking for Data Type
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer_churn'
ORDER BY ORDINAL_POSITION;

-- Converting the datatypes for decimal 
ALTER TABLE dbo.customer_churn
ALTER COLUMN MonthlyCharges DECIMAL(10,2);

ALTER TABLE dbo.customer_churn
ALTER COLUMN TotalCharges DECIMAL(10,2);


SELECT DISTINCT Churn FROM dbo.customer_churn;

ALTER TABLE dbo.customer_churn
ALTER COLUMN Churn VARCHAR(3);

UPDATE dbo.customer_churn SET Churn = 'Yes' WHERE Churn = '1';
UPDATE dbo.customer_churn SET Churn = 'No' WHERE Churn = '0';

-- OVERALL CHRUN RATE

SELECT
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS float) / COUNT(*) AS churn_rate
FROM dbo.customer_churn;

-- CHURN SEGAMENTS

-- BY CONTRACT TYPE

SELECT
	Contract,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS float) / COUNT(*) AS churn_rate
FROM dbo.customer_churn
GROUP BY Contract
ORDER BY churn_rate DESC;

-- BY PAYMENT METHOD

SELECT
	PaymentMethod,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS float) / COUNT(*) AS churn_rate
FROM dbo.customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- INTERNET SERVICES

SELECT
	InternetService,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS float) / COUNT(*) AS churn_rate
FROM dbo.customer_churn
GROUP BY InternetService
ORDER BY churn_rate DESC;

-- REVENUE LOST TO CHURN

SELECT
	SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) AS monthly_revenue_lost,
	SUM(MonthlyCharges) AS total_month_revenue,
	CAST(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) AS FLOAT)/ SUM(MonthlyCharges) AS revenue_at_risk
FROM dbo.customer_churn;

-- TENURE COHERT

SELECT
	CASE 
		WHEN tenure <= 12 THEN '0-12 months'
		WHEN tenure <= 24 THEN '13-24 months'
		WHEN tenure <= 48 THEN '25-48 months'
		ELSE '49+ months'
	END AS tenure_group,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churnedcustomer,
	CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS float) / COUNT(*) AS churn_rate
FROM dbo.customer_churn
GROUP BY 
	CASE 
		WHEN tenure <= 12 THEN '0-12 months'
		WHEN tenure <= 24 THEN '13-24 months'
		WHEN tenure <= 48 THEN '25-48 months'
		ELSE '49+ months'
	END
ORDER BY MIN(tenure);

-- HIGH RISK CUSTOMERS USING CTE

WITH RiskScored AS (
    SELECT
        customerID,
        Contract,
        tenure,
        MonthlyCharges,
        Churn,
        CASE
            WHEN Contract = 'Month-to-month' AND tenure < 12 AND MonthlyCharges > 70
                THEN 'High Risk'
            WHEN Contract = 'Month-to-month' AND tenure < 12
                THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS risk_segment
    FROM dbo.customer_churn
)
SELECT
    risk_segment,
    COUNT(*) AS customer_count,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS actually_churned,
    CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT)
        / COUNT(*) AS churn_rate_within_segment
FROM RiskScored
GROUP BY risk_segment
ORDER BY churn_rate_within_segment DESC;

-- WINDOW FUNCTION 

SELECT
    customerID,
    Contract,
    MonthlyCharges,
    Churn,
    RANK() OVER (PARTITION BY Contract ORDER BY MonthlyCharges DESC) AS rank_within_contract,
    AVG(MonthlyCharges) OVER (PARTITION BY Contract) AS avg_charge_in_contract,
    MonthlyCharges - AVG(MonthlyCharges) OVER (PARTITION BY Contract) AS diff_from_avg
FROM dbo.customer_churn
ORDER BY Contract, rank_within_contract;

-- SUBQUERY

SELECT customerID, Contract, MonthlyCharges, tenure, Churn
FROM dbo.customer_churn
WHERE Churn = 'Yes'
  AND MonthlyCharges > (SELECT AVG(MonthlyCharges) FROM dbo.customer_churn)
ORDER BY MonthlyCharges DESC;