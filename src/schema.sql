DROP TABLE IF EXISTS Zips;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Customer_Order;
DROP TABLE IF EXISTS Customer_Order_Invoice_Items;
DROP TABLE IF EXISTS Warehouse;
DROP TABLE IF EXISTS Warehouse_Inventory_Items;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS BookAuthors;
DROP TABLE IF EXISTS Publishers;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS CompanyOrders;
DROP TABLE IF EXISTS CompanyOrderInvoiceItems;
CREATE TABLE Zips
(
    state      TEXT NOT NULL,
    city       TEXT NOT NULL,
    county     TEXT NOT NULL,
    zip_code   INTEGER PRIMARY KEY
);

CREATE TABLE Customer
(
    username   TEXT PRIMARY KEY,
    email      TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name  TEXT NOT NULL,
    password   TEXT NOT NULL
);

CREATE TABLE Customer_Order
(
    order_id             INTEGER PRIMARY KEY,
    create_date          TEXT NOT NULL,
    label_create_date    TEXT,
    service_pickup_date  TEXT,
    delivery_date        TEXT,
    destination_address  TEXT NOT NULL,
    username_fk          TEXT,
    zip_code_fk          INTEGER,
    FOREIGN KEY (username_fk) REFERENCES Customer (username),
    FOREIGN KEY (zip_code_fk) REFERENCES Zips (zip_code)
);

CREATE TABLE Customer_Order_Invoice_Items
(
    quantity        INTEGER NOT NULL,
    price           REAL NOT NULL,
    isbn_fk         INTEGER,
    warehouse_id_fk INTEGER,
    order_id_fk     INTEGER,
    FOREIGN KEY (isbn_fk) REFERENCES Books (isbn),
    FOREIGN KEY (warehouse_id_fk) REFERENCES Warehouse (id),
    FOREIGN KEY (order_id_fk) REFERENCES Customer_Order (order_id)
);

CREATE TABLE Warehouse
(
    address    TEXT NOT NULL,
    id         INTEGER PRIMARY KEY,
    zip_code_fk INTEGER,
    FOREIGN KEY (zip_code_fk) REFERENCES Zips (zip_code)
);

CREATE TABLE Warehouse_Inventory_Items
(
    quantity        INTEGER NOT NULL,
    warehouse_id_fk INTEGER,
    isbn_fk         INTEGER,
    FOREIGN KEY (warehouse_id_fk) REFERENCES Warehouse (id),
    FOREIGN KEY (isbn_fk) REFERENCES Books (isbn)
);

CREATE TABLE Books
(
    isbn          TEXT PRIMARY KEY,
    title         TEXT NOT NULL,
    year          INTEGER,
    price         REAL NOT NULL,
    category      TEXT,
    publisher     TEXT NOT NULL,
    publisher_id  INTEGER,
    FOREIGN KEY (publisher_id) REFERENCES Publishers (publisher_id)
);

CREATE TABLE Authors
(
    author_id   INTEGER PRIMARY KEY,
    name  TEXT NOT NULL
);

CREATE TABLE BookAuthors
(
    isbn       INTEGER,
    author_id  INTEGER,
    PRIMARY KEY (isbn, author_id),
    FOREIGN KEY (isbn) REFERENCES Books (isbn),
    FOREIGN KEY (author_id) REFERENCES Authors (author_id)
);

CREATE TABLE Publishers
(
    publisher_id INTEGER PRIMARY KEY,
    name         TEXT NOT NULL,
    zip_code_fk  INTEGER,
    FOREIGN KEY (zip_code_fk) REFERENCES Zips (zip_code)
);

CREATE TABLE Admin
(
    work_id TEXT PRIMARY KEY,
    email TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name  TEXT NOT NULL,
    password   TEXT NOT NULL
);

CREATE TABLE CompanyOrders
(
    company_purchase_id INTEGER PRIMARY KEY,
    employee_purchaser  TEXT,
    created_date        TEXT NOT NULL,
    delivery_date       TEXT,
    FOREIGN KEY (employee_purchaser) REFERENCES Admin (work_id)
);

CREATE TABLE CompanyOrderInvoiceItems(
    company_purchase_id integer,
    supplier_id integer,
    isbn integer,
    quantity            INTEGER NOT NULL,
    price               REAL NOT NULL,
    PRIMARY KEY (company_purchase_id, supplier_id, isbn),
    FOREIGN KEY (company_purchase_id) REFERENCES CompanyOrders(company_purchase_id),
    FOREIGN KEY (supplier_id) REFERENCES Publishers(publisher_id),
    FOREIGN KEY (isbn) REFERENCES Books(isbn)
);
