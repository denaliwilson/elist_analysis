--DENALI SQL PRACTICE DOC

--Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10

--Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

--Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

--Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

SELECT id, account_id, standard_amt_usd/standard_qty AS standard_price
FROM orders
LIMIT 10

--Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

--Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name NOT LIKE '%s';

--Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')
AND occurred_at BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY occurred_at;

--Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.

SELECT a.primary_poc "Primary Contact", w.occurred_at "Event Time", w.channel "Event Channel", a.name "Client"
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
WHERE a.name = 'Walmart'

--Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT r.name Region, sr.name "Sales Rep", a.name Client
FROM sales_reps AS sr
JOIN accounts AS a
ON sr.id = a.sales_rep_id
JOIN region AS r
ON sr.region_id = r.id
ORDER BY a.name;

--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

SELECT r.name Region, a.name Account, o.total_amt_usd/(o.total + 0.001) "Unit Price"
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
JOIN sales_reps AS sr
ON a.sales_rep_id = sr.id
JOIN region AS r
ON r.id = sr.region_id

--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT a.name Account, sr.name "Sales Rep", r.name Region
FROM accounts a
JOIN sales_reps sr
ON a.sales_rep_id = sr.id
JOIN region r
ON sr.region_id = r.id
ORDER BY a.name;

--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT a.name Account, sr.name "Sales Rep", r.name Region
FROM accounts a
JOIN sales_reps sr
ON a.sales_rep_id = sr.id
JOIN region r
ON sr.region_id = r.id
WHERE r.name = 'Midwest' AND sr.name LIKE 'S%'
ORDER BY a.name;

--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT a.name Account, sr.name "Sales Rep", r.name Region
FROM accounts a
JOIN sales_reps sr
ON a.sales_rep_id = sr.id
JOIN region r
ON sr.region_id = r.id
WHERE r.name = 'Midwest' AND sr.name LIKE '% K%'
ORDER BY a.name;

--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

SELECT (o.total_amt_usd/(o.total+0.001)) unit_price,a.name Account, r.name Region
FROM accounts a
JOIN sales_reps sr
ON a.sales_rep_id = sr.id
JOIN region r
ON sr.region_id = r.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100



