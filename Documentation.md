<div align="right">

# 📖 E-Commerce Platform Database Documentation
### Version: 1.0 | Author: Roberto | Date: May 2025

</div>

## 📌 Overview
This documentation describes the relational database design for an e-commerce platform using MySQL. It includes:

- Database Schema

- Sample Data

- SQL Queries

- Advanced Features

- Stored Procedures & Triggers

- Reports & Analytics


## 🛠 Database Schema

### ✅ Entity Overview
This system consists of six core tables:

1. Users → Stores customer/admin details.

2. Products → Manages inventory.

3. Orders → Tracks purchases.

4. OrderDetails → Links products to orders.

5. Payments → Handles transactions.

6. Reviews → Stores user feedback.

### ✅ Database Structure

#### **Users Table**
The `Users` table stores information about **registered users** in the system, including customers and administrators.
- `user_id`: Unique identifier for each user.
- `username`: Name chosen by the user for their account.
- `email`: Unique email address used for communication and login.
- `password`: Securely stored, ensuring at least **8 characters** for better security.
- `role`: Defines the user type (`customer` or `admin`).
- `created_at`: Timestamp of when the user account was created.
- `updated_at`: Automatically updated whenever user details change.
- **Indexes** ensure quick lookups based on email addresses.


📌 Purpose: Stores user account details with secure password storage.

---

#### **Products Table**
The `Products` table manages **inventory details** and product listings available for sale.
- `product_id`: Unique identifier for each product.
- `product_name`: Name of the product (must be unique).
- `category`: Defines the type of product (e.g., `Electronics`, `Clothing`).
- `price`: Decimal value representing the product’s cost.
- `stock_quantity`: Tracks available inventory to prevent overselling.
- `created_at`: Timestamp of when the product was added.
- `updated_at`: Updates whenever product details change.
- **Indexes** on `category` speed up category-based searches.

📌 Purpose: Manages inventory and product details.

---

#### **Orders Table**
The `Orders` table tracks **customer purchases**, maintaining a record of transactions.
- `order_id`: Unique identifier for each order.
- `user_id`: References the `Users` table, linking the order to a customer.
- `order_date`: Timestamp when the order was placed.
- `total_amount`: Sum of all product prices in the order.
- `order_status`: Tracks the order's progress (`Pending`, `Processing`, etc.).
- **Foreign keys** ensure each order belongs to a valid user.

📌 Purpose: Tracks user purchases and order progression.

---

#### **Order Details Table**
The `OrderDetails` table links **individual products** to specific orders, ensuring precise item tracking.
- `order_detail_id`: Unique identifier for each order item.
- `order_id`: References the `Orders` table, linking items to an order.
- `product_id`: References the `Products` table, linking the product to the order.
- `quantity`: Number of units purchased in the order.
- `unit_price`: Price of each unit when the order was placed.
- `created_at`: Timestamp tracking when the order item was recorded.
- **Foreign keys** enforce relationships between orders and products.

📌 Purpose: Links products to orders.

---

#### **Payments Table**
The `Payments` table records **financial transactions**, tracking successful purchases and possible refunds.
- `payment_id`: Unique identifier for each payment.
- `order_id`: References the `Orders` table to associate payments with purchases.
- `payment_date`: Timestamp when payment was processed.
- `payment_method`: Defines payment type (`Credit Card`, `PayPal`, etc.).
- `amount`: The monetary value of the transaction.
- `status`: Tracks whether the payment succeeded or failed (`Completed`, `Refunded`, etc.).
- **Foreign keys** ensure payments belong to valid orders.

📌 Purpose: Handles transactions.

---

#### **Reviews Table**
The `Reviews` table stores **customer feedback** on purchased products.
- `review_id`: Unique identifier for each review.
- `product_id`: References the `Products` table, linking the review to a product.
- `user_id`: References the `Users` table, linking the review to a customer.
- `review_text`: Written feedback from the user.
- `rating`: Numeric rating (**between 1 and 5 stars**).
- `review_date`: Timestamp when the review was submitted.
- **Foreign keys** maintain valid relationships between products and users.

