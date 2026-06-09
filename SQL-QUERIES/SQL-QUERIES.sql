/* ============================================================
   FILE: business_analytical_validation_queries.sql
   DESCRIPTION: Business, Analytical, and Validation Queries
   ============================================================ */

-- ============================================================
-- 1. BUSINESS QUERIES
-- ============================================================

-- 1.1 High-Risk Policies (Premium > 1M)
SELECT *
FROM CURATED.POLICIES_ENRICHED
WHERE RISK_LEVEL = 'HIGH';


-- 1.2 Policies Expiring Soon (Next 30 Days)
SELECT *
FROM CURATED.POLICIES_ENRICHED
WHERE EXPIRY_STATUS = 'EXPIRING_SOON';


-- 1.3 Flagged Policies for Review
SELECT *
FROM CURATED.POLICIES_ENRICHED
WHERE FLAGGED_FOR_REVIEW = TRUE;


-- 1.4 Policies by Status
SELECT STATUS, COUNT(*) AS TOTAL_POLICIES
FROM CURATED.POLICIES_ENRICHED
GROUP BY STATUS
ORDER BY TOTAL_POLICIES DESC;


-- ============================================================
-- 2. ANALYTICAL QUERIES
-- ============================================================

-- 2.1 Total Premium by Region
SELECT REGION, SUM(PREMIUM_AMOUNT) AS TOTAL_PREMIUM
FROM DWH.FACT_POLICIES
GROUP BY REGION
ORDER BY TOTAL_PREMIUM DESC;


-- 2.2 Total Premium by Line of Business (LOB)
SELECT LINE_OF_BUSINESS, SUM(PREMIUM_AMOUNT) AS TOTAL_PREMIUM
FROM DWH.FACT_POLICIES
GROUP BY LINE_OF_BUSINESS
ORDER BY TOTAL_PREMIUM DESC;


-- 2.3 Average Premium by Region
SELECT REGION, AVG(PREMIUM_AMOUNT) AS AVG_PREMIUM
FROM DWH.FACT_POLICIES
GROUP BY REGION;


-- 2.4 Policy Count by Risk Level
SELECT RISK_LEVEL, COUNT(*) AS TOTAL_POLICIES
FROM CURATED.POLICIES_ENRICHED
GROUP BY RISK_LEVEL;


-- 2.5 Dashboard Metrics (Same as Semantic Layer)
SELECT
    STATUS,
    LINE_OF_BUSINESS,
    REGION,
    COUNT(*) AS TOTAL_POLICIES,
    SUM(PREMIUM_AMOUNT) AS TOTAL_PREMIUM,
    AVG(PREMIUM_AMOUNT) AS AVG_PREMIUM
FROM DWH.FACT_POLICIES
GROUP BY STATUS, LINE_OF_BUSINESS, REGION;


-- ============================================================
-- 3. SEARCH QUERIES
-- ============================================================

-- 3.1 Search Policy by Policy Number
SELECT *
FROM CURATED.POLICY_SEARCH
WHERE POLICY_NUMBER = 'POL12345';


-- 3.2 Search Policies by Policyholder Name
SELECT *
FROM CURATED.POLICY_SEARCH
WHERE POLICYHOLDER_NAME ILIKE '%JOHN%';


-- ============================================================
-- 4. VALIDATION QUERIES
-- ============================================================

-- 4.1 Record Count Validation (RAW vs CURATED)
SELECT COUNT(*) AS RAW_COUNT FROM RAW.POLICIES;
SELECT COUNT(*) AS CURATED_COUNT FROM CURATED.POLICIES_ENRICHED;


-- 4.2 Data Integrity Check (Missing IDs)
SELECT ID
FROM RAW.POLICIES
MINUS
SELECT ID FROM CURATED.POLICIES_ENRICHED;


-- 4.3 Check for Null Values
SELECT *
FROM CURATED.POLICIES_ENRICHED
WHERE POLICY_NUMBER IS NULL;


-- 4.4 Validate Summary Table
SELECT *
FROM CURATED.POLICY_SUMMARY
ORDER BY TOTAL_POLICIES DESC;


-- ============================================================
-- 5. CDC VALIDATION QUERIES
-- ============================================================

-- 5.1 Check Stream Data
SELECT *
FROM RAW.POLICIES_STREAM;


-- 5.2 Check Merge Impact
SELECT COUNT(*) 
FROM CURATED.POLICIES_ENRICHED;


-- ============================================================
-- END OF FILE
-- ============================================================
