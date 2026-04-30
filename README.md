# Healthcare-Sql-Analysis-
SQL analysis of hospital encounters, cost, and patient behavior.

## Overview
This project analyzes hospital encounter data using SQL to uncover insights related to patient visits, healthcare costs, insurance coverage, and readmission trends.

The objective is to transform raw healthcare data into meaningful business insights that can support operational efficiency, financial planning, and patient care improvement.

---

## 📌 Problem Statement
Healthcare organizations generate large volumes of patient encounter data.

This project answers key analytical questions such as:

- How have patient encounters changed over time?
- Which encounter types are most common?
- What are the costliest medical procedures?
- How effective is payer coverage?
- Which patients show repeated readmission patterns?

---

## 🗂️ Dataset Used
Hospital database containing:

- **Encounters**
- **Patients**
- **Procedures**
- **Payers**

---

## 🛠️ Tools & Technologies
- MySQL
- SQL
- Window Functions
- Common Table Expressions (CTEs)
- Aggregate Functions
- Date Functions
- Conditional Logic

---

## 🔍 Project Objectives

### 1. Encounters Overview
Analyzed hospital encounters to identify:

- Total yearly encounters
- Encounter class distribution
- Long-duration vs short-duration encounters

---

### 2. Cost & Coverage Insights
Performed financial analysis to determine:

- Zero payer coverage encounters
- Most frequent procedures
- Highest average cost procedures
- Average claim cost by payer

---

### 3. Patient Behavior Analysis
Studied patient interaction patterns including:

- Quarterly patient admissions
- Readmissions within 30 days
- Patients with highest readmission frequency

---

## Key SQL Concepts Used


## SQL Concepts Used
- Aggregate Functions (`COUNT`, `SUM`, `AVG`)
- Conditional Logic (`CASE WHEN`)
- Common Table Expressions (CTEs)
- Window Functions (`LEAD`)
- Joins
- Date Functions:
  - `YEAR()`
  - `QUARTER()`
  - `DATEDIFF()`
  - `TIMESTAMPDIFF()`

---

  ## 🧩 Future Enhancements
  
- Build Power BI dashboard for visualization
- Automate pipeline using Azure Data Factory (ADF)
- Implement incremental data loading
