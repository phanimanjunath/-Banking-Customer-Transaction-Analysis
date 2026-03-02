-- ─────────────────────────────────
-- DATA SOURCE: Synthetic dataset
-- created to simulate a realistic
-- Indian retail banking environment.
-- All records are fictional.
-- ─────────────────────────────────
-- ============================================================
--  BANKING CUSTOMER & TRANSACTION ANALYSIS
--  Tool        : MySQL
--  Database    : banking_db
--  Author      : [Your Name]
--  Description : End-to-end SQL analysis of a banking database
--                covering customer segmentation, account health,
--                transaction trends, loan portfolio risk, and
--                advanced analytics using window functions
--                and subqueries.
-- ============================================================

USE banking_db;

-- ============================================================
-- SECTION 1: DATABASE OVERVIEW
-- ============================================================

-- ------------------------------------------------------------
-- Q1: Complete Database Summary
-- Business Question: "Give me a quick snapshot of our
--                    entire banking database."
-- ------------------------------------------------------------
SELECT 'Customers'     AS table_name, COUNT(*) AS total_records FROM customers
UNION ALL
SELECT 'Accounts',     COUNT(*) FROM accounts
UNION ALL
SELECT 'Transactions', COUNT(*) FROM transactions
UNION ALL
SELECT 'Loans',        COUNT(*) FROM loans;

-- Insight: Bank has 50 customers, 62 accounts, 87 transactions
--          and 40 loans across 4 interconnected tables.


-- ------------------------------------------------------------
-- Q2: Bank Portfolio Health Overview
-- Business Question: "What is the overall financial health
--                    of the bank at a glance?"
-- ------------------------------------------------------------
SELECT
    -- Customer metrics
    (SELECT COUNT(*) FROM customers)                        AS total_customers,
    (SELECT COUNT(DISTINCT city) FROM customers)            AS cities_covered,

    -- Account metrics
    (SELECT COUNT(*) FROM accounts WHERE status = 'active') AS active_accounts,
    (SELECT ROUND(SUM(balance), 2)
     FROM accounts WHERE status = 'active')                 AS total_deposits,

    -- Loan metrics
    (SELECT COUNT(*) FROM loans WHERE status = 'active')    AS active_loans,
    (SELECT ROUND(SUM(loan_amount), 2)
     FROM loans WHERE status = 'active')                    AS active_loan_portfolio,

    -- Risk metrics
    (SELECT COUNT(*) FROM loans WHERE status = 'defaulted') AS defaulted_loans,
    (SELECT COUNT(*) FROM accounts WHERE status = 'frozen') AS frozen_accounts;

-- Insight: Single query gives complete bank health dashboard.
--          Management can see deposits vs loans vs risk instantly.


-- ============================================================
-- SECTION 2: CUSTOMER ANALYSIS
-- ============================================================

-- ------------------------------------------------------------
-- Q3: Customer Distribution by City
-- Business Question: "Which cities have the most customers?
--                    Where should we open new branches?"
-- ------------------------------------------------------------
SELECT
    city,
    COUNT(*)                                    AS customer_count,
    ROUND(COUNT(*) * 100.0 / 
        (SELECT COUNT(*) FROM customers), 2)    AS percentage
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

-- Insight: Top cities reveal where bank has strongest presence.
--          Low percentage cities are expansion opportunities.


-- ------------------------------------------------------------
-- Q4: Customer Age Segmentation
-- Business Question: "What is the age profile of our
--                    customer base?"
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN age < 25              THEN 'Gen Z (Below 25)'
        WHEN age BETWEEN 25 AND 35 THEN 'Millennial (25-35)'
        WHEN age BETWEEN 36 AND 50 THEN 'Gen X (36-50)'
        WHEN age > 50              THEN 'Boomer (Above 50)'
    END                         AS age_segment,
    COUNT(*)                    AS customer_count,
    ROUND(AVG(age), 1)          AS avg_age,
    MIN(age)                    AS youngest,
    MAX(age)                    AS oldest
FROM customers
GROUP BY age_segment
ORDER BY customer_count DESC;

-- Insight: Understanding age distribution helps design
--          targeted products — digital banking for Gen Z,
--          retirement plans for Boomers.


-- ------------------------------------------------------------
-- Q5: Customer Tenure Analysis
-- Business Question: "How loyal is our customer base?
--                    Who are our most loyal customers?"
-- ------------------------------------------------------------
SELECT
    CONCAT(first_name, ' ', last_name)              AS customer_name,
    city,
    joined_date,
    DATEDIFF(CURDATE(), joined_date)                AS days_with_bank,
    ROUND(DATEDIFF(CURDATE(), joined_date)/365, 1)  AS years_with_bank,
    CASE
        WHEN DATEDIFF(CURDATE(), joined_date) > 1825 THEN 'Loyal (5+ Years)'
        WHEN DATEDIFF(CURDATE(), joined_date) > 365  THEN 'Regular (1-5 Years)'
        ELSE                                              'New (< 1 Year)'
    END                                             AS loyalty_segment
