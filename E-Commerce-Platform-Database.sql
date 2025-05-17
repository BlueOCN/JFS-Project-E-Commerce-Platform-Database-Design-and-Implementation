-- Active: 1747454077714@@127.0.0.1@3306@ecommerceplatform


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
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') NOT NULL,
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