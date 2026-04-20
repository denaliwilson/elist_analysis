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

- **2020 was the peak year by a wide margin**, generating $2.93M in revenue (1,843 units) — nearly 5x 2019's $607K (366 units). This spike aligns with pandemic-driven demand for remote work and e-learning devices.
- **Revenue declined sharply post-2020**: 2021 fell ~35% to $1.9M, and 2022 fell a further ~55% to $852K, suggesting demand normalization after the pandemic surge.
- **Q4 2022 was the single weakest quarter across all years** at $86,564 (68 units), indicating continued market contraction heading into the post-analysis period.
- **Average unit price has trended steadily downward**, dropping from ~$1,749 in Q1 2019 to ~$1,273 in Q4 2022 (~27% decline) — likely reflecting model refreshes, increased market competition, or growing price sensitivity among buyers.

---

### Q2: Average Delivery Time by Region (Website 2022 & All Mobile)

**Question:** For products purchased in 2022 on the website, or products purchased on mobile in any year, which region has the highest average time to deliver?

**Method:** Orders were filtered to (website purchases in 2022) OR (mobile purchases in any year). Average delivery time in days was calculated per region, excluding records with null region values.

#### Results

| Region | Avg. Delivery Time (Days) |
|---|---|
| EMEA | ~7.52 |
| NA | ~7.50 |
| LATAM | ~7.49 |
| APAC | ~7.48 |

_Regions ranked from longest to shortest average delivery time. Values are approximate as read from the visualization._

#### Visualization

![](images/Elist_Q2_Regional_Delivery_Time.png)

#### Insights

- **Delivery times are remarkably consistent across all four regions**, spanning less than 0.1 days (roughly 2 hours) from the slowest (EMEA at ~7.52 days) to the fastest (APAC at ~7.48 days).
- Despite EMEA ranking highest, the difference is operationally negligible and unlikely to meaningfully impact customer experience or satisfaction ratings in any single region.
- The uniformity suggests a standardized global fulfillment pipeline. Since delivery time is not a differentiating factor across regions, future investigation should focus on other logistics quality metrics — such as shipping accuracy, damage rates, or carrier performance — to surface actionable disparities.

---

### Q3: Refund Rate and Refund Count by Product

**Question:** What was the refund rate and refund count for each product overall?

**Method:** All orders were joined to order status records. A refund was flagged when a `refund_ts` timestamp was present. Refund rate is expressed as a percentage of total orders per product.

#### Results

| Product | Refund Rate (%) |
|---|---|
| ThinkPad Laptop | 12% |
| Macbook Air Laptop | 11% |
| Apple iPhone | 8% |
| 27in 4K Gaming Monitor | 6% |
| Apple Airpods Headphones | 5% |
| Samsung Webcam | 3% |
| Samsung Charging Cable Pack | 1% |
| Bose Soundsport Headphones | 0% |

_Products sorted by refund rate (high to low). Overall refund rate across all products: 5%. Total order counts and absolute refund counts not captured in this visualization._

#### Visualization

![](images/Elist_Q3_Product_Region_Refunds.png)

#### Insights

- **Laptops lead in refund rate**: ThinkPad Laptop (12%) and Macbook Air Laptop (11%) are the top two highest-refund products, significantly above the overall 5% average — likely driven by the high unit price raising customer scrutiny, or technical issues unique to laptop use cases.
- **ThinkPad refunds are disproportionately high in NA (14%)**, suggesting a potential regional product-fit or fulfillment issue worth investigating in that market specifically.
- **Bose Soundsport Headphones had a 0% refund rate** across all four regions, and Samsung Charging Cable Pack logged just 1% — both low-ticket items — suggesting price point is inversely correlated with refund likelihood.
- The overall company refund rate of 5% is consistent across APAC, EMEA, and NA, with LATAM slightly lower at 4%, pointing to no major outlier regions but a clear outlier product category (laptops).

---

### Q4: Most Popular Product by Region

**Question:** Within each region, what is the most popular product?

**Method:** Order counts were aggregated by region and product. Within each region, the product with the highest order count was identified using a row-number window function.

#### Results

| Region | Most Popular Product | Order Count |
|---|---|---|
| NA | Apple Airpods Headphones | ~25,000 |
| EMEA | Apple Airpods Headphones | ~15,000 |
| APAC | Apple Airpods Headphones | ~5,500 |
| LATAM | Apple Airpods Headphones | ~2,500 |

#### Visualization

![](images/Elist_Q4_Regional_Product_Sales.png)

#### Insights

- **Apple Airpods Headphones is the #1 product in every region** — a clear global bestseller with no regional exceptions, indicating universal brand strength and demand consistency across diverse markets.
- **NA dominates in absolute order volume** (~25K Airpods), roughly 1.7x EMEA (~15K) and over 4x APAC (~5.5K), highlighting North America as the primary revenue driver in this product category.
- **APAC and LATAM have significantly lower overall order volumes** across all products, which may represent underpenetrated markets and a strategic opportunity for targeted growth campaigns.
- The **27in 4K Gaming Monitor and Samsung Charging Cable Pack are consistent runners-up** in NA and EMEA, suggesting secondary product demand clusters Elist could amplify through bundling or cross-sell promotions.
- **iPhone and Bose Soundsport Headphones rank at the bottom of every region**, signaling either weak market positioning, pricing issues, or insufficient marketing investment in these SKUs.

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

![](images/Elist_Q5_Loyalty_Time_to_Sale.png)

#### Insights

- **Loyalty program members consistently purchase sooner after account creation than non-members** throughout the entire 2019–2022 period, supporting the program's effectiveness in accelerating purchase intent.
- **Both groups show a sharp and accelerating increase in days-to-purchase starting in mid-2021**, with the trend steepening dramatically in 2022 — non-loyalty customers reaching ~400 days-to-purchase and loyalty members ~325 days by late 2022. This likely reflects macroeconomic headwinds (e.g., inflation, post-COVID consumer pullback) causing broader hesitation.
- **The gap between groups widened in 2022**, with loyalty members still purchasing ~75 days sooner than non-members at the end of the period. This growing spread suggests the loyalty program is providing an increasingly meaningful engagement buffer as general market conditions deteriorate.
- The steep 2022 trend for both cohorts warrants further investigation — if customers are taking 300–400 days from signup to first purchase, that signals a significant leak in the acquisition-to-conversion funnel that targeted onboarding or time-limited offer campaigns could address.

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
