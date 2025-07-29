
-- 1. Delinquency rate by loan term
SELECT Term_Years,
       ROUND(SUM(CASE WHEN On_Time = 'No' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Delinquency_Rate_Percent
FROM Payments p
JOIN Clients c ON p.Client_ID = c.Client_ID
GROUP BY Term_Years
ORDER BY Term_Years;

-- 2. Monthly late payment trend
SELECT DATE_TRUNC('month', Payment_Date) AS Month,
       COUNT(*) FILTER (WHERE On_Time = 'No') AS Late_Payments,
       COUNT(*) AS Total_Payments
FROM Payments
GROUP BY Month
ORDER BY Month;

-- 3. Top 10 highest outstanding balances
SELECT Client_ID, Client_Name, Loan_Amount
FROM Clients
WHERE Status = 'Active'
ORDER BY Loan_Amount DESC
LIMIT 10;

-- 4. Average payment amount by interest rate band
SELECT CASE 
           WHEN Interest_Rate < 3 THEN 'Low (<3%)'
           WHEN Interest_Rate BETWEEN 3 AND 5 THEN 'Medium (3-5%)'
           ELSE 'High (>5%)'
       END AS Interest_Band,
       ROUND(AVG(Payment_Amount), 2) AS Avg_Payment
FROM Payments p
JOIN Clients c ON p.Client_ID = c.Client_ID
GROUP BY Interest_Band
ORDER BY Interest_Band;
