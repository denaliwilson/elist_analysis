--1. What is the date of the earliest and latest order, returned in one query?
SELECT MIN(purchase_ts), MAX(purchase_ts)
FROM core.orders;



--2. What is the average order value for purchases made in USD? What about average order value for purchases made in USD in 2019?
SELECT AVG(usd_price)
FROM core.orders
WHERE (DATE_TRUNC(purchase_ts, year) = '2019-01-01');





--3. Return the id, loyalty program status, and account creation date for customers who made an account on desktop or mobile. Rename the columns to more descriptive names.
SELECT id `User ID`, 
       loyalty_program `Loyalty Program Members`,
       created_on `Account Creation Date`
FROM core.customers
WHERE (account_creation_method = 'desktop'  OR account_creation_method = 'mobile');


--4. What are all the unique products that were sold in AUD on website, sorted alphabetically?
SELECT DISTINCT product_name `Product Name`
FROM core.orders
WHERE currency='AUD'
ORDER BY product_name;


--5. What are the first 10 countries in the North American region, sorted in descending alphabetical order?
SELECT DISTINCT country_code `Country Code`
FROM core.geo_lookup
WHERE region='NA'
ORDER BY country_code DESC
LIMIT 10;