FROM customers
ORDER BY days_with_bank DESC;

-- Insight: Loyal customers are prime candidates for premium
--          products, credit limit increases, and reward programs.


-- ------------------------------------------------------------
-- Q6: New Customer Acquisition Trend by Year
-- Business Question: "Is our customer acquisition growing
--                    year over year?"
-- ------------------------------------------------------------
SELECT
    YEAR(joined_date)   AS join_year,
    COUNT(*)            AS new_customers
FROM customers
GROUP BY join_year
ORDER BY join_year ASC;

-- Insight: Growing numbers indicate successful marketing.
--          Declining numbers signal need for acquisition campaigns.


-- ============================================================
-- SECTION 3: ACCOUNT ANALYSIS
-- ============================================================

-- ------------------------------------------------------------
-- Q7: Account Portfolio Breakdown
-- Business Question: "How are our accounts distributed
--                    across types and statuses?"
-- ------------------------------------------------------------
SELECT
    account_type,
    COUNT(*)                                                    AS total_accounts,
    COUNT(CASE WHEN status = 'active' THEN 1 END)              AS active,
    COUNT(CASE WHEN status = 'closed' THEN 1 END)              AS closed,
    COUNT(CASE WHEN status = 'frozen' THEN 1 END)              AS frozen,
    ROUND(SUM(CASE WHEN status = 'active' THEN balance ELSE 0 END), 2) AS active_balance
FROM accounts
GROUP BY account_type
ORDER BY active_balance DESC;

-- Insight: FD accounts likely hold most balance despite fewer
--          accounts. Frozen accounts need immediate attention.


-- ------------------------------------------------------------
-- Q8: Account Balance Tier Classification
-- Business Question: "How many accounts fall in each
--                    wealth tier?"
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN balance > 1000000 THEN 'Platinum (Above 10L)'
        WHEN balance > 500000  THEN 'Gold (5L - 10L)'
        WHEN balance > 100000  THEN 'Silver (1L - 5L)'
        WHEN balance > 0       THEN 'Bronze (Below 1L)'
        ELSE                        'Empty Account'
    END                     AS balance_tier,
    COUNT(*)                AS account_count,
    ROUND(SUM(balance), 2)  AS total_balance
FROM accounts
GROUP BY balance_tier
ORDER BY total_balance DESC;

-- Insight: Platinum and Gold tier accounts hold majority of
--          bank deposits despite being fewer in number.
--          80/20 rule in banking.


-- ------------------------------------------------------------
-- Q9: Customers with Multiple Accounts
-- Business Question: "Which customers have more than one
--                    account with us?"
-- ------------------------------------------------------------
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name)  AS customer_name,
    c.city,
    COUNT(a.account_id)                      AS total_accounts,
    ROUND(SUM(a.balance), 2)                 AS total_balance,
    GROUP_CONCAT(a.account_type
        ORDER BY a.account_type
        SEPARATOR ', ')                      AS account_types
FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
HAVING total_accounts > 1
ORDER BY total_accounts DESC, total_balance DESC;

-- Insight: Multi-account customers are highly engaged.
--          High value targets for cross-selling opportunities.


-- ------------------------------------------------------------
-- Q10: Top 10 Customers by Total Balance
-- Business Question: "Who are our most valuable
--                    customers by total deposits?"
-- ------------------------------------------------------------
SELECT
    CONCAT(c.first_name, ' ', c.last_name)  AS customer_name,
    c.city,
    COUNT(a.account_id)                      AS accounts,
    ROUND(SUM(a.balance), 2)                 AS total_balance,
    DENSE_RANK() OVER(
        ORDER BY SUM(a.balance) DESC
    )                                        AS wealth_rank
FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.status = 'active'
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY total_balance DESC
LIMIT 10;

-- Insight: Top 10 customers likely hold 60-70% of total
--          deposits. Priority segment for relationship managers.


-- ============================================================
-- SECTION 4: TRANSACTION ANALYSIS
-- ============================================================

-- ------------------------------------------------------------
-- Q11: Monthly Transaction Trend (2024)
-- Business Question: "How is transaction volume trending
--                    month by month in 2024?"
-- ------------------------------------------------------------
SELECT
    MONTHNAME(txn_date)                                         AS month_name,
    MONTH(txn_date)                                             AS month_num,
    COUNT(*)                                                    AS total_transactions,
    SUM(CASE WHEN txn_type = 'credit' THEN amount ELSE 0 END)  AS total_credits,
    SUM(CASE WHEN txn_type = 'debit'  THEN amount ELSE 0 END)  AS total_debits,
    ROUND(
        SUM(CASE WHEN txn_type = 'credit' THEN amount ELSE 0 END) -
        SUM(CASE WHEN txn_type = 'debit'  THEN amount ELSE 0 END)
    , 2)                                                        AS net_flow
