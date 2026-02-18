# 🛒 Walmart Sales Data Analysis — End-to-End SQL + Python Project

## 📌 Project Overview

An end-to-end data analysis project that extracts actionable business insights from **10,000+ Walmart sales transactions**. The project covers the full data pipeline — from raw data ingestion and cleaning in Python to advanced SQL querying in MySQL — answering real-world business questions around revenue, customer behavior, and branch performance.

> **Tech Stack:** Python · Pandas · NumPy · MySQL · SQLAlchemy · Jupyter Notebook

---

## 🎯 Business Questions Answered

| # | Business Question |
|---|---|
| 1 | Which payment method is most frequently used by customers? |
| 2 | Which payment method drives the most total revenue? |
| 3 | How many unique branches does Walmart operate? |
| 4 | What is the transaction count and total quantity sold per payment method? |
| 5 | Which product category has the highest average rating in each branch? |
| 6 | What is the average customer rating per branch? |
| 7 | Which day of the week is the busiest for each branch? |
| 8 | What are the total quantity of items sold per payment method? |
| 9 | What are the average, min, and max ratings per category by city? |
| 10 | Which category generates the highest total profit? |
| 11 | What is the preferred payment method for each branch? |
| 12 | How are sales distributed across Morning, Afternoon, and Evening shifts? |
| 13 | Which 5 branches experienced the highest revenue decline from 2022 to 2023? |

---

## 🗂️ Project Structure

```
walmart-sales-analysis/
│
├── data/
│   ├── Walmart.csv              # Raw dataset (from Kaggle)
│   └── Walmart_clean.csv        # Cleaned & transformed dataset
│
├── notebooks/
│   └── Analysis.ipynb           # Full Python EDA & data cleaning pipeline
│
├── sql_queries/
│   └── walmartdb.sql            # All SQL business queries
│
├── README.md                    # Project documentation
└── requirements.txt             # Python dependencies
```

---

## 🔄 Project Pipeline

```
Kaggle API  →  Raw CSV  →  Python Cleaning  →  MySQL  →  SQL Analysis  →  Insights
```

---

## 🧹 Data Cleaning & Feature Engineering (Python)

The following steps were performed in `Analysis.ipynb`:

- **Loaded** 10,000+ records from `Walmart.csv` using Pandas
- **Removed missing values** from critical columns (`unit_price`, `quantity`) — rows dropped rather than imputed to preserve data integrity
- **Removed duplicates** to prevent skewed aggregations
- **Fixed data types** — stripped `$` symbols from `unit_price` and cast to `float`
- **Feature engineered** a new `Total_revenue` column: `unit_price × quantity`
- **Exported** clean data to `Walmart_clean.csv` for SQL ingestion

---

## 🗄️ SQL Analysis Highlights

### 💳 Payment Method Analysis
Counted transactions and revenue contribution per payment method to identify the most popular and most profitable payment channels.

### 🏬 Branch Performance
- Identified the **busiest day** for each branch using `DAYNAME()` on transaction dates
- Ranked **preferred payment methods** per branch using `RANK() OVER (PARTITION BY Branch)`
- Calculated **average customer ratings** per branch

### ⭐ Category & City Insights
Analyzed average, minimum, and maximum ratings by category and city to uncover regional customer satisfaction trends.

### 💰 Profit Analysis
Computed total profit per category using the formula:
```sql
total_profit = unit_price × quantity × profit_margin
```

### 🕐 Shift Analysis
Classified all transactions into time shifts and measured invoice volume per shift:
- **Morning:** Before 12:00 PM  
- **Afternoon:** 12:00 PM – 5:00 PM  
- **Evening:** After 5:00 PM  

### 📉 Year-over-Year Revenue Decline
Used SQL Views and JOINs to compare 2022 vs. 2023 branch revenue and calculated the **decrease ratio** to flag underperforming branches:
```sql
Decrease_Ratio = (Revenue_2022 - Revenue_2023) / Revenue_2022 × 100
```

---

## ⚙️ Setup & Installation

### Prerequisites
- Python 3.8+
- MySQL Server
- Kaggle API Key

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/walmart-sales-analysis.git
cd walmart-sales-analysis
```

### 2. Install Python Dependencies
```bash
pip install pandas numpy sqlalchemy mysql-connector-python jupyter
```

### 3. Download the Dataset via Kaggle API
```bash
# Place kaggle.json in ~/.kaggle/
kaggle datasets download -d najir0123/walmart-10k-sales-datasets
```

### 4. Run the Notebook
```bash
jupyter notebook notebooks/Analysis.ipynb
```

### 5. Load Data into MySQL
The cleaned CSV is loaded into MySQL via SQLAlchemy inside the notebook. Then run the queries in `sql_queries/walmartdb.sql`.

---

## 📊 Key Insights

- **Payment Preferences:** Identified the dominant payment method by both transaction volume and revenue contribution across all branches.
- **Branch Activity:** Certain branches consistently show higher footfall on specific days, enabling better staff scheduling.
- **Profitability:** Some product categories significantly outperform others in profit margin — valuable for inventory prioritization.
- **Revenue Trends:** A subset of branches showed measurable revenue decline from 2022 to 2023, flagged for strategic review.
- **Customer Ratings:** Rating patterns vary by city and category, offering insights into regional product-market fit.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Python (Pandas, NumPy) | Data loading, cleaning, feature engineering |
| Jupyter Notebook | Interactive development & documentation |
| MySQL | Advanced querying and business analysis |
| SQLAlchemy | Python-to-MySQL data pipeline |
| SQL Views & Window Functions | Year-over-year analysis, ranking |

---

## 🚀 Future Enhancements

- Connect to a **Power BI or Tableau** dashboard for interactive visualization
- Automate the pipeline for **real-time data ingestion**
- Extend analysis with **customer segmentation** using clustering techniques
- Add a **PostgreSQL** layer for cross-database comparison

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙏 Acknowledgements

- **Dataset:** [Walmart 10K Sales Dataset on Kaggle](https://www.kaggle.com/najir0123/walmart-10k-sales-datasets) by Najir
- **Inspiration:** Real-world retail analytics use cases in sales and supply chain optimization
