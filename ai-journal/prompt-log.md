# 🤖 COMPLETE AI PROMPTS USED (END-TO-END PROJECT)

## 📌 Overview
AI (Claude) was used step-by-step to build an end-to-end Snowflake data platform including database setup, transformations, DWH modeling, CDC, stored procedures, and automation.

---

# ✅ 1. DATABASE CREATION

**Prompt:**
"Create a Snowflake database and verify it using SHOW DATABASES."

**Outcome:**
- Created CHUBB_APAC_DB
- Verified using SHOW DATABASES

---

# ✅ 2. SCHEMA CREATION

**Prompt:**
"Create schemas RAW, CURATED, DWH, SEMANTIC, CONTROL in Snowflake."

**Outcome:**
- Created all layers
- Verified using SHOW SCHEMAS

---

# ✅ 3. RAW TABLE DESIGN

**Prompt:**
"Create RAW table for storing insurance policy data with fields like premium, policyholder, region, underwriter, and timestamps."

**Outcome:**
- Created RAW.POLICIES table

---

# ✅ 4. CURATED TABLE (TRANSFORMATION)

**Prompt:**
"Create CURATED table from RAW with derived columns for risk classification and expiry tracking."

**Outcome:**
- Created POLICIES_ENRICHED
- Added:
  - RISK_LEVEL (HIGH, MEDIUM, LOW)
  - EXPIRY_STATUS (EXPIRING_SOON, NORMAL)

---

# ✅ 5. AGGREGATION TABLE

**Prompt:**
"Create summary aggregation table grouped by status, region, and line of business."

**Outcome:**
- Created POLICY_SUMMARY
- Precomputed metrics:
  - TOTAL_POLICIES
  - TOTAL_PREMIUM
  - FLAGGED_COUNT
  - EXPIRING_SOON_COUNT

---

# ✅ 6. SEARCH TABLE

**Prompt:**
"Create lightweight table for fast search functionality on policy data."

**Outcome:**
- Created POLICY_SEARCH
- Optimized for API queries

---

# ✅ 7. DWH FACT TABLE

**Prompt:**
"Create fact table in DWH layer from curated data for analytics."

**Outcome:**
- Created FACT_POLICIES

---

# ✅ 8. DIMENSION TABLES

**Prompt:**
"Create dimension tables like customer, region, lob, status, and date from curated layer."

**Outcome:**
- Created:
  - DIM_CUSTOMER
  - DIM_REGION
  - DIM_LOB
  - DIM_STATUS
  - DIM_DATE

---

# ✅ 9. SEMANTIC LAYER (VIEWS)

**Prompt:**
"Create API-ready views for policies, details, summary, search, and dashboard analytics."

**Outcome:**
- Created:
  - V_POLICIES
  - V_POLICY_DETAILS
  - V_POLICY_SUMMARY
  - V_POLICY_SEARCH
  - V_DASHBOARD

---

# ✅ 10. CDC STREAM

**Prompt:**
"Create a stream on RAW table to capture changes including inserts, updates, and deletes."

**Outcome:**
- Created RAW.POLICIES_STREAM

---

# ✅ 11. TEST CDC

**Prompt:**
"Insert sample data and verify that stream captures changes."

**Outcome:**
- Inserted sample record
- Validated stream output

---

# ✅ 12. MERGE LOGIC

**Prompt:**
"Create MERGE logic to implement incremental load from RAW stream to CURATED table."

**Outcome:**
- Implemented CDC using MERGE
- Handled:
  - Updates (WHEN MATCHED)
  - Inserts (WHEN NOT MATCHED)
  - Applied derived logic

---

# ✅ 13. STORED PROCEDURE

**Prompt:**
"Create stored procedure to orchestrate full pipeline including CDC, aggregation refresh, and DWH load."

**Outcome:**
- Created SP_RUN_PIPELINE
- Included:
  - CDC MERGE
  - TRUNCATE + reload summary
  - Reload fact table

---

# ✅ 14. EXECUTION

**Prompt:**
"How to execute stored procedure in Snowflake."

**Outcome:**
- Used CALL CONTROL.SP_RUN_PIPELINE()

---

# ✅ 15. AUTOMATION TASK

**Prompt:**
"Create Snowflake task to run stored procedure every 5 minutes."

**Outcome:**
- Created PIPELINE_TASK
- Automated pipeline execution

---

# ✅ 16. ENABLE TASK

**Prompt:**
"Enable suspended task in Snowflake."

**Outcome:**
- Used ALTER TASK RESUME

---

# ✅ 17. TASK MONITORING

**Prompt:**
"Check execution history of Snowflake task."

**Outcome:**
- Used INFORMATION_SCHEMA.TASK_HISTORY()

---

# ✅ 18. END-TO-END PIPELINE DESIGN

**Prompt:**
"Design complete end-to-end data pipeline including RAW, CURATED, DWH, SEMANTIC, CDC, stored procedure, and automation."

**Outcome:**
- Built full enterprise architecture
- Achieved automation and scalability

---

