show databases;
use ecommerce_db;
show tables;
select*from customers;
select*from order_items order by order_id asc;
select * from products order by product_id asc;
select * from orders order by order_id asc;	
select * from payments order by payment_id asc;
select * from reviews order by review_id asc;
select * from shipments order by shipment_id asc;
select * from suppliers order by supplier_id asc;


alter table customers add primary key(customer_id);
alter table order_items add primary key(order_item_id);
alter table orders add primary key(order_id);
alter table payments add primary key(payment_id);
alter table products add primary key(product_id);
alter table reviews add primary key(review_id);
alter table shipments add primary key(shipment_id);
alter table suppliers add primary key(supplier_id);


alter table order_items add foreign key(order_id) references orders(order_id),add foreign key(product_id) references products(product_id);
alter table orders add foreign key(customer_id) references customers(customer_id);
alter table payments add foreign key(order_id) references orders(order_id);
alter table reviews add foreign key(product_id) references products(product_id) ,add foreign key(customer_id) references customers(customer_id);
alter table shipments add foreign key(order_id) references orders(order_id);


select * from orders order by order_id asc ;
select*from order_items;
select * from products order by product_id asc;


select round(sum(amount),2) as total_revenue from payments where transaction_status="Completed";
select round(sum(quantity*price_at_purchase),2) as realized_cash_revenue from order_items;
select round(sum(o.total_price),2) as perfect_payment_delivery from orders as o join shipments as s on o.order_id=s.order_id group by s.shipment_status having s.shipment_status="Delivered";
select round(sum(amount),2) as successfull_revenue from payments where transaction_status="Completed";

select date_format(order_date,"%Y-%m") as order_month, round(sum(total_price),2) as total_revenue,round(avg(total_price)) as avg_order_value from orders GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month ASC;

-- Find all customers whose total lifetime spending is higher than the overall average spending per customer across the entire platform.
select c.customer_id,c.last_name,round(sum(o.total_price),2) as each_person_spent from customers as c join orders as o on o.customer_id=c.customer_id group by c.customer_id,c.last_name having sum(total_price)>(select avg(customer_lifetime_total) from (select sum(total_price) as customer_lifetime_total from orders group by customer_id) as customer_totals);

-- Identify the top 5 customers who have placed an order with a total price higher than the average order value of all orders placed in 2024.
SELECT 
    c.customer_id,
    c.last_name,
    o.order_id,
    o.order_date,
    o.total_price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_price > (
    -- Subquery: Calculates the average total_price of all orders placed in 2024
    SELECT AVG(total_price)
    FROM orders
    WHERE YEAR(order_date) = 2024
)
ORDER BY o.total_price DESC
LIMIT 5;
select * from orders;

-- List all customers who have placed at least one order where the order total exceeded the maximum order price from the 'Accessories' category. 
select c.customer_id,c.last_name,o.total_price from customers as c join orders as o on o.customer_id=c.customer_id where o.total_price>(select max(oi.price_at_purchase) from order_items as oi join products as p on oi.product_id=p.product_id where p.category="Accessories");

--  Retrieve all products whose listed price is strictly above the average price of products within their own respective category (Correlated Subquery).
select p1.product_name,p1.price from products as p1 where price>(select avg(price) from products as p2 where p2.category=p1.category);

-- Find all products that have generated zero sales
 select p.product_name from products as p left join order_items as oi on oi.product_id=p.product_id where oi.product_id is null;
 
 -- List the product names and categories that have a higher total quantity sold than the average quantity sold across all products.
select p.product_name,p.category,sum(oi.quantity) as total_quantity from products as p join order_items as oi on oi.product_id=p.product_id group by p.product_name,p.category having sum(oi.quantity)>(select avg(product_qty_total) from (select sum(oi.quantity) as product_qty_total from order_items as oi group by oi.product_id) as product_totals);

-- Find the customers who have given a rating lower than the overall average rating across all reviews.
select c.customer_id,c.last_name,r.rating from customers as c join reviews as r on r.customer_id=c.customer_id where r.rating<(select avg(rating) from reviews);
-- Retrieve all products whose average review rating is higher than the average rating of the category they belong to. 
SELECT p.product_id,p.product_name,p.category,ROUND(AVG(r.rating), 2) AS product_avg_rating FROM products p JOIN reviews r ON p.product_id = r.product_id GROUP BY p.product_id, p.product_name, p.category HAVING AVG(r.rating) > (SELECT AVG(r2.rating) FROM reviews r2 JOIN products p2 ON r2.product_id = p2.product_id WHERE p2.category = p.category) ORDER BY p.category, product_avg_rating DESC;
-- Retrieve all orders that were paid using the single most popular payment method (the payment method with the highest transaction count).
select o.order_id,o.customer_id,o.total_price from orders as o join payments as p on p.order_id=o.order_id where p.payment_method=(SELECT payment_method from payments group by payment_method order by COUNT(*) desc limit 1)

 