# Fraud Detection & Transaction Anomaly Analytics (Portfolio Project)

**Objective:** Detect suspicious transactions using SQL + Python and present an executive-ready BI dashboard.  
This project targets consulting (Deloitte), banking (Scotiabank, Capital One), fintech (Bree), and gaming (Zynga) by focusing on anomalies, risk, and actionable insights.

## Dataset
- `data/customers.csv` — 2,500 customers (home city, segment, baseline risk, join date)  
- `data/merchants.csv` — 600 merchants (MCC code, category, location, merchant risk)  
- `data/transactions.csv` — 20,000 transactions over ~180 days with engineered features:  
  - `time_since_prev_sec`, `distance_from_prev_km`, `velocity_10m`  
  - `amount_z_by_customer`, `account_age_days`, `is_night`, `merchant_risk`  
  - Label: `is_fraud` (~2.0% positive)

## Detection Approach
1. SQL rules (see `sql/fraud_rules.sql`) for transparent, explainable flags.  
2. Optional Python scoring: logistic regression starter script to create a risk score.  
3. BI Dashboard: Alert queue, KPI overview, cohort drill-down, geo heatmap, and customer/merchant detail views.

## Quickstart
1. Load CSVs from `data/` into Power BI/Tableau (or a SQL warehouse).  
2. Run rules in `sql/fraud_rules.sql` to produce initial alert sets.  
3. (Optional) Train a model via `notebooks/fraud_scoring_starter.py` and join scores back for ranking.
