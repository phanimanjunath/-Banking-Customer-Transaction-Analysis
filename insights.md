# Business Insights & Findings
## Banking Customer & Transaction Analysis

---

## 📋 Executive Summary

This analysis of the banking database reveals key patterns across
customer behaviour, account health, transaction activity, and loan
portfolio risk. The findings below are derived from 20 SQL queries
across 4 database tables — 50 customers, 62 accounts, 87 transactions,
and 40 loans.

---

## 👥 Section 1: Customer Insights

### Finding 1.1 — Geographic Concentration
- The bank's customer base is concentrated in **metro cities**
- Mumbai, Delhi, and Bangalore together account for the largest
  share of customers
- **Opportunity:** Tier-2 cities like Lucknow, Bhopal, Patna have
  low penetration — prime expansion targets

### Finding 1.2 — Age Demographics
- **Millennial segment (25-35)** is the largest customer group
- **Boomer segment (50+)** customers have the highest average balances
- **Gen Z (below 25)** customers are underrepresented — opportunity
  for digital banking products

### Finding 1.3 — Customer Loyalty
- Customers who joined before 2019 (5+ year customers) represent
  the **Loyal** segment and hold the highest average balances
- Loyal customers are ideal candidates for:
  - Premium credit cards
  - Investment products
  - Higher credit limits

### Finding 1.4 — Acquisition Trend
- Customer acquisition peaked in certain years and slowed in others
- Years with low acquisition numbers signal need for marketing campaigns
- Digital channels (post-2020) show improving acquisition rates

---

## 🏦 Section 2: Account Insights

### Finding 2.1 — Account Type Distribution
- **Savings accounts** are the most common account type
- **Fixed Deposit (FD) accounts** hold the highest total balance
  despite being fewer in number — confirming the 80/20 rule
- **Frozen accounts** require immediate compliance review

### Finding 2.2 — Wealth Tier Analysis
```
Platinum (Above 10L)  → Few accounts, massive deposits
Gold     (5L - 10L)   → Medium count, high deposits
Silver   (1L - 5L)    → Growing segment
Bronze   (Below 1L)   → Largest count, lowest deposits
Empty    (Zero)       → Dormant risk — needs outreach
```

### Finding 2.3 — Multi-Account Customers
- Several customers hold 2-3 accounts simultaneously
- Multi-account customers show **higher engagement** and **higher balances**
- These customers are the bank's most loyal and cross-sell ready segment
- **Recommendation:** Assign dedicated relationship managers to
  all customers with 2+ accounts

### Finding 2.4 — Top 10 Customer Concentration
- Top 10 customers by balance hold a disproportionate share of
  total bank deposits
- **Risk:** High concentration in few customers creates liquidity risk
  if they withdraw simultaneously
- **Action:** Diversify deposit base through acquisition campaigns

---

## 💳 Section 3: Transaction Insights

### Finding 3.1 — Monthly Transaction Trend
- **January** shows the highest transaction volume — salary season
- Transaction volumes are consistent month-over-month in 2024
- **Net flow** (credits minus debits) remains positive — healthy sign
- Months with negative net flow need investigation

### Finding 3.2 — Credit vs Debit Split
- Credit transactions are larger in individual amount (salaries,
  business income, FD interest)
- Debit transactions are more frequent but smaller in amount
  (bills, groceries, EMIs)
- This pattern is typical of a **retail banking** customer base

### Finding 3.3 — High Value Transactions
- Top 10 transactions are dominated by:
  - FD openings and maturities
  - Business revenue credits
  - Large vendor payments
- These transactions need **enhanced due diligence** under
  AML (Anti Money Laundering) guidelines

### Finding 3.4 — Cumulative Volume Growth
- Running transaction total shows steady growth through 2024
- Upward trend confirms **increasing customer engagement**
- Plateau periods indicate seasonal slowdowns

---

## 🏛️ Section 4: Loan Portfolio Insights

### Finding 4.1 — Loan Book Composition
```
Home Loans      → Largest by value, lowest default rate
Personal Loans  → Highest default rate, smaller amounts
Auto Loans      → Mid-size, moderate default rate
Education Loans → Smallest count, long tenure
```

### Finding 4.2 — Risk Classification
- **High Risk (Defaulted):** Customers who have stopped repayment
  — require immediate recovery action
- **Medium Risk:** Active loans with interest rate above 12%
  — monitor closely for stress signals
- **Low Risk:** Active loans with standard rates — routine monitoring

### Finding 4.3 — Geographic Loan Concentration
- Cities with both **high loan values AND high default counts**
  are risk concentration zones
- **Recommendation:** Tighten underwriting criteria for
  high-default cities

### Finding 4.4 — Default Rate Analysis
- Personal loans show the highest default rate percentage
- This is consistent with industry benchmarks — personal loans
  are unsecured and higher risk
- **Recommendation:** Reduce personal loan exposure or increase
  interest rates to compensate for higher risk

---

## ⭐ Section 5: Advanced Insights

### Finding 5.1 — Critical Risk Customers (Q19)
- Several customers have **active loans with account balance
  below 10% of their loan amount**
- This is the bank's most urgent risk segment
- **Immediate Action Required:**
  - Personal outreach within 48 hours
  - Offer loan restructuring options
  - Increase EMI monitoring frequency

### Finding 5.2 — Customer Value Tiers (Q20)
```
PLATINUM → High balance + High transaction activity
           → Dedicated relationship manager
           → Exclusive product access

GOLD     → Good balance + Moderate activity
           → Priority customer service
           → Premium product offers

SILVER   → Decent balance, lower activity
           → Engagement campaigns needed
           → Digital banking push

STANDARD → Low balance, low activity
           → Retention risk
           → Reactivation campaigns
```

---

## 🎯 Strategic Recommendations

### Immediate Actions (0-30 days)
1. Contact all **Critical Risk** customers (Q19 findings)
2. Review all **frozen accounts** for compliance
3. Investigate **top 10 large transactions** for AML compliance

### Short Term Actions (1-3 months)
1. Launch **loyalty rewards program** for 5+ year customers
2. Design **Gen Z digital banking** product line
3. Assign relationship managers to all **Platinum customers**
4. Implement stricter underwriting for **personal loans**

### Long Term Strategy (3-12 months)
1. **Geographic expansion** into Tier-2 cities
2. **Deposit diversification** to reduce top-10 customer concentration
3. **Cross-sell program** targeting multi-account holders
4. **Default prevention** model using balance-to-loan ratio monitoring

---

## 📊 Key Metrics Summary

| Metric | Value |
|--------|-------|
| Total Customers | 50 |
| Cities Covered | 15+ |
| Active Accounts | ~55 |
| Total Deposits | Significant |
| Active Loans | ~25 |
| Default Rate | ~15% of loans |
| Platinum Customers | Top 10 by balance |
| Critical Risk Customers | Identified in Q19 |

---

*Analysis performed using MySQL on banking_db*
*Queries available in analysis.sql*
*Database setup available in banking_db_setup.sql*
