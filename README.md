# E-Commerce-Customer-Intelligence-Revenue
# 📊 E-Commerce End-to-End Analytics: SQL & Power BI

An end-to-end data analytics project exploring customer purchasing behavior, revenue trends, product catalog performance, and logistics fulfillment using **MySQL** and **Power BI**.

```
[ MySQL Relational DB ] ──(Import / Power Query)──> [ Power BI Data Model ] ──(DAX)──> [ Interactive Dashboard ]
```

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
  ```

* **Total Revenue:**
  ```dax
  Total Revenue = SUMX(order_items, order_items[quantity] * order_items[unit_price])
  ```

* **Active Customers:**
  ```dax
  Active Customers = DISTINCTCOUNT(orders[customer_id])
  ```

* **On-Time Delivery Rate:**
  ```dax
  On-Time Delivery Rate =
  DIVIDE(
      CALCULATE(COUNTROWS(shipments), shipments[delivery_status] = "On Time"),
      COUNTROWS(shipments),
      0
  )
  ```

* **Month-over-Month Revenue Growth:**
  ```dax
  MoM Revenue Growth =
  VAR CurrentRevenue = [Total Revenue]
  VAR PreviousRevenue =
      CALCULATE([Total Revenue], DATEADD(Dim_Date[Date], -1, MONTH))
  RETURN
      DIVIDE(CurrentRevenue - PreviousRevenue, PreviousRevenue, 0)
  ```

---

## 📌 Project Architecture

```
┌─────────────────────────┐     ┌──────────────────────────┐     ┌───────────────────────────┐
│      MySQL 8.0 (DB)      │     │   Power Query (ETL)       │     │   Power BI Data Model      │
│  ─────────────────────   │     │  ───────────────────────  │     │  ─────────────────────────  │
│  customers                │     │  • Cleaning & type casts   │     │  Star Schema:               │
│  products                 │ ──▶ │  • Deduplication            │ ──▶ │  Fact: orders, order_items, │
│  orders                   │     │  • Null handling            │     │        payments, shipments, │
│  order_items               │     │  • Merge/append queries     │     │        reviews               │
│  payments                  │     │  • Date table generation    │     │  Dim: customers, products,   │
│  shipments                 │     │                              │     │       Dim_Date                │
│  reviews                   │     │                              │     │                              │
└─────────────────────────┘     └──────────────────────────┘     └──────────────┬─────────────┘
                                                                                   │  DAX Measures
                                                                                   ▼
                                                                     ┌───────────────────────────┐
                                                                     │   Interactive Dashboard    │
                                                                     │  ─────────────────────────  │
                                                                     │  1. Executive Overview      │
                                                                     │  2. Customer & Product      │
                                                                     │  3. Logistics & Operations  │
                                                                     └───────────────────────────┘
```

**Data flow summary:**
1. Raw transactional data is generated/loaded into MySQL and structured into a normalized Star Schema.
2. SQL is used for exploratory analysis, business-question resolution, and data validation before import.
3. Power BI connects via Power Query, applying transformation steps (cleaning, merging, date dimension creation).
4. Relationships are modeled (1-to-many) between fact and dimension tables in the Power BI data model.
5. DAX measures compute KPIs consumed across the three report pages.
6. The dashboard is published/refreshed for stakeholder consumption.

---

## 📂 Repository Structure

```
E-Commerce-Customer-Intelligence-Revenue/
│
├── sql/
│   ├── 01_schema_ddl.sql          # Table creation scripts
│   ├── 02_sample_data.sql         # Seed / sample data (if applicable)
│   ├── 03_business_queries.sql    # Core analytical queries (CTEs, window functions, subqueries)
│   └── 04_views.sql               # Reusable views for Power BI import
│
├── powerbi/
│   └── ecommerce_dashboard.pbix   # Power BI report file
│
├── assets/
│   └── screenshots/               # Dashboard preview images
│
└── README.md
```

---

## ⚙️ Setup & Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/E-Commerce-Customer-Intelligence-Revenue.git
   cd E-Commerce-Customer-Intelligence-Revenue
   ```

2. **Set up the database**
   * Open MySQL Workbench and run `sql/01_schema_ddl.sql` to create the schema.
   * Run `sql/02_sample_data.sql` to populate sample data.
   * Optionally run `sql/04_views.sql` to create reporting views used by Power BI.

3. **Connect Power BI**
   * Open `powerbi/ecommerce_dashboard.pbix` in Power BI Desktop.
   * Update the MySQL connector credentials under **Transform Data → Data Source Settings**.
   * Click **Refresh** to pull the latest data into the model.

4. **Explore the dashboard**
   * Navigate across the three report pages: Executive Overview, Customer & Product Deep-Dive, Logistics & Operations.

---

## 💡 Key Insights & Findings

* Revenue is concentrated in a small set of top-performing categories, consistent with an 80/20 demand pattern.
* A measurable share of the catalog carries zero historical sales, flagging inventory/purchasing review opportunities.
* On-time delivery performance varies meaningfully by carrier, informing logistics partner prioritization.
* One payment method dominates transaction volume, relevant for checkout UX and processing-fee negotiations.

---

## 🚀 Future Enhancements

* [ ] Incorporate RFM (Recency, Frequency, Monetary) customer segmentation.
* [ ] Add cohort-based retention analysis.
* [ ] Automate the MySQL → Power BI refresh via a scheduled ETL pipeline.
* [ ] Introduce predictive churn scoring using historical order patterns.
* [ ] Deploy the dashboard to Power BI Service with row-level security by region.

---

## 👤 Author

**Karthik**
B.Tech Computer Science, Mahindra University
🔗 [GitHub](https://github.com/srikarkarthik-678) • [LinkedIn](https://linkedin.com/in/srikar-karthik-4723b32b4)

---

## 📄 License

This project is available under the MIT License — feel free to fork, adapt, and build on it.