📌 Purpose: Stores user feedback.


## 📊 Sample Data

### ✅ Users
The Users table contains essential information about registered individuals, including their usernames, unique email addresses, securely stored passwords, and designated roles as customers or administrators. It plays a crucial role in authentication, user management, and permission control, ensuring seamless interaction within the e-commerce platform while maintaining data integrity and security.

<div align="center">

| Username       | Email               | Password            | Role     |
| -------------- | ------------------- | ------------------- | -------- |
| alice_jones    | alice@example.com   | hashed_password_1   | customer |
| bob_smith      | bob@example.com     | hashed_password_2   | customer |
| charlie_admin  | charlie@example.com | hashed_password_3   | admin    |

</div>

### ✅ Products
The Products table contains essential details about the available inventory, including product names, categories, prices, and stock quantities. It enables efficient tracking of merchandise, ensuring accurate availability for customer purchases. The sample data includes a high-end Smartphone X and Wireless Headphones, both categorized under Electronics, with respective prices and stock levels that support inventory management.

<div align="center">

| Product Name         | Category    | Price  | Stock Quantity |
| -------------------- | ---------- | ------ | -------------- |
| Smartphone X        | Electronics | 699.99 | 50             |
| Wireless Headphones | Electronics | 149.99 | 100            |

</div>

### ✅ Orders
The Orders table captures key details of customer transactions, including the user who placed the order, the total purchase amount, and its current status. It ensures smooth order tracking and management, helping the platform streamline processing, shipping, and fulfillment while maintaining accurate records for financial oversight and customer service.

<div align="center">

| User ID | Total Amount | Order Status |
| ------- | ------------ | ------------- |
| 1       | 849.98       | Processing    |
| 2       | 89.99        | Shipped       |

</div>

### ✅ Order Details
The OrderDetails table serves as a crucial link between orders and the products they contain, ensuring precise item tracking. It records the quantity of each product in an order along with unit prices, enabling accurate pricing calculations and inventory updates. The sample data showcases diverse transactions, reflecting the platform’s ability to handle multiple product purchases seamlessly.

<div align="center">

| Order ID | Product ID | Quantity | Unit Price |
| -------- | ---------- | -------- | ---------- |
| 7        | 1         | 1        | 699.99     |
| 7        | 2         | 1        | 149.99     |
| 8        | 3         | 1        | 89.99      |
| 9        | 4         | 1        | 29.99      |

</div>

### ✅ Payments
The Payments table records financial transactions, ensuring a seamless checkout experience by tracking payment methods, transaction amounts, and statuses. It facilitates transparency in e-commerce operations, allowing the platform to manage completed purchases efficiently while supporting diverse payment options. The sample data highlights successful payments through credit card, PayPal, and bank transfer.

<div align="center">

| Order ID | Payment Method  | Amount  | Status     |
| -------- | -------------- | ------- | ---------- |
| 7        | Credit Card    | 849.98  | Completed  |
| 8        | PayPal         | 89.99   | Completed  |
| 9        | Bank Transfer  | 29.99   | Completed  |

</div>

### ✅ Reviews
The Reviews table captures valuable customer feedback, linking products to users who provide ratings and written evaluations. It enhances product credibility by reflecting user experiences, helping future buyers make informed decisions. The sample data highlights diverse opinions, from praising tech products to appreciating lifestyle items, showcasing the platform’s commitment to transparency and customer satisfaction.

<div align="center">

| Product ID | User ID | Review Text                                | Rating |
| ---------- | ------- | ----------------------------------------- | ------ |
| 1          | 1       | Amazing phone, fast and great battery life! | 5      |
| 2          | 1       | Good quality sound but slightly overpriced. | 4      |
| 3          | 2       | Perfect shoes for running!                  | 5      |
| 4          | 1       | Loved the recipes, easy to follow.          | 5      |

