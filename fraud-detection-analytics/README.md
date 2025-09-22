# 🚨 Fraud Detection & Transaction Anomaly Analytics  

**Objective:** Build a portfolio-ready solution that detects suspicious transactions using **SQL, Python, and BI dashboards**. This project highlights anomaly detection, fraud rules, and clear insights — skills directly relevant to consulting, banking, fintech, and gaming analytics.  

---

## 📂 Dataset
- **`data/customers.csv`** — 2,500 customers (home city, segment, baseline risk, join date)  
- **`data/merchants.csv`** — 600 merchants (MCC code, category, location, merchant risk)  
- **`data/transactions.csv`** — 20,000 transactions across ~180 days with engineered features:  
  - `time_since_prev_sec`, `distance_from_prev_km`, `velocity_10m`  
  - `amount_z_by_customer`, `account_age_days`, `is_night`, `merchant_risk`  
  - **Label:** `is_fraud` (~2% flagged)  

---

## 🛠️ Detection Approach
1. **SQL Rules** — Transparent, explainable detection queries (see `sql/fraud_rules.sql`).  
2. **Python Scoring** — Logistic Regression starter (`notebooks/fraud_scoring_starter.py`) for risk scores.  
3. **BI Dashboard** — Suggested visuals:  
   - Alerts Queue (fraud flags)  
   - KPI Overview (fraud rate, velocity, high-risk MCCs)  
   - Customer & Merchant drill-downs  
   - Geographic heatmap of suspicious activity  

---

## 🚀 Quickstart
1. Load CSVs from `/data` into **Power BI** or **Tableau**.  
2. Run rules in `sql/fraud_rules.sql` → generate initial alert sets.  
3. (Optional) Train Python model via `notebooks/fraud_scoring_starter.py` → output `transaction_scores.csv` → join back to dashboard.  

---

## 🎯 Why This Project Stands Out
- **Deloitte / Consulting:** Fraud & anomaly detection is a core risk analytics use case.  
- **Scotiabank / Capital One:** Shows SQL + Python applied to financial transaction monitoring.  
- **Bree (FinTech):** Direct tie to consumer finance & credit-risk patterns.  
- **Zynga (Gaming):** Highlights player-level transaction anomalies & VIP segmentation potential.  

---

## 📊 Sample Dashboard Mockup
*(Add screenshot here once you build your BI dashboard)*  

---

## 🔗 Related Projects
- [Healthcare Clinic Efficiency](../healthcare-clinic-efficiency)  
- [Mortgage Portfolio Analysis](../mortgage-client-portfolio)  
- [Customer Churn Analysis](../customer-churn-analysis)  
- [Blue Jays Performance Analytics](../bluejays-performance-analytics)  
