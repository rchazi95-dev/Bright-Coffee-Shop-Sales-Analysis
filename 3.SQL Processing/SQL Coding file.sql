-- I want to see my table in the coding to start exploryting each column
SELECT *
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`
LIMIT 10;

------------------------------------------------
-- Checking the Date Range
-------------------------------------------------
-- They started collecting the data 2023-01-01
SELECT MIN(transaction_date) AS min_date 
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;
-- the duration of the data is 6 months
--  They last collected the data 2023-06-30

SELECT MAX(transaction_date) AS latest_date 
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;
-------------------------------------------------
--Checking the names of the different stores
-- we have 3 stores and their names are Lower Manhattan, Hell's Kitchen, Astoria

SELECT DISTINCT store_location
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;

SELECT COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;
-------------------------------------------------
--Checking products sold at our stores 
------------------------------------------------
SELECT DISTINCT product_category
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;

SELECT DISTINCT product_detail
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;

SELECT DISTINCT product_type
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;

SELECT DISTINCT product_category AS category,
                product_detail AS product_name
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;

-------------------------------------------------
--Checking product prices
------------------------------------------------
SELECT MIN(unit_price) As cheapest_price
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;

SELECT MAX(unit_price) As expensive_price
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;

SELECT COUNT(*) AS number_of_rows,
      COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;

SELECT transaction_id,
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      transaction_qty*unit_price AS revenue_per_tnx
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`;

SELECT 
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      SUM(transaction_qty*unit_price) AS revenue_per_day
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`
GROUP BY transaction_date,
         Day_name,
         Month_name;

SELECT 
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      SUM(transaction_qty*unit_price) AS revenue_per_day
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`
GROUP BY transaction_date,
         Day_name,
         Month_name;

SELECT 
---Dates
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,

----Counnt of IDs         
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      COUNT(DISTINCT product_id) AS Number_of_products,
      COUNT(DISTINCT store_id) AS Number_of_stores,

 ----Revenue     
      SUM(transaction_qty*unit_price) AS revenue_per_day,

 ---Categorical columns
      store_location,
      product_category,
     product_detail
FROM `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`
GROUP BY transaction_date,
         Day_name,
         Month_name,
         store_location,
         product_category,
         product_detail;

---Dates

Select
      transaction_date as purchase_date,
      Dayname(transaction_date) as day_name,
      Monthname(transaction_date) as month_name,
      Dayofmonth(transaction_date) as day_of_month,
    case
          when Dayname(transaction_date) in ('Sun' , 'Sat') then 'Weekend'
          else 'Weekday'
          end as day_classification,
      ---date_format(transaction_time, 'HH:mm:ss') as purchase_time,
      case
          when date_format(transaction_time, 'HH:mm:ss') between '00:00:00' and '11:59:59' then '0.1 Morning'
          when date_format(transaction_time, 'HH:mm:ss') between '12:00:00' and '16:59:59' then '0.2 Afternoon'
          when date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' then '0.3 Evening'
          end as time_buckets,
---Counts of IDs
      count(*) as number_of_sales,
      count(distinct product_id) as number_of_products,
      count(distinct store_id) as number_stores,
---Revenue
      sum(transaction_qty*unit_price) as revenue_per_day,
---Categorical Columns
      store_location,
      product_category,
      product_detail
      
from `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1_1`
group by transaction_date, 
        dayname(transaction_date), 
        monthname(transaction_date), 
        dayofmonth(transaction_date),
        case
            when Dayname(transaction_date) in ('Sun' , 'Sat') then 'Weekend'
            else 'Weekday'
            end,
        case
            when date_format(transaction_time, 'HH:mm:ss') between '00:00:00' and '11:59:59' then '0.1 Morning'
            when date_format(transaction_time, 'HH:mm:ss') between '12:00:00' and '16:59:59' then '0.2 Afternoon'
            when date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' then '0.3 Evening'
            end,
        store_location, 
        product_category,
        product_detail;
