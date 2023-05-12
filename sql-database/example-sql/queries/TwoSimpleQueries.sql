-- a. Find the titles of all books by Pratchett that cost less than $10
SELECT b.title
FROM Books b
JOIN BookAuthors ba ON b.isbn = ba.isbn
JOIN Authors a ON ba.author_id = a.author_id
WHERE a.name LIKE '%Pratchett%' AND b.price < 10;

-- b. Give all the titles and their dates of purchase made by a single customer (you choose how to designate
-- the customer)
SELECT DISTINCT b.title, co.create_date
FROM Books b
JOIN Customer_Order_Invoice_Items coii ON b.isbn = coii.isbn_fk
JOIN Customer_Order co ON coii.order_id_fk = co.order_id
WHERE co.username_fk = 'atansly3';

-- c. Find the titles and ISBNs for all books with less than 5 copies in stock
SELECT b.title, b.isbn
FROM Books b
JOIN Warehouse_Inventory_Items wii ON b.isbn = wii.isbn_fk
GROUP BY b.isbn
HAVING SUM(wii.quantity) < 5;

-- d. Give all the customers who purchased a book by Pratchett and the titles of Pratchett books they
-- purchased
SELECT c.username, b.title
FROM Customer c
JOIN Customer_Order co ON c.username = co.username_fk
JOIN Customer_Order_Invoice_Items coii ON co.order_id = coii.order_id_fk
JOIN Books b ON coii.isbn_fk = b.isbn
JOIN BookAuthors ba ON b.isbn = ba.isbn
JOIN Authors a ON ba.author_id = a.author_id
WHERE a.name LIKE '%Pratchett%';

-- e. Find the total number of books purchased by a single customer (you choose how to designate the
-- customer)
SELECT co.username_fk, COUNT(*) as total_books_purchased
FROM Customer_Order co
JOIN Customer_Order_Invoice_Items coii ON co.order_id = coii.order_id_fk
WHERE co.username_fk = 'atansly3'
GROUP BY co.username_fk;

-- f. Find the customer who has purchased the most books and the total number of books they have
-- purchased
SELECT co.username_fk, COUNT(*) as total_books_purchased
FROM Customer_Order co
JOIN Customer_Order_Invoice_Items coii ON co.order_id = coii.order_id_fk
GROUP BY co.username_fk
ORDER BY total_books_purchased DESC
LIMIT 1;
