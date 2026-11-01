# 📊 F&B Operational Cost Control & Menu Profitability Optimization Framework
**Author:**
**Domain Expertise:** Banquet Operations, Kitchen Operations, and F&B Cost Control  

---

## 📌 1. Executive Business Case Study (The Management Thesis)

### Executive Summary
This corporate-level case study addresses a direct operational challenge in high-volume hospitality and hotel banquet management: profit margin erosion caused by unmonitored kitchen production food waste. By establishing a dual-layered data pipeline across SQL and Excel, this initiative successfully isolates hidden financial leakages and provides the executive leadership team with automated menu engineering decisions to protect and reclaim gross profit margins.

### Problem Statement
In large-scale kitchen and banquet environments, food cost control is traditionally managed through manual, reactive ledger checks rather than live data analysis.
* **Production Disconnect:** Kitchen production teams frequently over-prepare buffer portions due to a lack of historic batch-control data, directly resulting in massive material wastage.
* **The High-Volume Illusion:** Low unit-cost items (e.g., soups and desserts) mask substantial cumulative financial losses, creating hidden operational leakages that quietly erode monthly gross profit margins.

### Management Methodology & Benchmark Metrics
Using a standardized operational database of core banquet menu items, a 3-sheet automated logic framework was built based on two primary management benchmarks: **Food Cost Percentage** (Target Benchmark: ≤ 35%) and **Waste Ratio Percentage** (Target Benchmark: ≤ 15%). 

Through this analytical engine, menu items are dynamically classified into four corporate action quadrants:
* **⭐ STARS (Low Cost, Low Waste):** Highly efficient items (e.g., *Authentic Beef Rendang*) that maintain peak profitability. *Strategy: Maintain & Feature Prominently.*
* **🐎 PLOWHORSES (High Cost, Low Waste):** Popular items with high raw material costs (e.g., *Pan Seared Atlantic Salmon*). *Strategy: Review Portion Sizing or Adjust Pricing.*
* **🧩 PUZZLES (Low Cost, High Waste):** High financial leakage isolated in appetizers/soups (e.g., *Creamy Wild Mushroom Soup*). *Strategy: Target for Production Batch-Control and Staff Training.*
* **🐕 DOGS (High Cost, High Waste):** Highly inefficient items that actively drain business cash flow. *Strategy: Remove from Menu or Completely Redesign Recipes.*

---

## 🛠️ 2. Data Infrastructure & System Architecture (The Technical Lens)

This project utilizes an integrated data pipeline combining database querying (SQL) for extraction and dynamic business modeling (Excel) for reporting.

### Phase 1: Database Querying & Extraction (SQL)
Before building the analytical reporting model, a relational database environment was queried to extract raw banquet transactions. The core script (`01_waste_analysis_query.sql`) aggregates data using clean, standard SQL infrastructure:
* **`SUM` & `GROUP BY`:** Applied to aggregate multiple event transactional rows into clean, distinct menu summaries.
* **`WHERE` filtering:** Isolated specific high-volume operational events (`WHERE Event_Type = 'Banquet'`) to clean the data scope.
* **`ORDER BY` optimization:** Sorted rows by the highest financial leakage (`DESC`) to immediately surface the worst-performing operational items for management review.

### Phase 2: Integrated Excel Analytical Modeling (Corporate Navy Theme)
The extracted database rows were mapped across 3 continuous automated sheets without manual data redundancy, formatted cleanly using the premium `Segoe UI` typography with hidden gridlines for an application-style finish:

1. **`1 Raw Data`:** Standardized horizontal operational repository capturing event IDs, volumes prepared vs. wasted, unit costs, and retail margins using professional *Zebra Striping* for high readability.
2. **`2 Cost Calculation`:** Robust automated financial engine utilizing advanced `SUMIFS` data aggregation combined with `IFERROR` validation metrics to eliminate divide-by-zero faults. Includes a dedicated executive summary **TOTAL** row highlighted in *Ice Blue* with accounting-style double underlines.
3. **`3 Menu Engineering`:** A dynamic decision matrix driven by multi-tier `Nested IF` and `AND` logic to automatically output the final business strategies (*Maintain, Adjust Price, Reduce Waste, Remove Item*) backed by pastel-coded *Conditional Formatting* to draw direct management attention to target areas.

### 📊 Executive Dashboard Preview
Here is the visual overview of the interactive executive dashboard built using Pivot Tables and customized slicers:
![Corporate F&B Dashboard](dashboard_preview.png)

---

## 💡 3. Key Strategic Insights & Next Steps
1. **Bridging the Disconnect:** Automating the `Menu Classification` column bridges the gap between kitchen staff and financial management, turning raw transactional rows into immediate, strategic boardroom decisions.
2. **Variance Containment:** The data proves that reducing the variance in over-preparation via historical SQL queries is the fastest way to stabilize fluctuating food cost percentages before profit erosion impacts quarterly financial reviews.
