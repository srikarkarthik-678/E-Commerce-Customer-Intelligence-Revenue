# E-Commerce-Customer-Intelligence-Revenue


# 📊 E-Commerce End-to-End Analytics: SQL & Power BI

An end-to-end data analytics project exploring customer purchasing behavior, revenue trends, product catalog performance, and logistics fulfillment using **MySQL** and **Power BI**.

[ MySQL Relational DB ] ──(Import / Power Query)──> [ Power BI Data Model ] ──(DAX)──> [ Interactive Dashboard ]

---

## 🛠️ Tech Stack & Tools

* **Database Engine:** MySQL 8.0 (Workbench)
* **Business Intelligence:** Microsoft Power BI Desktop
* **Data Modeling:** Star Schema (1-to-many relationships)
* **Analytics Languages:** SQL (DDL, DML, CTEs, Window Functions, Correlated Subqueries), DAX (Time Intelligence, Iterators)

<img width="1880" height="859" alt="image" src="https://github.com/user-attachments/assets/9766de9a-5e04-4b3c-a410-899757074c20" />


<img width="1736" height="892" alt="image" src="https://github.com/user-attachments/assets/b0a7a9f5-72f6-4b1c-ae2a-5b1ed5344183" />

---

## 🗄️ Database Design & Schema

The relational database consists of 7 core tables modeled into a Star Schema:
* **Fact Tables:** `orders`, `order_items`, `payments`, `shipments`, `reviews`
* **Dimension Tables:** `customers`, `products`, `Dim_Date`

---

## 🔍 Key SQL Business Problems Solved

1. **Category Benchmark Analysis:** Correlated subqueries and CTEs identifying products priced strictly above their respective category average.
2. **Review Satisfaction Scoring:** Compared individual product average review ratings against category benchmarks using aggregated derived tables.
3. **Inventory & Sales Auditing:** Identified unsold products (0 sales) using `LEFT JOIN` and `IS NULL` filters.
4. **Volume Outliers:** Computed products exceeding the platform-wide average quantity sold using nested aggregations in `HAVING` clauses.
5. **Payment Method Popularity:** Extracted order records associated with the top transaction method via derived tables.

---

## 📈 Power BI Dashboard Architecture

The Power BI report contains three dedicated analysis views:

1. **Executive Overview:**
   * High-level KPIs: Total Revenue, Total Orders, Average Order Value (AOV), Active Customers.
   * Monthly Revenue Trends vs. Order Volume.
   * Payment Method distribution and Top 5 Product Categories.

2. **Customer & Product Deep-Dive:**
   * Customer Lifetime Spending segmentation.
   * Unit demand vs. catalog price benchmarks.
   * Review rating distribution by department.

3. **Logistics & Operations:**
   * On-time delivery rate percentage.
   * Turnaround times across shipping carriers.

---

## 📐 Key DAX Measures Implemented

* **Average Order Value (AOV):**
  ```dax
  Average Order Value = DIVIDE([Total Revenue], [Total Orders], 0)


---

## 📌 Project Architecture
