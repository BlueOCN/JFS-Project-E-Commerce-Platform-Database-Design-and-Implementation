-- Active: 1747454077714@@127.0.0.1@3306@ecommerceplatform


/*
    Database Schema
*/

-- Create a MySQL database named ECommercePlatform.
CREATE DATABASE ECommercePlatform;

-- Check the database was created
SHOW DATABASES;
USE ECommercePlatform;

-- Design tables for Users (user_id, username, email, password, role)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL CHECK(LENGTH(password) >= 8),
    role ENUM('customer', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX(email)
);

--  Design table for Products (product_id, product_name, category, price, stock_quantity)
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT, 
    product_name VARCHAR(100) UNIQUE NOT NULL, 
    category ENUM('Electronics', 'Clothing', 'Books', 'Home', 'Beauty') NOT NULL, 
    price DECIMAL(10,4) NOT NULL, 
    stock_quantity INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX(category)
);

--  Design table for Orders (order_id, user_id, order_date, total_amount, order_status)
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT, 
    user_id INT NOT NULL, 
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    total_amount DECIMAL(10,4) NOT NULL, 
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled', 'Completed') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    INDEX(order_status)
);

--  Design table for OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price)
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT, 
    order_id INT NOT NULL, 
    product_id INT NULL, 
    quantity INT NOT NULL CHECK (quantity > 0), 
    unit_price DECIMAL(10,4) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE SET NULL,
    INDEX(order_id),
    INDEX(product_id)
);

--  Design table for Payments (payment_id, order_id, payment_date, payment_method, amount)
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT, 
    order_id INT NULL, 
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Crypto') NOT NULL, 
    amount DECIMAL(10,4) NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed', 'Refunded') NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE SET NULL,
    INDEX(order_id)
);

--  Design table for Reviews (review_id, product_id, user_id, review_text, rating, review_date)
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT, 
    product_id INT NOT NULL, 
    user_id INT NOT NULL, 
    review_text VARCHAR(500) NOT NULL, 
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), 
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    INDEX(product_id),
    INDEX(user_id),
    INDEX(rating)
);

-- Verify table creation
SHOW TABLES;

-- Verify table details
DESCRIBE Users;
DESCRIBE Products;
DESCRIBE Orders;
DESCRIBE OrderDetails;
DESCRIBE Payments;
DESCRIBE Reviews;


/*
    Insert Sample Data
*/

-- Sample Users
INSERT INTO Users (username, email, password, role) VALUES
('alice_jones', 'alice@example.com', 'hashed_password_1', 'customer'),
('bob_smith', 'bob@example.com', 'hashed_password_2', 'customer'),
('charlie_admin', 'charlie@example.com', 'hashed_password_3', 'admin');

-- Sample Products
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('Smartphone X', 'Electronics', 699.99, 50),
('Wireless Headphones', 'Electronics', 149.99, 100),
('Running Shoes', 'Clothing', 89.99, 75),
('Cookbook: Mastering Italian', 'Books', 29.99, 30),
('Essential Oil Set', 'Beauty', 39.99, 40);

-- Sample Orders
INSERT INTO Orders (user_id, total_amount, order_status) VALUES
(1, 849.98, 'Processing'),
(2, 89.99, 'Shipped'),
(1, 29.99, 'Completed');

-- Sample Order Details
INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price) VALUES
(7, 1, 1, 699.99),
(7, 2, 1, 149.99),
(8, 3, 1, 89.99),
(9, 4, 1, 29.99);

-- Sample Payments
INSERT INTO Payments (order_id, payment_method, amount, status) VALUES
(7, 'Credit Card', 849.98, 'Completed'),
(8, 'PayPal', 89.99, 'Completed'),
(9, 'Bank Transfer', 29.99, 'Completed');

-- Sample Reviews
INSERT INTO Reviews (product_id, user_id, review_text, rating) VALUES
(1, 1, 'Amazing phone, fast and great battery life!', 5),
(2, 1, 'Good quality sound but slightly overpriced.', 4),
(3, 2, 'Perfect shoes for running!', 5),
(4, 1, 'Loved the recipes, easy to follow.', 5);

-- Verify tables
SELECT * FROM Users;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Payments;
SELECT * FROM Reviews;


/*
    Queries
*/

-- Retrieve the list of all products in a specific category.
SELECT * FROM products WHERE category = 'Electronics';

-- Retrieve the details of a specific user by providing their user_id.
SELECT * FROM Users WHERE user_id = 1;

