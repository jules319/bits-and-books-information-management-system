-- View 1
CREATE VIEW total_sales_per_book AS
SELECT
b.isbn,
b.title,
a.name AS author_name,
SUM(coii.quantity) AS total_sales,
SUM(coii.price * coii.quantity) AS total_revenue
FROM
Customer_Order_Invoice_Items coii
JOIN Books b ON coii.isbn_fk = b.isbn
JOIN BookAuthors ba ON b.isbn = ba.isbn
JOIN Authors a ON ba.author_id = a.author_id
GROUP BY
b.isbn;

-- View 2
CREATE VIEW inventory_value_per_warehouse AS
SELECT
w.id AS warehouse_id,
w.address AS warehouse_address,

SUM(wii.quantity * b.price) AS total_inventory_value
FROM
Warehouse_Inventory_Items wii
JOIN Warehouse w ON wii.warehouse_id_fk = w.id
JOIN Books b ON wii.isbn_fk = b.isbn
GROUP BY
w.id;