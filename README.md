# 📊 Data-Driven F&B Operational Cost Control & Menu Engineering Analytics

![SQL](https://shields.io)
![Excel](https://shields.io)
![Analytics](https://shields.io)
![Business Intelligence](https://shields.io)

An end-to-end operational analytics case study that bridges raw commercial kitchen inventory data with automated database engineering to maximize profitability and mitigate financial leaks within a full-service hotel Food & Beverage (F&B) ecosystem.

---

## 📑 Project Documentation
The complete, comprehensive 20-page academic-style mini-thesis documenting the full research methodology, data pre-processing protocols, mathematical derivations, and root-cause analysis can be accessed directly here:
👉 **[View Full Operations Thesis Documentation (PDF)](./FB_Cost_Control_Mini_Thesis.pdf)** *(Ensure you upload your exported PDF to the root directory)*

---

## 🚀 Business Problem & Core Insights
Large-scale hotel culinary operations routinely battle tight profit margins due to fluctuating raw ingredient inflation and **over-production waste**. This project isolates a baseline profit leakage of **RM5,143.30** out of an operational prepared baseline of **RM27,646.00**, representing an immediate **18.6% deduction from the gross profit margin**.

By deploying automated relational querying, this project transforms historical inventory records into a dynamic **Kasavana & Smith Menu Engineering Matrix**, classifying **35 items** across 4 core quadrants:

```text
       HIGH POPULARITY
              ▲
              │       PLOWHORSE       │          STAR
              │  (High Vol / Low % )  │  ( High Vol / High % )
              │                       │
LOW MARGIN ───┼───────────────────────┼───────────────────────► HIGH MARGIN
              │                       │
              │          DOG          │         PUZZLE
              │   (Low Vol / Low % )  │  ( Low Vol / High % )
              │                       │
              ▼
        LOW POPULARITY
```

### 💡 Core Operational Findings:
* **The Puzzle Monopoly (52% of Menu):** Over half of the hotel’s active dishes generate exceptional profit margins but suffer from slow sales velocity. Specialized fresh ingredients sit in storage, spoiling over time and directly driving the **RM5,143.30 waste footprint**.
* **The Plowhorse Volatility (37% of Menu):** Foundational volume drivers (heavily dominated by the beverage sector like *Iced Calamansi Lime Tea* with **>400 portions sold**) pull significant transaction volume but carry unfavorable food cost margins, making them highly sensitive to price changes.
* **The Star Anchor (11% of Menu):** Premium high-performing items like *Royal Saffron Rice* and *Honey Spiced Tomato Chicken* successfully achieve high market velocity while keeping food costs safely under the target **35% threshold**.

---

## 🗺️ Data Pipeline & Architecture
The project structure is engineered around a continuous, three-tiered business intelligence architecture:

```text
┌─────────────────────────────────┐      ┌─────────────────────────────────┐      ┌─────────────────────────────────┐
│     1. INPUT & STAGING          │      │    2. PROCESSING & AUTOMATION   │      │      3. VISUAL OUTPUT           │
│     (Microsoft Excel)           │      │        (MySQL Database)         │      │     (Executive Dashboard)       │
├─────────────────────────────────┤      ├─────────────────────────────────┤      ├─────────────────────────────────┤
│ • Tab 1: Raw Material Logs      │      │ • Data Cleaning & Alignment     │      │ • Menu Engineering Breakdown    │
│ • Tab 2: Cost Calculation Sheets│ ───► │ • Complex Conditional Aggregates│ ───► │   (Donut Chart Analysis)        │
│ • Tab 3: Manual Menu Matrices   │      │ • CTE Threshold Classification  │      │ • Top 10 Best Sellers Profiling │
└─────────────────────────────────┘      └─────────────────────────────────┘      └─────────────────────────────────┘
```

---

## 💻 SQL Logic & Implementation
The core transformation engine utilizes advanced conditional structures and **Common Table Expressions (CTEs)** within a MySQL environment. It programmatically calculates itemized variables and isolates performance strategy alignments without manual spreadsheet audits.

### Threshold Parameters Set:
* **High Popularity Index:** Total Volume Sold (`qty_prepared - qty_waste`) \(\ge\) `200 portions`.
* **High Profitability Index:** Net Consumed Food Cost Percentage \(\le\) `35.00%`.

```sql
WITH menu_metrics AS (
    SELECT 
        item_id,
        menu_item,
        (qty_prepared - qty_waste) AS qty_sold,
        ((qty_prepared - qty_waste) * unit_cost) AS consumed_food_cost,
        ROUND(((qty_prepared - qty_waste) * 
            CASE 
                WHEN item_id = 'B001' THEN 8.33
                WHEN item_id = 'B002' THEN 10.67
                WHEN item_id = 'B003' THEN 9.85
                WHEN item_id = 'B004' THEN 8.25
                WHEN item_id = 'B005' THEN 15.00
                ELSE 10.00
            END), 2) AS total_revenue
    FROM menu_raw_inventory
),
menu_percentages AS (
    SELECT 
        item_id,
        menu_item,
        qty_sold,
        ROUND((consumed_food_cost / total_revenue) * 100, 2) AS food_cost_percentage
    FROM menu_metrics
)
SELECT 
    item_id,
    menu_item,
    qty_sold,
    food_cost_percentage,
    CASE 
        WHEN qty_sold >= 200 AND food_cost_percentage <= 35.00 THEN 'STAR'
        WHEN qty_sold >= 200 AND food_cost_percentage > 35.00 THEN 'PLOWHORSE'
        WHEN qty_sold < 200 AND food_cost_percentage <= 35.00 THEN 'PUZZLE'
        ELSE 'DOG'
    END AS menu_classification,
    CASE 
        WHEN qty_sold >= 200 AND food_cost_percentage <= 35.00 THEN 'Maintain'
        WHEN qty_sold >= 200 AND food_cost_percentage > 35.00 THEN 'Review Pricing / Reduce Portion'
        WHEN qty_sold < 200 AND food_cost_percentage <= 35.00 THEN 'Reduce Waste'
        ELSE 'Remove Item'
    END AS management_strategy
FROM menu_percentages;
```

---

## 📈 Strategic Management Action Plan
To translate database metrics into actual profit recovery, the project implements a prescriptive operational framework:

1. **Puzzle Intervention:** Transition high-cost slow movers (e.g., *Pan Seared Atlantic Salmon*) away from bulk advance preparation into vacuum-sealed sous-vide, cook-to-order protocols to extend ingredient shelf-life and safely eliminate the wastage footprint.
2. **Plowhorse Engineering:** Apply subtle recipe tuning (e.g., fluid-to-ice ratios in *Iced Calamansi Lime Tea*) or pair high-volume items with high-margin side components to lower the collective food cost percentage without alienating consumer demand.
3. **Weekly POS Analytics Integration:** Embed the engineered SQL analytical matrix directly into the Points of Sales (POS) terminals to execute real-time automated weekly classification sweeps, enabling proactive menu management.

---

## 📁 Repository Structure
```text
├── README.md                           <-- Executive Project Summary (This file)
├── FB_Cost_Control_Mini_Thesis.pdf    <-- Full 20-Page Comprehensive Thesis Document
├── scripts/
│   └── waste_analysis_query.sql        <-- Production-Ready MySQL Initialization & Logic Script
└── data/
    └── FB_operations_cost_control.xlsx <-- Staging Data Sheets (Tab 1, Tab 2, Tab 3)
```

---
*Developed as an independent portfolio piece showcasing advanced skills in Financial Cost Control, Database Engineering (SQL), and Prescriptive Data Analytics within the Hospitality Domain.*

