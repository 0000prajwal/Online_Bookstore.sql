-- Create Database
CREATE DATABASE OnlineBookstore;


-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers(
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
)


CREATE TABLE Orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC (10,2)
);

-- Import Data into Books, Customers, and Orders tables
-- Import CSV data into the Books, Customers, and Orders tables
-- Data was imported using pgAdmin's Import/Export Data option.




SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE Genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE Published_Year > 1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS Total_Stock
FROM Books;

-- 6) Find the details of Five most expensive book:
SELECT * FROM Books
ORDER BY Price DESC  LIMIT 5;

-- 7) Show all customers who ordered more than 5 quantity of a book:
SELECT * FROM Orders
WHERE quantity >5;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE total_amount >20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM Books;


-- 10) Find the book with the lowest stock:
SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT * FROM Orders;

SELECT b.Genre , sum(o. Quantity) AS Total_Books_sold
FROM  Orders o
join Books b ON o.Book_id = b.Book_id
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT
	AVG(PRICE) AS AVERAGE_PRICE
FROM
	BOOKS
WHERE
	GENRE = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
select o.customer_id, c.name, count(o.order_id) as ORDER_COUNT
FROM  orders o
join customers c on o.customer_id = c.customer_id
group by o.customer_id , c.name
having count(Order_id) >= 2;

-- 4) Find the most frequently ordered book:
select o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
join	books b on o.book_id = b.book_id
group by o.book_id, b.title
order by ORDER_COUNT DESC LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where Genre = 'Fantasy'
order by price desc  limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select  b.author, sum(o.quantity) As total_books_sold
from orders o
join books b on o.book_id = b.book_id
group by b.Author;


-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city ,total_amount
from orders  o 
join customers c on o.customer_id = c.customer_id
where o.total_amount> 30;

-- 8) Find the customer who spent the most on orders:

select c.customer_id, c.name, sum(o.total_amount) as Total_spent
from orders o
join customers c on o.customer_id = c.customer_id
group by c.customer_id, c.name
order by Total_spent Desc limit 1;

--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id ;