FROM transactions
WHERE YEAR(txn_date) = 2024
GROUP BY month_name, month_num
ORDER BY month_num ASC;

-- Insight: Positive net flow = more money coming in than going
--          out. Negative months need investigation.


-- ------------------------------------------------------------
-- Q12: Transaction Pattern by Type
-- Business Question: "What is the split between credits
--                    and debits across all transactions?"
-- ------------------------------------------------------------
SELECT
    txn_type,
    COUNT(*)                    AS transaction_count,
    ROUND(SUM(amount), 2)       AS total_amount,
    ROUND(AVG(amount), 2)       AS avg_amount,
    MAX(amount)                 AS largest_transaction,
    MIN(amount)                 AS smallest_transaction
FROM transactions
GROUP BY txn_type;

-- Insight: Comparing credit vs debit totals shows if customers
--          are net savers or net spenders.


-- ------------------------------------------------------------
-- Q13: Top 10 Highest Value Transactions
-- Business Question: "What are the largest individual
--                    transactions ever recorded?"
-- ------------------------------------------------------------
SELECT
    t.txn_id,
    CONCAT(c.first_name, ' ', c.last_name)  AS customer_name,
    a.account_type,
    t.txn_type,
    t.amount,
    t.txn_date,
    t.description
FROM transactions t
INNER JOIN accounts  a ON t.account_id  = a.account_id
INNER JOIN customers c ON a.customer_id = c.customer_id
ORDER BY t.amount DESC
LIMIT 10;

-- Insight: Large transactions need monitoring for fraud
--          detection and AML (Anti Money Laundering) compliance.


-- ------------------------------------------------------------
-- Q14: Running Balance Trend
-- Business Question: "What is our cumulative transaction
--                    volume over time?"
-- ------------------------------------------------------------
SELECT
    txn_date,
    txn_type,
    amount,
    description,
    ROUND(SUM(amount) OVER(
        ORDER BY txn_date, txn_id
    ), 2)                       AS cumulative_volume
FROM transactions
ORDER BY txn_date ASC, txn_id ASC;

-- Insight: Running total shows overall bank transaction
--          activity growth over time. Upward trend = growth.


-- ============================================================
-- SECTION 5: LOAN PORTFOLIO ANALYSIS
-- ============================================================

-- ------------------------------------------------------------
-- Q15: Loan Portfolio Summary by Type
-- Business Question: "How is our loan book distributed
--                    across different loan types?"
-- ------------------------------------------------------------
SELECT
    loan_type,
    COUNT(*)                        AS total_loans,
    ROUND(SUM(loan_amount), 2)      AS total_disbursed,
    ROUND(AVG(loan_amount), 2)      AS avg_loan_size,
    ROUND(AVG(interest_rate), 2)    AS avg_interest_rate,
    COUNT(CASE WHEN status = 'active'    THEN 1 END) AS active,
    COUNT(CASE WHEN status = 'closed'    THEN 1 END) AS closed,
    COUNT(CASE WHEN status = 'defaulted' THEN 1 END) AS defaulted
FROM loans
GROUP BY loan_type
ORDER BY total_disbursed DESC;

-- Insight: Home loans likely dominate the portfolio.
--          High default count in any type = risk alert.


-- ------------------------------------------------------------
-- Q16: Loan Risk Classification
-- Business Question: "What is our current loan risk
--                    exposure?"
-- ------------------------------------------------------------
SELECT
    CONCAT(c.first_name, ' ', c.last_name)  AS customer_name,
    c.city,
    l.loan_type,
    l.loan_amount,
    l.interest_rate,
    l.status,
    CASE
        WHEN l.status = 'defaulted'
             THEN 'HIGH RISK - Defaulted'
        WHEN l.status = 'active'
             AND l.interest_rate > 12
             THEN 'MEDIUM RISK - High Rate Active'
        WHEN l.status = 'active'
             AND l.interest_rate <= 12
             THEN 'LOW RISK - Normal Active'
        ELSE 'CLOSED - No Risk'
    END                                     AS risk_classification
FROM customers c
INNER JOIN loans l ON c.customer_id = l.customer_id
ORDER BY
    CASE l.status
        WHEN 'defaulted' THEN 1
        WHEN 'active'    THEN 2
        ELSE 3
    END,
    l.loan_amount DESC;

-- Insight: Defaulted loans need immediate recovery action.
--          High rate active loans need monitoring.


