BEGIN TRANSACTION;


INSERT INTO Customer (username, email, first_name, last_name, password)
VALUES ('jdoe', 'jdoe@example.com', 'John', 'Doe', 'password123');

INSERT INTO Customer_Order (order_id, create_date, destination_address, username_fk, zip_code_fk)
VALUES (1000, '2023-04-27', '123 Main St, City Name, ST', 'jdoe', 12345);

INSERT INTO Customer_Order_Invoice_Items (quantity, price, isbn_fk, warehouse_id_fk, order_id_fk)
VALUES (2, 19.99, '978-1-23456-789-0', 1, 1);


COMMIT;



BEGIN TRANSACTION;


UPDATE Customer_Order
SET delivery_date = '2023-05-05', destination_address = '789 New St, City Name, ST'
WHERE order_id = 1;


COMMIT;



BEGIN TRANSACTION;


INSERT INTO Books (isbn, title, year, price, category, publisher, publisher_id)
VALUES ('978-1-23456-789-1', 'New Book Title', 2023, 24.99, 'Fiction', 'New Publisher', 2);

INSERT INTO Warehouse_Inventory_Items (quantity, warehouse_id_fk, isbn_fk)
VALUES (10, 1, '978-1-23456-789-1');


COMMIT;