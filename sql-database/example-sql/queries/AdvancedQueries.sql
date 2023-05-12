-- a. Provide a list of customer names, along with the total dollar amount each customer has spent.
SELECT c.first_name, c.last_name, SUM(coii.price * coii.quantity) AS total_spent
FROM Customer c
JOIN Customer_Order co ON c.username = co.username_fk
JOIN Customer_Order_Invoice_Items coii ON co.order_id = coii.order_id_fk
GROUP BY c.username;

-- b. Provide a list of customer names and e-mail addresses for customers who have spent more than the
-- average customer.
WITH customer_spending AS (
  SELECT c.username, c.first_name, c.last_name, c.email, SUM(coii.price * coii.quantity) AS total_spent
  FROM Customer c
  JOIN Customer_Order co ON c.username = co.username_fk
  JOIN Customer_Order_Invoice_Items coii ON co.order_id = coii.order_id_fk
  GROUP BY c.username
),
average_spending AS (
  SELECT AVG(total_spent) AS average_spent
  FROM customer_spending
)
SELECT cs.first_name, cs.last_name, cs.email
FROM customer_spending cs
WHERE cs.total_spent > (SELECT average_spent FROM average_spending);

-- c. Provide a list of the titles in the database and associated total copies sold to customers, sorted from the
-- title that has sold the most individual copies to the title that has sold the least.
SELECT b.title, SUM(coii.quantity) AS total_copies_sold
FROM Books b
JOIN Customer_Order_Invoice_Items coii ON b.isbn = coii.isbn_fk
GROUP BY b.isbn
ORDER BY total_copies_sold DESC;

-- d. Provide a list of the titles in the database and associated dollar totals for copies sold to customers,
-- sorted from the title that has sold the highest dollar amount to the title that has sold the smallest.
SELECT b.title, SUM(coii.price * coii.quantity) AS total_dollar_amount
FROM Books b
JOIN Customer_Order_Invoice_Items coii ON b.isbn = coii.isbn_fk
GROUP BY b.isbn
ORDER BY total_dollar_amount DESC;

-- e. Find the most popular author in the database (i.e. the one who has sold the most books)
SELECT a.name, SUM(coii.quantity) AS total_books_sold
FROM Authors a
JOIN BookAuthors ba ON a.author_id = ba.author_id
JOIN Books b ON ba.isbn = b.isbn
JOIN Customer_Order_Invoice_Items coii ON b.isbn = coii.isbn_fk
GROUP BY a.author_id
ORDER BY total_books_sold DESC
LIMIT 1;

-- f. Find the most profitable author in the database for this store (i.e. the one who has brought in the most
-- money)
SELECT a.name, SUM(coii.price * coii.quantity) AS total_revenue
FROM Authors a
JOIN BookAuthors ba ON a.author_id = ba.author_id
JOIN Books b ON ba.isbn = b.isbn
JOIN Customer_Order_Invoice_Items coii ON b.isbn = coii.isbn_fk
GROUP BY a.author_id
ORDER BY total_revenue DESC
LIMIT 1;

-- g. Provide a list of customer information for customers who purchased anything written by the most
-- profitable author in the database.
WITH most_profitable_author AS (
  SELECT a.author_id, SUM(coii.price * coii.quantity) AS total_revenue
  FROM Authors a
  JOIN BookAuthors ba ON a.author_id = ba.author_id
  JOIN Books b ON ba.isbn = b.isbn
  JOIN Customer_Order_Invoice_Items coii ON b.isbn = coii.isbn_fk
  GROUP BY a.author_id
  ORDER BY total_revenue DESC
  LIMIT 1
)
SELECT DISTINCT c.username, c.first_name, c.last_name, c.email
FROM Customer c
JOIN Customer_Order co ON c.username = co.username_fk
JOIN Customer_Order_Invoice_Items coii ON co.order_id = coii.order_id_fk
JOIN Books b ON coii.isbn_fk = b.isbn
JOIN BookAuthors ba ON b.isbn = ba.isbn
JOIN Authors a ON ba.author_id = a.author_id
WHERE a.author_id = (SELECT author_id FROM most_profitable_author);

-- h. Provide the list of authors who wrote the books purchased by the customers who have spent more than
-- the average customer.
WITH customer_spending AS (
  SELECT c.username, SUM(coii.price * coii.quantity) AS total_spent
  FROM Customer c
  JOIN Customer_Order co ON c.username = co.username_fk
  JOIN Customer_Order_Invoice_Items coii ON co.order_id = coii.order_id_fk
  GROUP BY c.username
),
average_spending AS (
  SELECT AVG(total_spent) AS average_spent
  FROM customer_spending
),
above_average_customers AS (
  SELECT cs.username
  FROM customer_spending cs
  WHERE cs.total_spent > (SELECT average_spent FROM average_spending)
)
SELECT DISTINCT a.name
FROM Authors a
JOIN BookAuthors ba ON a.author_id = ba.author_id
JOIN Books b ON ba.isbn = b.isbn
JOIN Customer_Order_Invoice_Items coii ON b.isbn = coii.isbn_fk
JOIN Customer_Order co ON coii.order_id_fk = co.order_id
WHERE co.username_fk IN (SELECT username FROM above_average_customers);
