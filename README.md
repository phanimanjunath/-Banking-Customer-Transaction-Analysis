# Banking Customer & Transaction Analysis Using MySQL

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat&logo=mysql)
![Status](https://img.shields.io/badge/Status-Completed-green?style=flat)
![Queries](https://img.shields.io/badge/Queries-20-orange?style=flat)
![Domain](https://img.shields.io/badge/Domain-Banking%20%26%20Finance-purple?style=flat)

---

## 📌 Project Overview

This project performs a comprehensive SQL-based analysis of a banking database — covering customer segmentation, account health, transaction trends, loan portfolio risk, and advanced analytics.

The goal is to simulate the work of a **Data Analyst at a bank** — answering real business questions that management, risk teams, and relationship managers ask every day.

---

## 🗄️ Database Schema

The database `banking_db` consists of **4 interconnected tables:**

```
customers
├── customer_id (PK)
├── first_name, last_name
├── email, phone
├── city, age, gender
└── joined_date

accounts
├── account_id (PK)
├── customer_id (FK → customers)
├── account_type (savings/current/fd)
├── balance
├── opened_date
└── status (active/closed/frozen)

transactions
├── txn_id (PK)
├── account_id (FK → accounts)
├── txn_type (credit/debit)
├── amount
├── txn_date
└── description

loans
├── loan_id (PK)
├── customer_id (FK → customers)
├── loan_type (home/personal/auto/education)
├── loan_amount, interest_rate
├── start_date, end_date
└── status (active/closed/defaulted)
```

**Entity Relationship:**
```
customers ──< accounts ──< transactions
customers ──< loans
```

---

## 📊 Analysis Sections
## 📂 Data Source

This project uses a **synthetic banking dataset**
created specifically for this analysis.
Designed to simulate a realistic Indian retail
banking environment. All data is fictional and
created for educational purposes only.

### Section 1: Database Overview (Q1-Q2)
- Complete database record summary
- Bank portfolio health dashboard

### Section 2: Customer Analysis (Q3-Q6)
- Customer distribution by city
- Age segmentation (Gen Z / Millennial / Gen X / Boomer)
- Customer tenure and loyalty analysis
- New customer acquisition trend by year

### Section 3: Account Analysis (Q7-Q10)
- Account portfolio breakdown by type and status
- Balance tier classification (Platinum/Gold/Silver/Bronze)
- Customers with multiple accounts
- Top 10 customers by total balance

### Section 4: Transaction Analysis (Q11-Q14)
- Monthly transaction trend (2024)
- Credit vs debit split analysis
- Top 10 highest value transactions
- Running cumulative transaction volume

### Section 5: Loan Portfolio Analysis (Q15-Q18)
- Loan portfolio summary by type
- Loan risk classification per customer
- City-wise loan distribution
- Default rate analysis by loan type

### Section 6: Advanced Analysis (Q19-Q20)
- Risk flagging — customers with loans but low balance
- Customer wealth ranking with transaction activity tier

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| MySQL 8.0 | Database & Query Engine |
| MySQL Workbench | Query Development & Testing |
| SQL | Analysis Language |

---

## 💡 SQL Concepts Demonstrated

| Concept | Used In |
|---------|---------|
| SELECT, WHERE, ORDER BY | All sections |
| GROUP BY & HAVING | Q3, Q4, Q7, Q8, Q9, Q11, Q15, Q17, Q18 |
| INNER JOIN | Q10, Q13, Q16, Q17, Q19, Q20 |
| LEFT JOIN | Schema design |
| Subqueries | Q2, Q19 |
| Window Functions (RANK, DENSE_RANK, SUM OVER) | Q10, Q14, Q20 |
| CASE WHEN | Q4, Q5, Q7, Q8, Q11, Q16, Q18, Q19, Q20 |
| Aggregate Functions | Q1, Q2, Q7, Q11, Q12, Q15, Q18 |
| Date Functions | Q5, Q6, Q11, Q14 |
| String Functions | Q3, Q9, Q10, Q13, Q16, Q19, Q20 |
| Conditional Aggregation (SUM CASE WHEN) | Q7, Q11, Q15, Q18 |

---

## 🔍 Key Business Insights

1. **Customer Concentration** — Top 3 cities account for majority of customers
2. **Wealth Distribution** — Platinum tier customers hold 60-70% of deposits
3. **Risk Exposure** — Identified customers with active loans and critically low balances
4. **Transaction Flow** — Monthly net flow analysis reveals bank liquidity health
5. **Default Patterns** — Personal loans show highest default rate percentage
6. **Loyalty Segments** — 5+ year customers are prime cross-sell targets

---

## 🚀 How to Run This Project

### Step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/Banking-Customer-Transaction-Analysis.git
cd Banking-Customer-Transaction-Analysis
```

### Step 2: Set Up the Database
```bash
# Open MySQL Workbench or MySQL CLI
# Run the schema setup file
source banking_db_setup.sql
```

### Step 3: Run the Analysis
```bash
# Run all 20 queries
source analysis.sql
```

### Step 4: Explore Results
- Each query has a business question and insight comment
- Run queries individually to explore specific sections
- Modify filters to explore different time periods or segments

---

## 📁 Project Structure

```
Banking-Customer-Transaction-Analysis/
├── README.md                    ← Project documentation
├── banking_db_setup.sql         ← Database creation + seed data
├── analysis.sql                 ← All 20 analysis queries
└── insights.md                  ← Business insights & findings
```

---

## 👤 Author

**Yanna Phani Manjunath Reddy**
- 🎓 B.Tech AIML — VIT-AP
- 💼 Aspiring Data Analyst
- 🔗 LinkedIn: www.linkedin.com/in/phanimanjunath
- 🐙 GitHub: https://github.com/phanimanjunath

---

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

---

*Built as part of my Data Analytics portfolio
during my B.Tech AIML — 3rd year.
Demonstrates real-world SQL skills for
data analyst placement preparation.*