</div>

## 🔍 SQL Queries

### ✅ Retrieve a specific user
This query retrieves all details of a specific user from the Users table based on their unique user ID. It ensures precise identification, displaying attributes such as username, email, role, and timestamps. By filtering with user_id = 1, it efficiently fetches relevant account data, facilitating authentication, personalization, or administrative management within the platform.

```SQL
SELECT * FROM Users WHERE user_id = 1;
```
📌 Purpose: Fetches details of a given user.

---

### ✅ Retrieve order history for a user
This query retrieves all orders placed by the user with ID 1, displaying essential details such as order date, total amount, and current status. It enables efficient tracking of purchase history, allowing seamless order management, financial analysis, and personalized customer interactions within the e-commerce platform.

```SQL
SELECT * FROM Orders WHERE user_id = 1;
```
📌 Purpose: Lists all orders placed by the user.

---

### ✅ Identify top-selling products
This query identifies the top-selling products by calculating the total quantity sold for each item. It joins the Products and OrderDetails tables, groups results by product, and ranks them in descending order based on sales volume. By limiting output to five entries, it efficiently highlights the platform’s most in-demand products, supporting inventory and marketing decisions.

```SQL
SELECT 
    p.product_id, 
    p.product_name, 
    SUM(od.quantity) AS total_sold 
FROM Products p
INNER JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 5;
```
📌 Purpose: Ranks best-selling products based on total sales.

## 🔁 Stored Procedures & Triggers

### ✅ Automate Order Status Updates
This stored procedure automates order status progression by checking the current state and updating it accordingly. When executed, it transitions orders from "Pending" to "Processing," then to "Shipped," and finally to "Delivered," streamlining order management. This ensures efficient workflow automation, reducing manual intervention while enhancing transaction accuracy within the e-commerce platform.

```SQL
DELIMITER //
CREATE PROCEDURE UpdateOrderStatus(IN orderID INT)
BEGIN
    DECLARE orderStatus ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled', 'Completed');
    
    SELECT order_status INTO orderStatus FROM Orders WHERE order_id = orderID;
    
    IF orderStatus = 'Pending' THEN
        UPDATE Orders SET order_status = 'Processing' WHERE order_id = orderID;
    ELSEIF orderStatus = 'Processing' THEN
        UPDATE Orders SET order_status = 'Shipped' WHERE order_id = orderID;
    ELSEIF orderStatus = 'Shipped' THEN
        UPDATE Orders SET order_status = 'Delivered' WHERE order_id = orderID;
    END IF;
END //
DELIMITER ;
```
📌 Purpose: Automatically updates order status based on processing stage.

---

### ✅ Trigger to Update Order on Payment Completion
This trigger ensures seamless automation of order status updates upon payment completion. When a payment record is modified, it checks whether the transaction is marked as "Completed." If so, it invokes the UpdateOrderStatus procedure, ensuring the corresponding order transitions to the next stage. This enhances operational efficiency, reduces manual intervention, and streamlines the e-commerce workflow.

```SQL
CREATE TRIGGER UpdateOrderOnPayment
AFTER UPDATE ON Payments
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completed' THEN
        CALL UpdateOrderStatus(NEW.order_id);
    END IF;
END;
```
📌 Purpose: When payment is completed, order status updates automatically.

## 📊 Reports & Analytics

### ✅ Generate a report on most active users
This query identifies the platform’s most engaged users by calculating their activity score based on placed orders, submitted reviews, and completed payments. By joining the Users, Orders, Reviews, and Payments tables, it ranks users by overall interaction, spotlighting top contributors and helping businesses tailor promotions, rewards, or personalized recommendations for their most active customers.

```SQL
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
LIMIT 10;
```
📌 Purpose: Lists top active users based on purchases and engagement.

## 📌 Final Notes
This documentation provides a structured reference for developers working on the E-Commerce Platform database. It includes schema design, query explanations, automation techniques, and analytics.