-- Retrieve the order history for a particular user.
SELECT * FROM Orders WHERE user_id = 1;

-- Retrieve the products in an order along with their quantities and prices.
SELECT 
    o.order_id, 
    p.product_name, 
    od.quantity, 
    od.unit_price 
FROM Orders o
INNER JOIN OrderDetails od ON o.order_id = od.order_id
INNER JOIN Products p ON od.product_id = p.product_id
WHERE o.order_id = 7;

-- Retrieve the average rating of a product.
SELECT AVG(r.rating) AS average_rating
FROM Reviews r
WHERE r.product_id = 2;

-- Retrieve the total revenue for a given month.
SELECT SUM(amount) AS total_revenue 
FROM Payments
WHERE MONTH(payment_date) = 5 AND YEAR(payment_date) = 2025;

SELECT SUM(amount) AS total_revenue 
FROM Payments
WHERE MONTHNAME(payment_date) = 'may' AND YEAR(payment_date) = 2025;


/*
    Data Modification
*/

-- Add a new product to the inventory.
INSERT INTO Products (product_name, category, price, stock_quantity, created_at) 
VALUES ('Gaming Laptop', 'Electronics', 1299.99, 20, CURRENT_TIMESTAMP);


-- Place a new order for a user.
INSERT INTO Orders (user_id, total_amount, order_status, order_date) 
VALUES (1, 1299.99, 'Pending', CURRENT_TIMESTAMP);
INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price) 
VALUES (11, 6, 2, 1299.99);

-- Update the stock quantity of a product.
UPDATE products
SET stock_quantity = 30, updated_at = CURRENT_TIMESTAMP
WHERE product_id = 6;

-- Remove a user's review.
DELETE FROM Reviews
WHERE user_id = 1 AND review_id = 4
LIMIT 1;


/*
    Complex Queries
*/

-- Identify the top-selling products.
SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_sold
FROM products p
INNER JOIN orderdetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- Find users who have placed orders exceeding a certain amount.
SELECT 
    o.user_id, 
    u.username, 
    SUM(o.total_amount) AS orders_total_amount 
FROM Orders o
INNER JOIN Users u ON o.user_id = u.user_id
GROUP BY o.user_id, u.username
HAVING orders_total_amount > 1500
ORDER BY orders_total_amount DESC;


-- Calculate the overall average rating for each product category.
SELECT 
    p.category, 
    COALESCE(AVG(r.rating), 0) AS avg_rating 
FROM Reviews r
RIGHT JOIN products p ON r.product_id = p.product_id
GROUP BY p.category
ORDER BY avg_rating DESC;


/*
    Advanced Topics
*/

-- Automatically update the order status based on order processing.
DELIMITER //
CREATE PROCEDURE UpdateOrderStatus(IN orderID INT)
BEGIN
    DECLARE orderStatus ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled', 'Completed');
    
    -- Get current status of the order
    SELECT order_status INTO orderStatus FROM Orders WHERE order_id = orderID;
    
    -- Update status based on conditions
    IF orderStatus = 'Pending' THEN
        UPDATE Orders SET order_status = 'Processing' WHERE order_id = orderID;
    ELSEIF orderStatus = 'Processing' THEN
        UPDATE Orders SET order_status = 'Shipped' WHERE order_id = orderID;
    ELSEIF orderStatus = 'Shipped' THEN
        UPDATE Orders SET order_status = 'Delivered' WHERE order_id = orderID;
    END IF;
END //
DELIMITER ;

CREATE TRIGGER UpdateOrderOnPayment
AFTER UPDATE ON Payments
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completed' THEN
        CALL UpdateOrderStatus(NEW.order_id);
    END IF;
END;


-- Generate a report on the most active users.
SELECT 
    u.user_id, 
    u.username, 
    COUNT(DISTINCT o.order_id) AS total_orders, 
    COUNT(DISTINCT r.review_id) AS total_reviews, 
    COUNT(DISTINCT p.payment_id) AS total_payments,
    (COUNT(DISTINCT o.order_id) + COUNT(DISTINCT r.review_id) + COUNT(DISTINCT p.payment_id)) AS activity_score
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
LEFT JOIN Reviews r ON u.user_id = r.user_id
LEFT JOIN Payments p ON o.order_id = p.order_id
GROUP BY u.user_id, u.username
ORDER BY activity_score DESC
LIMIT 3;
