# Elist E-Commerce Analysis Report: 2019–2022

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Data Overview](#data-overview)
3. [Analysis](#analysis)
   - [Q1: Macbook Sales Performance in North America by Quarter](#q1-macbook-sales-performance-in-north-america-by-quarter)
   - [Q2: Average Delivery Time by Region (Website 2022 & All Mobile)](#q2-average-delivery-time-by-region-website-2022--all-mobile)
   - [Q3: Refund Rate and Refund Count by Product](#q3-refund-rate-and-refund-count-by-product)
   - [Q4: Most Popular Product by Region](#q4-most-popular-product-by-region)
   - [Q5: Time to Purchase — Loyalty vs. Non-Loyalty Customers](#q5-time-to-purchase--loyalty-vs-non-loyalty-customers)
4. [Conclusion & Recommended Next Steps](#conclusion--recommended-next-steps)

---

## Executive Summary

> _[2–4 sentence high-level summary of the most important findings across all five analysis areas. Fill in after completing the individual sections.]_

**Key Highlights:**
- _[Top finding from Q1 — e.g., strongest/weakest Macbook quarter]_
- _[Top finding from Q2 — e.g., region with longest delivery time]_
- _[Top finding from Q3 — e.g., product with highest refund rate]_
- _[Top finding from Q4 — e.g., dominant product across regions]_
- _[Top finding from Q5 — e.g., loyalty vs. non-loyalty purchase timing gap]_

---

## Data Overview

**Dataset:** Elist e-commerce transaction data covering 2019–2022.

| Table | Description |
|---|---|
| `core.orders` | Individual purchase transactions including product, price (USD), platform, and timestamp |
| `core.customers` | Customer demographics, loyalty program status, and account creation metadata |
| `core.order_status` | Order lifecycle timestamps: purchase, ship, and delivery dates; refund timestamps |
| `core.geo_lookup` | Maps customer country codes to geographic regions (NA, EMEA, APAC, LATAM) |

**Purchase Platforms:** Website, Mobile

**Regions:** North America (NA), Europe/Middle East/Africa (EMEA), Asia-Pacific (APAC), Latin America (LATAM)

**Products Sold:** 27in 4k gaming monitor, Apple Airpods Headphones, Apple iPhone, Bose Soundsport Headphones, Macbook Air Laptop, Samsung Charging Cable Pack, Samsung Webcam, ThinkPad Laptop

---

## Analysis

---

### Q1: Macbook Sales Performance in North America by Quarter

**Question:** What were the order counts, sales, and AOV for Macbooks sold in North America for each quarter across all years?

**Method:** Orders were filtered to the North America region and Macbook product name, then aggregated by quarter across 2019–2022.

#### Results

![](images/Elist_Q1_Macbook_Table.png)

#### Visualization

![](images/Elist_Q1_Macbook_Graph.png)

#### Insights

- _[Seasonal trends — e.g., does Q4 consistently outperform other quarters?]_
- _[Year-over-year growth or decline in Macbook NA sales]_
- _[Notable spikes or dips and potential explanations]_

---

### Q2: Average Delivery Time by Region (Website 2022 & All Mobile)

**Question:** For products purchased in 2022 on the website, or products purchased on mobile in any year, which region has the highest average time to deliver?

**Method:** Orders were filtered to (website purchases in 2022) OR (mobile purchases in any year). Average delivery time in days was calculated per region, excluding records with null region values.

#### Results

| Region | Avg. Delivery Time (Days) |
|---|---|
| | |
| | |
| | |
| | |

_Regions ranked from longest to shortest average delivery time._

#### Visualization

> _[Insert Power BI bar chart here — recommended: horizontal bar chart ranked by average delivery time, colored by region]_

#### Insights

- _[Which region has the longest average delivery time and by how much?]_
- _[Are there operational or logistical factors that may explain regional disparities?]_
- _[How does mobile vs. website channel mix differ by region, and could that influence the result?]_

---

### Q3: Refund Rate and Refund Count by Product

**Question:** What was the refund rate and refund count for each product overall?

**Method:** All orders were joined to order status records. A refund was flagged when a `refund_ts` timestamp was present. Refund rate is expressed as a percentage of total orders per product.

#### Results

| Product | Total Orders | Refund Count | Refund Rate (%) |
|---|---|---|---|
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |

_Products sorted by refund rate (high to low)._

#### Visualization

> _[Insert Power BI bar chart here — recommended: sorted bar chart of refund rate by product, with a secondary data label showing refund count]_

#### Insights

- _[Which product has the highest refund rate? Is volume a contributing factor?]_
- _[Which product has the highest absolute refund count?]_
- _[Are there products with a low refund rate that suggest strong customer satisfaction?]_

---

### Q4: Most Popular Product by Region

**Question:** Within each region, what is the most popular product?

**Method:** Order counts were aggregated by region and product. Within each region, the product with the highest order count was identified using a row-number window function.

#### Results

| Region | Most Popular Product | Order Count |
|---|---|---|
| NA | | |
| EMEA | | |
| APAC | | |
| LATAM | | |

#### Visualization

> _[Insert Power BI visualization here — recommended: grouped bar chart or map visual showing top product per region]_

#### Insights

- _[Is there a single product that dominates across multiple regions?]_
- _[Are there regional preferences that suggest localized demand or marketing opportunities?]_
- _[How large is the order count gap between the #1 and #2 product in each region?]_

---

### Q5: Time to Purchase — Loyalty vs. Non-Loyalty Customers

**Question:** How does the time between account creation and first purchase differ between loyalty program members and non-loyalty customers?

**Method:** The difference between `purchase_ts` and `created_on` was calculated for each order. Results were averaged and grouped by loyalty program status (1 = member, 0 = non-member), excluding null loyalty values.

#### Results

| Loyalty Status | Avg. Days to Purchase | Avg. Months to Purchase |
|---|---|---|
| Loyalty Member (1) | | |
| Non-Member (0) | | |

#### Visualization

> _[Insert Power BI visualization here — recommended: side-by-side bar chart or KPI cards comparing average days to purchase]_

#### Insights

- _[Do loyalty members purchase faster or slower after account creation?]_
- _[What does a longer/shorter time-to-purchase suggest about customer intent or engagement?]_
- _[Are there opportunities to shorten time-to-purchase for non-loyalty customers through targeted campaigns?]_

---

## Conclusion & Recommended Next Steps

### Summary of Findings

> _[3–5 sentence synthesis connecting findings across all five questions. Highlight the most actionable patterns.]_

### Recommended Next Steps

| Priority | Recommendation | Supporting Finding |
|---|---|---|
| High | _[e.g., Investigate high refund rate for [product]]_ | _[Q3 — refund rate data]_ |
| High | _[e.g., Audit logistics pipeline for [region] to reduce delivery time]_ | _[Q2 — delivery time data]_ |
| Medium | _[e.g., Expand Macbook North America marketing during peak quarter]_ | _[Q1 — seasonal trends]_ |
| Medium | _[e.g., Develop regional promotions based on top products per region]_ | _[Q4 — regional popularity]_ |
| Low | _[e.g., Create onboarding campaigns to accelerate non-loyalty time-to-purchase]_ | _[Q5 — purchase timing gap]_ |

---

_Report prepared using SQL queries against the Elist core data warehouse (BigQuery). Data covers January 2019 – December 2022. Visualizations generated in Power BI._
