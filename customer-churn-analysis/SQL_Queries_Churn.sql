
-- 1. Churn rate by plan type
SELECT Plan,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent
FROM Customers
GROUP BY Plan
ORDER BY Churn_Rate_Percent DESC;

-- 2. Churn rate by region
SELECT Region,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent
FROM Customers
GROUP BY Region
ORDER BY Churn_Rate_Percent DESC;

-- 3. Correlation of complaints to churn
SELECT c.Plan,
       AVG(co.Monthly_Complaints) AS Avg_Complaints,
       ROUND(SUM(CASE WHEN c.Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent
FROM Customers c
JOIN Complaints co ON c.Customer_ID = co.Customer_ID
GROUP BY c.Plan
ORDER BY Avg_Complaints DESC;

-- 4. Average usage (data & call minutes) for churned vs retained customers
SELECT c.Churn,
       ROUND(AVG(u.Monthly_Data_GB), 2) AS Avg_Data_GB,
       ROUND(AVG(u.Monthly_Call_Minutes), 2) AS Avg_Call_Minutes
FROM Customers c
JOIN Usage u ON c.Customer_ID = u.Customer_ID
GROUP BY c.Churn;
