--Exploratory SQL Queries for Elist Data

--1. What is the date of the earliest and latest order, returned in one query?
SELECT MIN(purchase_ts), MAX(purchase_ts)
FROM core.orders;

--2. Return the id, loyalty program status, and account creation date for customers who made an account on desktop or mobile. Rename the columns to more descriptive names.
SELECT id `User ID`, 
       loyalty_program `Loyalty Program Members`,
       created_on `Account Creation Date`
FROM core.customers
WHERE (account_creation_method = 'desktop'  OR account_creation_method = 'mobile');


--3. What are all the unique products that were sold in AUD on website, sorted alphabetically?
SELECT DISTINCT product_name `Product Name`
FROM core.orders
WHERE currency='AUD'
ORDER BY product_name;


--Second set of exploratory questions:

--1. What is the total number of orders by shipping month, sorted from most recent to oldest?
SELECT DATE_TRUNC(purchase_ts, month) `Month`,
       COUNT(DISTINCT id) `Order Count`
FROM core.orders
GROUP BY 1
ORDER BY 1 DESC;

--2. What is the average order value by year? Can you round the results to 2 decimals?
SELECT DATE_TRUNC(purchase_ts, year) `Year`,
       ROUND(AVG(usd_price), 2) `Average Price`
FROM core.orders
GROUP BY 1
ORDER BY 1;

--3. Create a helper column `is_refund`  in the `order_status`  table that returns 1 if there is a refund, 0 if not. Return the first 20 records.
SELECT *,
CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END AS is_refund
FROM core.order_status
ORDER BY 1
LIMIT 20;

--Challenge Questions for practice

--1. What is the refund rate per year, expressed as a percent (i.e. 0.0445 should be shown as 44.5)? Can you round this to 2 decimals? 
SELECT DATE_TRUNC(purchase_ts, year),
       ROUND(AVG(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) * 100, 2) AS `Refund Rate`
FROM `core.order_status`
WHERE purchase_ts IS NOT NULL
GROUP BY 1;

--2. What is the total number of orders per year for each product? Clean up product names when grouping and return in alphabetical order after sorting by months. 
SELECT DATE_TRUNC(purchase_ts, year),
       CASE WHEN product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor'
       ELSE product_name END AS cleaned_names,
       COUNT(*) AS total_orders
FROM `core.orders`
WHERE purchase_ts IS NOT NULL
GROUP BY 1, 2
ORDER BY 1;


--Actual Stakeholder Questions
--1) What were the order counts, sales, and AOV for Macbooks sold in North America for each quarter across all years?
SELECT DATE_TRUNC(orders.purchase_ts, quarter) AS purchase_qtr,
       COUNT(*) AS order_ct,
       SUM(usd_price) AS total_sales,
       AVG(usd_price) AS aov
FROM core.orders
LEFT JOIN core.customers
  ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup
  ON customers.country_code = geo_lookup.country_code
WHERE geo_lookup.region = 'NA' AND LOWER(product_name) LIKE '%macbook%'
GROUP BY 1
ORDER BY 1;


--2) For products purchased in 2022 on the website or products purchased on mobile in any year, which region has the average highest time to deliver?
SELECT geo_lookup.region,
       AVG(DATE_DIFF(order_status.delivery_ts, order_status.purchase_ts, day))
FROM core.orders
LEFT JOIN core.order_status
    ON orders.id = order_status.order_id
LEFT JOIN core.customers
    ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup
    ON customers.country_code = geo_lookup.country_code
WHERE ((DATE_TRUNC(orders.purchase_ts, year) = '2022-01-01' AND orders.purchase_platform = 'website')
    OR orders.purchase_platform = 'mobile')
    AND geo_lookup.region IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;

--3) What was the refund rate and refund count for each product overall? 
SELECT CASE WHEN orders.product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor' ELSE orders.product_name END AS `Product Name`,
       AVG(CASE WHEN order_status.refund_ts IS NULL THEN 0 ELSE 1 END) AS `Refund Rate`,
       SUM(CASE WHEN order_status.refund_ts IS NULL THEN 0 ELSE 1 END) AS `Refund Count`
FROM core.orders
LEFT JOIN core.order_status
      ON orders.id = order_status.order_id
GROUP BY 1
ORDER BY 2;

--4) Within each region, what is the most popular product? 
WITH sales_by_product AS(
  SELECT CASE WHEN orders.product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor' ELSE orders.product_name END AS product_clean,
  geo_lookup.region AS region,
  COUNT(*) AS order_count
  FROM core.orders
  LEFT JOIN core.customers 
    ON orders.customer_id = customers.id
  LEFT JOIN core.geo_lookup
    ON customers.country_code = geo_lookup.country_code
  GROUP BY 1, 2
  ORDER BY 2
),

ranked_products AS(
  SELECT *,
  ROW_NUMBER() OVER(PARTITION BY region ORDER BY order_count DESC) AS regional_ranking
  FROM sales_by_product
)

SELECT *
FROM ranked_products
WHERE regional_ranking = 1;


--5) How does the time to make a purchase differ between loyalty customers vs. non-loyalty customers?
SELECT customers.loyalty_program,
       ROUND(AVG(DATE_DIFF(orders.purchase_ts, customers.created_on, `day`)), 1) AS `Average days to buy`,
       ROUND(AVG(DATE_DIFF(orders.purchase_ts, customers.created_on, `month`)), 1) AS `Average months to buy`
FROM core.customers 
LEFT JOIN core.orders
ON customers.id = orders.customer_id
WHERE customers.loyalty_program IS NOT NULL
GROUP BY 1;


--Advanced Queries

--6) What is the quarter-over-quarter revenue change for Macbook Air across all regions?
WITH quarterly_revenue AS (
  SELECT DATE_TRUNC(purchase_ts, quarter) AS purchase_qtr,
         SUM(usd_price) AS total_revenue
  FROM core.orders
  WHERE LOWER(product_name) LIKE '%macbook%'
  GROUP BY 1
)

SELECT purchase_qtr,
       total_revenue,
       LAG(total_revenue) OVER (ORDER BY purchase_qtr) AS prev_qtr_revenue,
       ROUND(
         (total_revenue - LAG(total_revenue) OVER (ORDER BY purchase_qtr))
         / LAG(total_revenue) OVER (ORDER BY purchase_qtr) * 100, 2
       ) AS qoq_change_pct
FROM quarterly_revenue
ORDER BY 1;


--7) Which products have a refund rate above the overall company average?
SELECT CASE WHEN orders.product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor'
            ELSE orders.product_name END AS product_name,
       ROUND(AVG(CASE WHEN order_status.refund_ts IS NULL THEN 0 ELSE 1 END) * 100, 2) AS refund_rate_pct
FROM core.orders
LEFT JOIN core.order_status
  ON orders.id = order_status.order_id
GROUP BY 1
HAVING AVG(CASE WHEN order_status.refund_ts IS NULL THEN 0 ELSE 1 END) >
  (SELECT AVG(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) FROM core.order_status)
ORDER BY 2 DESC;


--8) What is the total order count and revenue per region, using COALESCE to bucket unmatched countries as 'Unknown'?
SELECT COALESCE(geo_lookup.region, 'Unknown') AS region,
       COUNT(*) AS order_count,
       ROUND(SUM(orders.usd_price), 2) AS total_revenue
FROM core.orders
LEFT JOIN core.customers
  ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup
  ON customers.country_code = geo_lookup.country_code
GROUP BY 1
ORDER BY 3 DESC;