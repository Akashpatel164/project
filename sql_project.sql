create database pizzadb;
use pizzadb;

select * from pizza_sales ;

-- 1. Total Revenue: The sum of the total price of all pizza orders
select sum(total_price) from pizza_sales;

-- 2. Average Order Value: The average amount spent per order, calculated by dividing the total revenue by the total number of orders
select sum(total_price)/sum(quantity)  as 'avg_amount_per_order'from pizza_sales;

-- 3. Total Pizzas Sold: The sum of the quantities of all pizza sold.
select sum(quantity) from pizza_sales;

-- 4. Total Orders: The total number of orders placed.
select count(pizza_id)from pizza_sales;

-- 5. Average Pizza Per Order: The average number of pizzas sold per order, 
-- calculated by dividing the total number of pizzas sold by the total number of orders
select avg(quantity) from pizza_sales;
select sum(quantity)/count(pizza_id) as avg_pizza_per_order from pizza_sales;

-- 6. Daily trend for total Orders: Create a bar chart that displays the daily trend of 
-- total orders over a specific time period. This chart will help us identify any 
-- patterns or fluctuations in order volumes on a daily basis
select count(order_id),(order_date) from pizza_sales group by order_date;
  
--   7. Total Pizza Sold by Pizza Category
select pizza_category,count(pizza_id) from pizza_sales group by pizza_category;

-- 8. Top 5 Best Sellers by Revenue, Total Quantity and Total Orders: 
select pizza_name,count(total_price) as "Revenue" from pizza_sales group by pizza_name order by Revenue desc limit 5;
select pizza_name,sum(quantity) as "total_quantity" from pizza_sales group by pizza_name order by total_quantity desc limit 5;
select pizza_name,count(order_id) as "total_order" from pizza_sales group by pizza_name order by total_order desc limit 5;

 -- 9. bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders: 
select pizza_name,count(total_price) as "Revenue" from pizza_sales group by pizza_name order by Revenue asc limit 5;
select pizza_name,sum(quantity) as "total_quantity" from pizza_sales group by pizza_name order by total_quantity asc limit 5;
select pizza_name,count(order_id) as "total_order" from pizza_sales group by pizza_name order by total_order asc limit 5;

-- 10.max price of pizza(top 10)
select pizza_name,max(unit_price) from pizza_sales group by pizza_name order by max(unit_price) desc limit 10;

