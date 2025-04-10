-- Active: 1742401879132@@127.0.0.1@5432@bookstore_db

CREATE DATABASE bookstore_db; --create database bookstore_db

-- create books table with columns and data types
create table books(id SERIAL PRIMARY KEY,title VARCHAR(50) NOT NULL,author VARCHAR(50) NOT NULL,price DECIMAL NOT NULL CHECK(price > 0),stock SMALLINT NOT NULL,published_year VARCHAR(10) NOT NULL);

-- create customers table with columns and data types
CREATE TABLE customers(id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL, email VARCHAR(50) UNIQUE NOT NULL, joined_date DATE DEFAULT now());

-- create orders table with columns and data types
CREATE TABLE orders(id SERIAL PRIMARY KEY, customer_id INT NOT NULL REFERENCES customers(id),book_id INT NOT NULL REFERENCES books(id),quantity SMALLINT NOT NULL CHECK (quantity > 0), order_date DATE DEFAULT now());

-- insert values on books table 
INSERT INTO books (title, author, price, stock, published_year) VALUES
    ('The Great Gatsby', 'F. Scott Fitzgerald', 10, 25, '1925'),
    ('To Kill a Mockingbird', 'Harper Lee', 12, 30, '1960'),
    ('1984', 'George Orwell', 15, 20, '1949'),
    ('Pride and Prejudice', 'Jane Austen', 9, 18, '1813'),
    ('Moby-Dick', 'Herman Melville', 14, 12, '1851'),
    ('War and Peace', 'Leo Tolstoy', 20, 10, '1869'),
    ('The Catcher in the Rye', 'J.D. Salinger', 11, 22, '1951'),
    ('Brave New World', 'Aldous Huxley', 13, 15, '1932'),
    ('The Hobbit', 'J.R.R. Tolkien', 18, 28, '1937'),
    ('The Lord of the Rings', 'J.R.R. Tolkien', 25, 12, '1954'),
    ('Crime and Punishment', 'Fyodor Dostoevsky', 17, 14, '1866'),
    ('The Brothers Karamazov', 'Fyodor Dostoevsky', 22, 8, '1880'),
    ('Ulysses', 'James Joyce', 19, 10, '1922'),
    ('The Odyssey', 'Homer', 16, 11, '1800'),
    ('The Iliad', 'Homer', 16, 9, '1762'),
    ('Les Misérables', 'Victor Hugo', 21, 10, '1862'),
    ('Don Quixote', 'Miguel de Cervantes', 20, 13, '1605'),
    ('Anna Karenina', 'Leo Tolstoy', 19, 17, '1877'),
    ('The Divine Comedy', 'Dante Alighieri', 23, 6, '1320'),
    ('The Count of Monte Cristo', 'Alexandre Dumas', 18, 15, '1844'),
    ('Dracula', 'Bram Stoker', 14, 20, '1897'),
    ('Frankenstein', 'Mary Shelley', 12, 18, '1818'),
    ('The Sun Also Rises', 'Ernest Hemingway', 12, 18, '1926'),
    ('Lord of the Flies', 'William Golding', 13, 16, '1954'),
    ('Gulliver’s Travels', 'Jonathan Swift', 15, 11, '1726'),
    ('The Handmaid’s Tale', 'Margaret Atwood', 16, 14, '1985'),
    ('Dune', 'Frank Herbert', 20, 8, '1965'),
    ('The Shining', 'Stephen King', 18, 9, '1977'),
    ('The Great Test', 'PKS', 18, 0, '2025');


-- insert values on customers table 
INSERT INTO customers (name, email) VALUES
    ('Pallab Kumar', 'pallabkumar@gmail.com'),
	('Test' , 'test@test.mail');

INSERT INTO customers (name, email) VALUES
    ('Pallab Delete', 'pallabkumar@gmail.mail');

-- insert values on orders table 
INSERT INTO orders (customer_id, book_id, quantity, order_date) VALUES
	(1, 27, 2, '2023-01-15'),
	(1, 5, 2, '2023-01-15'),
	(1, 6, 2, '2023-01-15'),
	(1, 1, 2, '2023-01-15'),
	(2, 10, 2, '2023-01-15'),
	(2, 20, 2, '2023-01-15');

-- show table data
SELECT * FROM books;

-- show table data
SELECT * FROM customers;

-- show table data
SELECT * FROM orders;

-- drop table
DROP TABLE customers;

--change table
ALTER TABLE orders ALTER COLUMN customer_id SET NOT NULL;


--* 1. show all books with stock 0
SELECT title FROM books WHERE stock = 0;

--* 2. most expensive book
SELECT * FROM books WHERE price = (SELECT MAX(price) FROM books);

--* 3. total number of orders for each customer
SELECT name,COUNT(orders.id) as total_orders FROM orders JOIN customers ON customers.id = orders.customer_id  GROUP BY name;

--* 4. total revenue generated by each book
SELECT SUM(quantity * price) as total_revenue FROM books JOIN orders ON books.id = orders.book_id;

--* 5. customers who have ordered more than 1 order
SELECT name,COUNT(orders.id) FROM customers JOIN orders ON customers.id = orders.customer_id GROUP BY name HAVING COUNT(orders.id) > 1;

--* 6. average price of all books
SELECT ROUND(AVG(price)::NUMERIC, 2) as avg_book_price FROM books;

--* 7. price increase by 10% for all books published before 2000
UPDATE books SET price = price * 1.1 WHERE published_year::INTEGER < 2000;
 
--* 8. delete customers who have not placed any orders
DELETE FROM customers WHERE customers.id NOT IN (SELECT customer_id FROM orders);



