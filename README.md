# 🏢 Chubb APAC – Policy Management Data Platform

## 📌 Overview
This project implements an end-to-end Snowflake data platform for insurance policy management using Medallion Architecture. It supports data ingestion, transformation, analytics, and real-time processing with automation.

---

## 🏗️ Architecture

The solution is built using a layered architecture:

RAW → CURATED → DWH → SEMANTIC  
                     ↑  
                CONTROL (Automation)

---

## ✅ Key Features

- Medallion Architecture (RAW, CURATED, DWH, SEMANTIC)
- CDC implementation using Snowflake Streams & MERGE
- Business transformations with derived columns
- Star schema design for analytics (FACT & DIM tables)
- API-ready semantic views
- Automated data pipeline using Stored Procedures & Tasks
- Near real-time data processing (5-minute interval)

---

## 📊 Data Flow

1. Data is ingested into `RAW.POLICIES`
2. Changes are tracked using `RAW.POLICIES_STREAM`
3. Incremental updates applied to `CURATED.POLICIES_ENRICHED`
4. Aggregations generated in `POLICY_SUMMARY`
5. Data loaded into DWH (FACT + DIM tables)
6. Semantic views exposed for API and reporting
7. Pipeline executed via stored procedure and automated task

---

## 🟤 RAW Layer

- `RAW.POLICIES` – Stores raw policy data
- `RAW.POLICIES_STREAM` – Captures CDC changes

---

## ⚪ CURATED Layer

- `POLICIES_ENRICHED` – Enriched data with:
  - RISK_LEVEL (HIGH / MEDIUM / LOW)
  - EXPIRY_STATUS (EXPIRING_SOON / NORMAL)

- `POLICY_SUMMARY` – Aggregated metrics
- `POLICY_SEARCH` – Optimized lookup table

---

## 🟡 DWH Layer (Star Schema)

### FACT Table
- `FACT_POLICIES`

### DIM Tables
- `DIM_CUSTOMER`
- `DIM_REGION`
- `DIM_LOB`
- `DIM_STATUS`
- `DIM_DATE`

---

## 🔵 SEMANTIC Layer

- `V_POLICIES`
- `V_POLICY_DETAILS`
- `V_POLICY_SUMMARY`
- `V_POLICY_SEARCH`
- `V_DASHBOARD`

👉 These views are used for API and reporting purposes.

---

## 🔄 CDC Implementation

- Snowflake Streams track changes from RAW layer
- MERGE logic applies incremental updates
- Reduces processing cost and improves performance

---

## ⚙️ Pipeline Orchestration

### Stored Procedure
- `CONTROL.SP_RUN_PIPELINE`
  - CDC Merge (RAW → CURATED)
  - Summary refresh
  - DWH load

---

## ⏰ Automation

### Task
- `CONTROL.PIPELINE_TASK`
- Runs every **5 minutes**

---

## 📈 Monitoring

```sql
SELECT *
FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY())
ORDER BY SCHEDULED_TIME DESC;
``