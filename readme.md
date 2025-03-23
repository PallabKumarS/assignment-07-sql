# PostgreSQL FAQ

## What is PostgreSQL?
PostgreSQL একটি ওপেন-সোর্স, অবজেক্ট-রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম (ORDBMS) যা উন্নত SQL ফিচার, এক্সটেনসিবিলিটি, এবং শক্তিশালী পারফরম্যান্স অফার করে। এটি ACID কমপ্লায়েন্ট এবং উচ্চ-লেভেলের স্কেলিবিলিটি সমর্থন করে।

## What is the purpose of a database schema in PostgreSQL?
একটি **ডাটাবেস স্কিমা** হলো একটি লজিক্যাল গ্রুপিং যা ডাটাবেসের টেবিল, ভিউ, ইনডেক্স, এবং অন্যান্য অবজেক্টগুলোর সংগঠিত কাঠামো নির্ধারণ করে। এটি ডাটাবেস ম্যানেজমেন্টকে সহজ করে এবং মাল্টি-ইউজার এনভায়রনমেন্টে ডেটা সেগ্রিগেশন করতে সাহায্য করে।

## Explain the Primary Key and Foreign Key concepts in PostgreSQL.
- **Primary Key:** এটি একটি টেবিলের এমন একটি কলাম যা ইউনিক ও NULL হতে পারে না। এটি প্রতিটি সারিকে স্বতন্ত্রভাবে চিহ্নিত করে।
- **Foreign Key:** এটি অন্য একটি টেবিলের **Primary Key**-এর সাথে সংযুক্ত থাকে এবং দুই টেবলের মধ্যে সম্পর্ক স্থাপন করে। এটি রেফারেন্সিয়াল ইন্টিগ্রিটি বজায় রাখে।

## What is the difference between the VARCHAR and CHAR data types?
- **VARCHAR(n):** এটি **পরিবর্তনশীল দৈর্ঘ্যের স্ট্রিং** সংরক্ষণ করে এবং শুধুমাত্র ব্যবহৃত জায়গা নেয়।
- **CHAR(n):** এটি **স্থির দৈর্ঘ্যের স্ট্রিং** সংরক্ষণ করে এবং অপ্রয়োজনীয় স্থান পূরণ করতে অতিরিক্ত স্পেস ব্যবহার করে।

## Explain the purpose of the WHERE clause in a SELECT statement.
`WHERE` ক্লজ ব্যবহার করা হয় **নির্দিষ্ট শর্তের ভিত্তিতে ডেটা ফিল্টার** করতে। এটি ডাটাবেস কোয়েরিতে নির্দিষ্ট রেকর্ড নির্বাচন করতে সাহায্য করে।
```sql
SELECT * FROM books WHERE price > 500;
```
এটি শুধুমাত্র সেই বইগুলো ফেরত দেবে যেগুলোর মূল্য ৫০০-এর বেশি।

## What are the LIMIT and OFFSET clauses used for?
- **LIMIT:** একটি কোয়েরির রেজাল্ট থেকে নির্দিষ্ট সংখ্যক সারি ফিরিয়ে দেয়।
- **OFFSET:** নির্দিষ্ট সংখ্যক সারি বাদ দিয়ে তারপর থেকে রেজাল্ট রিটার্ন করে।
```sql
SELECT * FROM books LIMIT 10 OFFSET 20;
```
এটি ২০ সারি বাদ দিয়ে **পরবর্তী ১০টি সারি** রিটার্ন করবে।

## How can you modify data using UPDATE statements?
`UPDATE` কমান্ড ব্যবহার করে **বিদ্যমান ডেটা পরিবর্তন** করা যায়।
```sql
UPDATE books SET price = price * 1.1 WHERE published_year < 2000;
```
এটি **২০০০ সালের আগে প্রকাশিত বইগুলোর মূল্য ১০% বৃদ্ধি করবে**।

## What is the significance of the JOIN operation, and how does it work in PostgreSQL?
**JOIN** অপারেশন একাধিক টেবিলের মধ্যে সম্পর্ক স্থাপন করে এবং ডেটা একত্রিত করে। PostgreSQL বিভিন্ন JOIN সমর্থন করে, যেমন:
- **INNER JOIN** – শুধুমাত্র মিলে যাওয়া রেকর্ড রিটার্ন করে।
- **LEFT JOIN** – বাম টেবিলের সব রেকর্ড এবং ডান টেবিলের মিলে যাওয়া রেকর্ড রিটার্ন করে।
- **RIGHT JOIN** – ডান টেবিলের সব রেকর্ড এবং বাম টেবিলের মিলে যাওয়া রেকর্ড রিটার্ন করে।

```sql
SELECT customers.name, orders.order_id
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id;
```
এটি `customers` এবং `orders` টেবিলের মধ্যে সম্পর্ক তৈরি করে এবং নাম ও অর্ডার আইডি রিটার্ন করবে।

## Explain the GROUP BY clause and its role in aggregation operations.
`GROUP BY` ব্যবহার করা হয় **একই ধরণের ডেটা গ্রুপ করতে** এবং **সংক্ষেপিত ফলাফল** পেতে। এটি সাধারণত **Aggregate Functions**-এর সাথে ব্যবহৃত হয়।
```sql
SELECT author, COUNT(*) AS total_books
FROM books
GROUP BY author;
```
এটি **প্রতিটি লেখকের কতগুলো বই আছে তা গণনা করবে**।

## How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
Aggregate ফাংশন ব্যবহার করে **সারিগুলোর উপর গণনা করা যায়**।
- `COUNT()` – মোট সারির সংখ্যা গণনা করে।
- `SUM()` – নির্দিষ্ট কলামের মানগুলোর যোগফল বের করে।
- `AVG()` – গড় মান বের করে।
```sql
SELECT COUNT(*) AS total_orders, SUM(quantity) AS total_books_sold, AVG(price) AS avg_price
FROM orders NATURAL JOIN books;
```
এটি মোট অর্ডারের সংখ্যা, মোট বিক্রিত বইয়ের সংখ্যা এবং বইয়ের গড় মূল্য রিটার্ন করবে।