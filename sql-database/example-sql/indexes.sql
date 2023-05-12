CREATE INDEX idx_customer_username ON Customer(username);

CREATE INDEX idx_customer_order_create_date ON Customer_Order(create_date);

CREATE INDEX idx_books_isbn ON Books(isbn);

CREATE INDEX idx_warehouse_inventory_items_warehouse_id_fk ON Warehouse_Inventory_Items(warehouse_id_fk);

CREATE INDEX idx_customer_order_invoice_items_order_id_fk ON Customer_Order_Invoice_Items(order_id_fk);
