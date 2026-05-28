# Restaurant Operations: Exploratory Data Analysis


## Description
A personal project combining my food service industry experience with SQL to analyze a fictional restaurants order data to assess menu and operational performance. Using a dataset consisting of 12,234 order lines spanning 5,370 unique orders, this EDA explores menu performance, revenue patterns, order behaviour, and demand patterns framed in business contexts relevant to a restaurant owner and/or operations manager.

This project utilizes PG Admin 4 and PostgreSQL. The complexity of the queries progresses increasingly ranging from basic SELECT statements, through aggregations, JOINs, and CTEs.


## Data Tables
```
menu (menu_item_id, item_name, category, price)
order_details (order_details_id, order_id, order_date, order_time, item_id)
```


## Questions Explored

| # | Business Question | Technique |
|---|---|---|
| 1 | How many order lines have a missing item ID? | Aggregation |
| 2 | Total records in each table | Aggregation |
| 3 | What is the date range of the dataset? | MIN / MAX |
| 4 | Price range and item count per category | GROUP BY |
| 5 | Most and least expensive items | ORDER BY |
| 6 | Items priced above the menu average | Subquery |
| 7 | How many unique orders were placed? | COUNT DISTINCT |
| 8 | Average number of items per order | CTE |
| 9 | How did order volume change month over month? | TO_CHAR |
| 10 | Which days of the week are the busiest? | TO_CHAR |
| 11 | What hours of the day see the highest order volume? | TO_CHAR |
| 12 | How many times was each item ordered? | JOIN |
| 13 | Top 10 most ordered items | JOIN + LIMIT |
| 14 | Least ordered items (potential dead weight) | JOIN + LIMIT |
| 15 | Revenue generated per item | JOIN + Aggregation |
| 16 | Which category drives the most revenue and volume? | JOIN + GROUP BY |
| 17 | Average item price per category | JOIN + AVG |
| 18 | Total value of each order | JOIN + SUM |
| 19 | Orders that exceeded average order value | CTE + Subquery |
| 20 | Top 10 highest value orders | JOIN + LIMIT |


## Skills Demonstrated

- Database setup, table creation, and data import
- JOIN operations (INNER JOIN, LEFT JOIN) across related tables
- Subqueries for comparative filtering
- CTEs (Common Table Expressions) for readable, layered queries
- Aggregations: SUM, COUNT, AVG, MIN, MAX
- Date and time extraction: EXTRACT, TO_CHAR
- Business framing of analytical questions using industry experience


## Tools Used

`pgAdmin` `PostgreSQL`


## Datasource
[Maven Analytics: Restaurant Orders Dataset](https://mavenanalytics.io/data-playground/restaurant-orders)
