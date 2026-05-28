--Database Setup
CREATE TABLE menu (
    menu_item_id SMALLINT PRIMARY KEY,
    item_name    VARCHAR(100),
    category     VARCHAR(50),
    price        NUMERIC(5,2)
)

CREATE TABLE order_details (
    order_details_id SMALLINT PRIMARY KEY,
    order_id         SMALLINT,
    order_date       DATE,
    order_time       TIME,
    item_id          SMALLINT
)
-- Import menu_items.csv and order_details.csv via pgAdmin Import/Export

--DATA QUALITY CHECK
--How many order lines have a missing item ID?
select count(*) from order_details
where item_id is null

--Total records in each table
select count(*) from order_details
select count(*) from menu

--What is the date range of the dataset?
select min(order_date) as earliest_date,
max(order_date) as latest_date from order_details

--Menu Analysis
--How many items does each category have and what is the price range?
select category, count(item_name),
min(price) as lowest_price,
max(price) as highest_price from menu
group by category

--What are the most and least expensive items on the menu?
select item_name, price from menu
order by price desc

--Which items are priced above the overall menu average?
select item_name, price from menu
where price >(select avg(price) from menu)
order by price desc

--ORDER VOLUME ANALYSIS
--How many unique orders were placed in total?
select count (distinct(order_id)) as unique_orders from order_details

--What is the average number of items per order?
with order_count as(
select order_id, count(item_id) as num_of_items from order_details
where item_id is not null
group by order_id)
select round(avg(num_of_items),2) from order_count

--How did order volume change month over month?
select to_char(order_date, 'Month') as months,
count(item_id) as order_volume from order_details
group by months
order by min(order_date)

--Which days of the week are the busiest?
select to_char(order_date, 'Day') as day_of_week, count(item_id) as order_volume from order_details
group by day_of_week
order by order_volume desc

--What hours of the day see the highest order volume?
select to_char(order_time, 'HH12 PM') as time_of_day, count(item_id) as order_volume from order_details
group by time_of_day
order by order_volume desc

--MENU ITEM PERFORMANCE
--How many times was each menu item ordered?
select item_name, count(item_id) as order_frequency from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by item_name

--What are the top 10 most ordered items?
select item_name, count(item_id) as order_frequency from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by item_name
order by order_frequency desc
limit 10

--What are the least ordered items
select item_name, count(item_id) as order_frequency from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by item_name
order by order_frequency asc
limit 10

--How much revenue did each item generate?
select item_name, sum(price) as revenue from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by item_name
order by revenue desc

--CATEGORY PERFORMANCE
--Which category drives the most revenue and order volume?
select category, sum(price) as revenue,
count(item_id) as order_volume from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by category
order by revenue desc

--What is the average item price per category
select category, round(avg(price),2) as avg_price from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by category

--ORDER VALUE ANALYSIS
--What is the total value of each order
select order_id, sum(price) as order_cost from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by order_id

--Which orders exceeded the average order value?
with total_order as (
select order_id, sum(price) as order_cost from order_details
left join menu on
order_details.item_id=menu.menu_item_id
group by order_id)
select * from total_order
where order_cost>
(select avg(order_cost) from total_order)
order by order_cost desc

--What are the top 10 highest value orders?
select order_id, sum(price) as order_cost from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
where item_id is not null
group by order_id
order by order_cost desc
limit 10