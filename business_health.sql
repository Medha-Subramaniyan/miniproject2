--Show each order’s ID, order date, and the name of the customer who placed it.
SELECT o.order_id, o.order_date, c.name FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id; 

--List each product that has been included in an order, along with its name and price.
SELECT o.order_id, p.product_id, p.product_name, p.price from products p
LEFT JOIN order_items o ON p.product_id = o.product_id;

--Return a full list of all patients along with their appointment dates (if any).
SELECT  p.name, a.appointment_date from patients p
LEFT JOIN appointments a ON a.patient_id = p.patient_id

--Show all products ordered by each customer, including the customer’s name, product name, and quantity ordered.
SELECT  c.name, p.product_name, oi.quantity  FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id 
LEFT JOIN products p ON oi.product_id = p.product_id 

--For each customer, return the total amount they have spent across all orders.
SELECT c.name, SUM(o.total_amount) as "Sum of Orders" FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id 
GROUP BY c.name, o.total_amount
ORDER BY o.total_amount ASC; 

--List each patient along with the name of every doctor they’ve had an appointment with.
SELECT p.name AS "Pt name", d.name AS "Doc's Name" FROM patients p 
LEFT JOIN appointments a ON a.patient_id = p.patient_id 
LEFT JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE d.name IS NOT NULL; 

--Return the total sales amount grouped by customer region.
SELECT c.region, SUM(o.total_amount) FROM orders o
LEFT JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.region; 

--List the top 5 customers based on their total spending.
SELECT c.name, o.total_amount from customers c 
LEFT JOIN 
orders o ON c.customer_id = o.customer_id
WHERE o.total_amount IS NOT NULL
ORDER BY o.total_amount DESC
LIMIT 5;

--Identify the product that has been ordered in the highest total quantity.
SELECT oi.quantity, p.product_name from order_items oi  
LEFT JOIN orders o on o.order_id = oi.order_id 
LEFT JOIN products p ON p.product_id = oi.product_id
ORDER BY oi.quantity DESC
LIMIT 1; 

