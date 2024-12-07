-- Operation_1

-- 1. View the menu_items table;
SELECT *
FROM menu_items;


-- 2. Find the number of items on the menu
SELECT Count(*)
FROM menu_items
;


-- 3. What are the least and most expensive items on the menu?
SELECT *
FROM menu_items
order by price;

SELECT *
FROM menu_items
order by price desc;


-- 4. How many Italian dishes are on the menu?
SELECT count(category)
FROM menu_items
where category = 'Italian';


-- 5. What are the least and most expensive Italian dishes on the menu?
SELECT *
FROM menu_items
where category = 'Italian'
order by price;


-- 6. How many dishes are in each category?
SELECT category, count(menu_item_id) as num_dishes
FROM menu_items
group by category
;


-- 7. What is the average dish price within each category?
SELECT category,Avg(price) as average_dish_price
FROM menu_items
group by category;






-- Operation_2

-- 1. View the order_details table.
SELECT *
FROM order_details;


-- 2. What is the date range of the table?
SELECT min(order_date),max(order_date)
FROM order_details
order by order_date;


-- 3. How many orders were made within this date range?
SELECT count(distinct order_id)
FROM order_details;


-- 4. How many items were ordered within this date range?
SELECT count(*)
FROM order_details;


-- 5. Which orders had the most number of items?
SELECT order_id, count(item_id) as num_items
FROM order_details
group by order_id
order by num_items desc;


-- 6. How many orders had more than 12 items?
SELECT COUNT(*) FROM
(SELECT order_id,count(item_id) as num_items
FROM order_details
group by order_id
having num_items >12)as num_orders;







-- Operation_3


-- 1. Combine the menu_itmes and order_details tables into a single table?

select *
from order_details od
left join menu_items mi
	on od.item_id = mi.menu_item_id
;
-- 2. What were the least and most ordered items? What categories were they in ?

select item_name,category,count(order_details_id) as num_purchased
from order_details od
left join menu_items mi
	on od.item_id = mi.menu_item_id
group by item_name,category
order by num_purchased
;
-- 3. What were the top 5 orders that spent the most money?

select order_id,sum(price) as total_spend
from order_details od
left join menu_items mi
	on od.item_id = mi.menu_item_id
group by order_id
order by total_spend desc
limit 5
;
-- 4. View the details of the highest spend order. What insights can you gather from the 

select order_id,category, count(item_id) as num_items
from order_details od
left join menu_items mi
	on od.item_id = mi.menu_item_id
where order_id in (440,
2075,
1957,
330,
2675)
group by order_id,category
;