-- Database Setup
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

select count(*) from order_details
where item_id is null

select count(*) from order_details
select count(*) from menu

select min(order_date) as earliest_date, max(order_date) as latest_date from order_details

select category, count(item_name), min(price) as lowest_price, max(price) as highest_price from menu
group by category

select item_name, price from menu
order by price desc

select item_name, price from menu
where price >(select avg(price) from menu)
order by price desc

select count (distinct(order_id)) as unique_orders from order_details

with order_count as(
select order_id, count(item_id) as num_of_items from order_details
where item_id is not null
group by order_id)
select round(avg(num_of_items),2) from order_count

select to_char(order_date, 'Month') as months, count(item_id) as order_volume from order_details
group by months
order by min(order_date)

select to_char(order_date, 'Day') as day_of_week, count(item_id) as order_volume from order_details
group by day_of_week
order by order_volume desc

select to_char(order_time, 'HH12 PM') as time_of_day, count(item_id) as order_volume from order_details
group by time_of_day
order by order_volume desc

select item_name, count(item_id) as order_frequency from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by item_name

select item_name, count(item_id) as order_frequency from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by item_name
order by order_frequency desc
limit 10

select item_name, count(item_id) as order_frequency from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by item_name
order by order_frequency asc
limit 10

select item_name, sum(price) as revenue from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by item_name
order by revenue desc


select category, sum(price) as revenue, count(item_id) as order_volume from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by category
order by revenue desc

select category, round(avg(price),2) as avg_price from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by category

select order_id, sum(price) as order_cost from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
group by order_id

with total_order as (
select order_id, sum(price) as order_cost from order_details
left join menu on
order_details.item_id=menu.menu_item_id
group by order_id)
select * from total_order
where order_cost>
(select avg(order_cost) from total_order)
order by order_cost desc

select order_id, sum(price) as order_cost from order_details
inner join menu on
order_details.item_id=menu.menu_item_id
where item_id is not null
group by order_id
order by order_cost desc
limit 10
