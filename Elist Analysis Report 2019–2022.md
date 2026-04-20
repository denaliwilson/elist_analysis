# Elist E-Commerce Analysis Report: 2019–2022

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Data Overview](#data-overview)
3. [Analysis](#analysis)
   - [Q1: Macbook Air Laptop Sales Performance by Quarter](#q1-macbook-air-laptop-sales-performance-by-quarter)
   - [Q2: Average Delivery Time by Region](#q2-average-delivery-time-by-region)
   - [Q3: Refund Rate and Refund Count by Product](#q3-refund-rate-and-refund-count-by-product)
   - [Q4: Most Popular Product by Region](#q4-most-popular-product-by-region)
   - [Q5: Time to Purchase — Loyalty vs. Non-Loyalty Customers](#q5-time-to-purchase--loyalty-vs-non-loyalty-customers)
4. [Conclusion & Recommended Next Steps](#conclusion--recommended-next-steps)

---

## Executive Summary

> Elist generated $6.29M in total Macbook Air revenue across all regions from 2019–2022, with 2020 representing an anomalous demand spike (~5x 2019) driven by pandemic-era device purchases — a peak that has not recovered, with 2022 revenue down 71% from that high. Apple Airpods Headphones is the dominant product globally, ranking #1 in every region by order volume, while laptops (ThinkPad and Macbook Air) carry the highest refund rates at 12% and 11% respectively — more than double the 5% company average. Delivery times are operationally uniform across all four regions (~7.5 days), and loyalty program members demonstrate meaningfully faster time-to-purchase than non-members, a gap that widened in 2022 as overall conversion timelines surged for both groups.

**Key Highlights:**
- **Q1 — Macbook Air Revenue (All Regions):** 2020 peak of $2.93M (1,843 units) was driven by pandemic demand; by Q4 2022, quarterly revenue had fallen to just $86,564 (68 units) — the weakest quarter in the dataset.
- **Q2 — Regional Delivery Time:** All regions average ~7.5 days with less than 0.1-day variance between them — delivery time is not a differentiating factor across regions.
- **Q3 — Refund Rates:** Laptops lead returns: ThinkPad at 12% and Macbook Air at 11%, both far above the 5% average. Samsung Charging Cable Pack returns just 1% — notably low for a high-volume product.
- **Q4 — Most Popular Product:** Apple Airpods Headphones ranked #1 in all four regions (NA, EMEA, APAC, LATAM), while iPhone and Bose Soundsport consistently ranked last.
- **Q5 — Loyalty vs. Non-Loyalty:** Loyalty members purchase ~75 days sooner than non-members on average; both groups saw a sharp rise in days-to-purchase through 2022, signaling a broader conversion funnel issue.

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

### Q1: Macbook Air Laptop Sales Performance by Quarter

*Macbook Air orders aggregated by quarter across all regions, 2019–2022.*

#### Results

![](images/Elist_Q1_Macbook_Table.png)

#### Visualization

![](images/Elist_Q1_Macbook_Graph.png)

#### Insights

- **2020 was the peak year by a wide margin**, generating $2.93M in revenue (1,843 units) — nearly 5x 2019's $607K (366 units). This spike aligns with pandemic-driven demand for remote work and e-learning devices.
- **Revenue declined sharply post-2020**: 2021 fell ~35% to $1.9M, and 2022 fell a further ~55% to $852K, suggesting demand normalization after the pandemic surge.
- **Q4 2022 was the single weakest quarter across all years** at $86,564 (68 units), indicating continued market contraction heading into the post-analysis period.
- **Average unit price declined steadily**, from ~$1,749 (Q1 2019) to ~$1,273 (Q4 2022) — a 27% drop over four years.

---

### Q2: Average Delivery Time by Region

*Average delivery time in days per region, across all years and platforms (null regions excluded).*

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

- **All four regions fall within a 0.1-day range** (~7.48–7.52 days) — a difference of roughly 2 hours that is operationally negligible.
- The uniformity suggests a standardized global fulfillment pipeline. Future investigation should focus on other logistics metrics — shipping accuracy, damage rates, or carrier performance — to surface actionable disparities.

---

### Q3: Refund Rate and Refund Count by Product

*Refund flagged when `refund_ts` was present; refund rate expressed as % of total orders per product.*

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

*Order counts aggregated by region and product; top product per region identified by highest order count.*

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

- **Apple Airpods Headphones is the #1 product in every region** with no exceptions — a clear global bestseller.
- **NA dominates in absolute order volume** (~25K Airpods), roughly 1.7x EMEA (~15K) and over 4x APAC (~5.5K), highlighting North America as the primary revenue driver in this product category.
- **APAC and LATAM have significantly lower overall order volumes** across all products, which may represent underpenetrated markets and a strategic opportunity for targeted growth campaigns.
- The **27in 4K Gaming Monitor and Samsung Charging Cable Pack are consistent runners-up** in NA and EMEA, suggesting secondary product demand clusters Elist could amplify through bundling or cross-sell promotions.
- **iPhone and Bose Soundsport Headphones rank at the bottom of every region**, signaling either weak market positioning, pricing issues, or insufficient marketing investment in these SKUs.

---

### Q5: Time to Purchase — Loyalty vs. Non-Loyalty Customers

*Days between `created_on` and `purchase_ts` averaged by loyalty status (1 = member, 0 = non-member); null loyalty values excluded.*

#### Visualization

![](images/Elist_Q5_Loyalty_Time_to_Sale.png)

#### Insights

- **Both groups show a sharp increase in days-to-purchase starting mid-2021**, steepening dramatically in 2022 — non-loyalty customers reaching ~400 days and loyalty members ~325 days by late 2022, likely reflecting post-COVID macroeconomic headwinds.
- **The gap between groups widened in 2022**, with loyalty members purchasing ~75 days sooner than non-members — suggesting the program provides an increasingly meaningful engagement buffer as market conditions deteriorate.
- The steep 2022 trend warrants further investigation: customers taking 300–400 days from signup to first purchase signals a significant acquisition-to-conversion leak that onboarding campaigns or time-limited offers could address.

---

## Conclusion & Recommended Next Steps

Five findings drive the following recommendations:

### Recommended Next Steps

| Priority | Recommendation | Supporting Finding |
|---|---|---|
| High | Investigate root causes of elevated laptop return rates — survey returned-product reasons, review QA/fulfillment processes, and assess whether ThinkPad NA (14% refund rate) warrants a supplier or logistics audit | Q3 — ThinkPad 12%, Macbook Air 11% refund rates; ThinkPad NA highest at 14% |
| High | Launch targeted re-engagement campaigns (time-limited offers, onboarding sequences) for new account holders who have not purchased within 90 days, prioritizing non-loyalty customers | Q5 — Non-loyalty customers averaging 400+ days-to-purchase by late 2022 |
| Medium | Develop a loyalty program acquisition push: the program demonstrably accelerates purchase timing (~75-day gap vs. non-members), and expanding enrollment could offset the broad conversion slowdown observed in 2022 | Q5 — Loyalty members consistently purchase sooner; gap widened in 2022 |
| Medium | Invest in Airpods marketing and inventory in APAC and LATAM, where order volumes are a fraction of NA/EMEA despite the same #1 product ranking — these regions represent underpenetrated growth opportunities | Q4 — Airpods #1 globally but APAC (~5.5K) and LATAM (~2.5K) lag NA (~25K) significantly |
| Low | Evaluate Macbook Air pricing strategy: the 27% AOV decline from 2019 to 2022 suggests eroding price positioning — consider whether promotional discounting is cannibalizing margin or if a product-mix shift toward newer models is needed | Q1 — Average unit price fell from ~$1,749 (Q1 2019) to ~$1,273 (Q4 2022) |

---

_Report prepared using SQL queries against the Elist core data warehouse (BigQuery). Data covers January 2019 – December 2022. Visualizations generated in Power BI._
