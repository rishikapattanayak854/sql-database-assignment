CREATE DATABASE IF NOT EXISTS sql_assignment;
USE sql_assignment;

CREATE TABLE IF NOT EXISTS customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50),
    registration_date DATE
);

CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE IF NOT EXISTS order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT IGNORE INTO customers
(id, name, email, country, registration_date) VALUES
(1, 'Aarav Sharma', 'aarav@example.com', 'India', '2026-01-10'),
(2, 'Priya Das', 'priya@example.com', 'India', '2026-03-15'),
(3, 'Rahul Verma', 'rahul@example.com', 'India', '2025-06-20'),
(4, 'Ananya Patel', 'ananya@example.com', 'USA', '2026-02-12'),
(5, 'Rohan Kumar', 'rohan@example.com', 'India', '2026-07-05');

INSERT IGNORE INTO products
(id, name, category, price) VALUES
(1, 'Laptop', 'Electronics', 55000.00),
(2, 'Smartphone', 'Electronics', 25000.00),
(3, 'Headphones', 'Electronics', 5000.00),
(4, 'Office Chair', 'Furniture', 8000.00),
(5, 'Keyboard', 'Electronics', 1500.00),
(6, 'Monitor', 'Electronics', 12000.00);

INSERT IGNORE INTO orders
(id, customer_id, order_date, total_amount) VALUES
(1, 1, '2026-01-20', 55000.00),
(2, 2, '2026-02-15', 25000.00),
(3, 1, '2026-03-10', 62000.00),
(4, 3, '2026-04-05', 8000.00),
(5, 4, '2026-05-12', 12000.00),
(6, 5, '2026-06-18', 70000.00),
(7, 2, '2026-07-22', 15000.00),
(8, 3, '2026-08-14', 5000.00),
(9, 1, '2026-09-02', 35000.00),
(10, 5, '2026-09-20', 45000.00);

INSERT IGNORE INTO order_items
(id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 1, 1),
(4, 3, 6, 1),
(5, 4, 4, 1),
(6, 5, 6, 1),
(7, 6, 1, 1),
(8, 7, 6, 1),
(9, 8, 3, 1),
(10, 9, 2, 1),
(11, 10, 1, 1);

SHOW TABLES;

SELECT name, email
FROM customers
WHERE country = 'India'
AND registration_date >= '2026-01-01'
AND registration_date < '2027-01-01';

SELECT id, name, category, price
FROM products
WHERE category = 'Electronics'
AND price BETWEEN 5000 AND 50000
ORDER BY price DESC;

SELECT
    c.name AS customer_name,
    o.order_date,
    o.total_amount
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.id
ORDER BY o.total_amount DESC
LIMIT 10;

SELECT
    c.name AS customer_name,
    p.name AS product_name,
    o.order_date
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.id
INNER JOIN order_items oi
    ON o.id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.id
ORDER BY o.order_date;