-- ------------------------------------------------------------
-- Q17: City-wise Loan Distribution
-- Business Question: "Which cities have the highest
--                    loan exposure?"
-- ------------------------------------------------------------
SELECT
    c.city,
    COUNT(l.loan_id)                AS total_loans,
    ROUND(SUM(l.loan_amount), 2)    AS total_loan_value,
    ROUND(AVG(l.interest_rate), 2)  AS avg_rate,
    COUNT(CASE WHEN l.status = 'defaulted' THEN 1 END) AS defaults
FROM customers c
INNER JOIN loans l ON c.customer_id = l.customer_id
GROUP BY c.city
ORDER BY total_loan_value DESC;

-- Insight: Cities with high loans AND high defaults are
--          risk concentration zones requiring attention.


-- ------------------------------------------------------------
-- Q18: Default Rate Analysis
-- Business Question: "What percentage of our loans
--                    have defaulted?"
-- ------------------------------------------------------------
SELECT
    loan_type,
    COUNT(*)                                                AS total_loans,
    COUNT(CASE WHEN status = 'defaulted' THEN 1 END)       AS defaulted_loans,
    ROUND(
        COUNT(CASE WHEN status = 'defaulted' THEN 1 END) * 100.0
        / COUNT(*), 2
    )                                                       AS default_rate_pct,
    ROUND(SUM(CASE WHEN status = 'defaulted'
              THEN loan_amount ELSE 0 END), 2)             AS defaulted_amount
FROM loans
GROUP BY loan_type
ORDER BY default_rate_pct DESC;

-- Insight: High default rate % in any loan type signals
--          poor underwriting standards for that product.


-- ============================================================
-- SECTION 6: ADVANCED ANALYSIS
-- ============================================================

-- ------------------------------------------------------------
-- Q19: Customers with Loans but Low Balance (Risk Flag)
-- Business Question: "Which customers have active loans
--                    but dangerously low account balance?"
-- ------------------------------------------------------------
SELECT
    CONCAT(c.first_name, ' ', c.last_name)      AS customer_name,
    c.city,
    l.loan_type,
    l.loan_amount,
    ROUND(SUM(a.balance), 2)                     AS total_balance,
    ROUND(SUM(a.balance) * 100.0
          / l.loan_amount, 2)                    AS balance_to_loan_pct,
    CASE
        WHEN SUM(a.balance) < l.loan_amount * 0.1
             THEN 'CRITICAL - Below 10% of Loan'
        WHEN SUM(a.balance) < l.loan_amount * 0.25
             THEN 'WARNING - Below 25% of Loan'
        ELSE 'STABLE'
    END                                          AS risk_flag
FROM customers c
INNER JOIN loans    l ON c.customer_id = l.customer_id
INNER JOIN accounts a ON c.customer_id = a.customer_id
WHERE l.status = 'active'
  AND a.status = 'active'
GROUP BY c.customer_id, c.first_name, c.last_name,
         c.city, l.loan_type, l.loan_amount
HAVING total_balance < l.loan_amount
ORDER BY balance_to_loan_pct ASC;

-- Insight: Critical risk flag customers need urgent outreach.
--          Balance below 10% of loan = potential default risk.


-- ------------------------------------------------------------
-- Q20: Customer Wealth Ranking with Transaction Activity
-- Business Question: "Who are our most valuable customers
--                    combining both balance and activity?"
-- ------------------------------------------------------------
SELECT
    CONCAT(c.first_name, ' ', c.last_name)      AS customer_name,
    c.city,
    ROUND(SUM(DISTINCT a.balance), 2)            AS total_balance,
    COUNT(DISTINCT t.txn_id)                     AS total_transactions,
    ROUND(SUM(t.amount), 2)                      AS total_txn_volume,
    RANK() OVER(
        ORDER BY SUM(DISTINCT a.balance) DESC
    )                                            AS balance_rank,
    CASE
        WHEN SUM(DISTINCT a.balance) > 500000
             AND COUNT(DISTINCT t.txn_id) > 5
             THEN 'PLATINUM CUSTOMER'
        WHEN SUM(DISTINCT a.balance) > 100000
             AND COUNT(DISTINCT t.txn_id) > 3
             THEN 'GOLD CUSTOMER'
        WHEN SUM(DISTINCT a.balance) > 50000
             THEN 'SILVER CUSTOMER'
        ELSE 'STANDARD CUSTOMER'
    END                                          AS customer_tier
FROM customers c
INNER JOIN accounts     a ON c.customer_id = a.customer_id
INNER JOIN transactions t ON a.account_id  = t.account_id
WHERE a.status = 'active'
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY total_balance DESC;

-- Insight: Platinum customers deserve dedicated relationship
--          managers, exclusive offers, and priority service.
--          This query drives customer relationship strategy.

-- ============================================================
-- END OF ANALYSIS
-- Banking Customer & Transaction Analysis
-- 20 Queries | 6 Sections | Complete Banking Intelligence
-- ============================================================
