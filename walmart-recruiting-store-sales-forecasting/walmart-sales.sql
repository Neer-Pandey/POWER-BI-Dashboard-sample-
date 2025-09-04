create database walmart;
use walmart;
USE walmart;

CREATE TABLE stores (
  store INT PRIMARY KEY,
  type  CHAR(1),
  size  INT
);

CREATE TABLE sales (
  store INT,
  dept  INT,
  date  DATE,
  weekly_sales DECIMAL(10,2),
  is_holiday boolean(1),
  PRIMARY KEY (store, dept, date)
);

CREATE TABLE features (
  store INT,
  date DATE,
  temperature DECIMAL(6,2),
  fuel_price DECIMAL(6,3),
  markdown1 DECIMAL(10,2),
  markdown2 DECIMAL(10,2),
  markdown3 DECIMAL(10,2),
  markdown4 DECIMAL(10,2),
  markdown5 DECIMAL(10,2),
  cpi DECIMAL(8,3),
  unemployment DECIMAL(5,2),
  is_holiday TINYINT(1),
  PRIMARY KEY (store, date)
);
LOAD DATA LOCAL INFILE 'C:\Users\Neer\Desktop\DATA ANALYSIS PROJECTS\walmart-recruiting-store-sales-forecasting\stores.csv'
INTO TABLE stores
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(store, type, size);
SHOW TABLES;
DESCRIBE features;
SELECT * FROM features LIMIT 10;
SELECT * FROM stores LIMIT 10;

CREATE INDEX ix_sales_date ON sales(date);
CREATE INDEX ix_sales_store ON sales(store);
CREATE INDEX ix_features_store_date ON features(store, date);

ALTER TABLE sales 
MODIFY COLUMN date DATE;
ALTER TABLE features
MODIFY COLUMN date DATE;

SELECT date, SUM(weekly_sales) AS total_weekly_sales
FROM sales
GROUP BY date
ORDER BY date;

-- Aggregate to store-level (sum across depts)
WITH store_sales AS (
  SELECT store,
         SUM(weekly_sales) AS total_sales,
         AVG(weekly_sales) AS avg_weekly_sales
  FROM sales
  GROUP BY store
)
SELECT * FROM sales ORDER BY Weekly_Sales DESC LIMIT 10;  

SELECT dept,
       SUM(weekly_sales) AS total_sales,
       AVG(weekly_sales) AS avg_weekly_sales
FROM sales
GROUP BY dept
ORDER BY total_sales DESC
LIMIT 10;


