# JFS-Project-E-Commerce-Platform-Database-Design-and-Implementation
Design and implement a comprehensive relational database for a complex e-commerce platform using MySQL. The database should handle various aspects of an online shopping system, including product management, user accounts, orders, payments, and reviews.

## Requirements

### Database Schema

- Create a MySQL database named ECommercePlatform.
- Design tables for:
  - Users (user_id, username, email, password, role)
  - Products (product_id, product_name, category, price, stock_quantity)
  - Orders (order_id, user_id, order_date, total_amount, order_status)
  - OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price)
  - Payments (payment_id, order_id, payment_date, payment_method, amount)
  - Reviews (review_id, product_id, user_id, review_text, rating, review_date)

### Insert Sample Data

- Populate the tables with diverse and extensive sample data.
- Include various products, users, orders, payments, and reviews.

### Queries
Write SQL queries for the following operations

- Retrieve the list of all products in a specific category.
- Retrieve the details of a specific user by providing their user_id.
- Retrieve the order history for a particular user.
- Retrieve the products in an order along with their quantities and prices.
- Retrieve the average rating of a product.
- Retrieve the total revenue for a given month.

### Data Modification
Implement SQL queries to

- Add a new product to the inventory.
- Place a new order for a user.
- Update the stock quantity of a product.
- Remove a user's review.

### Complex Queries
Write complex SQL queries to

- Identify the top-selling products.
- Find users who have placed orders exceeding a certain amount.
- Calculate the overall average rating for each product category.

### Advanced Topics
Implement stored procedures or triggers to

- Automatically update the order status based on order processing.
- Generate a report on the most active users.

### Documentation
Create documentation that includes the database schema, sample data, and explanations for each query.
