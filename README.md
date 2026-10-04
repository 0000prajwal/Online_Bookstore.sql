# 📚 Online Bookstore SQL Project

## 📌 Project Overview

This project is an **Online Bookstore SQL Analysis Project** created using **PostgreSQL** and **pgAdmin 4**.

The purpose of this project is to work with bookstore data and use SQL to analyze **books, customers, orders, sales, revenue, and inventory**.

This project demonstrates practical SQL skills through basic and advanced data analysis queries.

---

## 🛠️ Tools & Technologies

- PostgreSQL
- pgAdmin 4
- SQL
- CSV Dataset
- GitHub

---

## 🗄️ Database

**Database Name:**

`OnlineBookstore`

---

## 📊 Database Tables

The database contains three main tables:

### 📖 Books

Stores information about books available in the bookstore.

- Book_ID
- Title
- Author
- Genre
- Published_Year
- Price
- Stock

### 👥 Customers

Stores customer information.

- Customer_ID
- Name
- Email
- Phone
- City
- Country

### 🛒 Orders

Stores customer order information.

- Order_ID
- Customer_ID
- Book_ID
- Order_Date
- Quantity
- Total_Amount

---

## 🔗 Database Relationships

The tables are connected using Primary Keys and Foreign Keys.

```text
Customers
    |
    | Customer_ID
    |
    v
Orders
    |
    | Book_ID
    |
    v
Books
