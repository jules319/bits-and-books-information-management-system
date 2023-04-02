DROP TABLE IF EXISTS Zips;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Customer_Order;
DROP TABLE IF EXISTS Customer_Order_Invoice_Items;
DROP TABLE IF EXISTS Warehouse;
DROP TABLE IF EXISTS Warehouse_Inventory_Items;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Publishers;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS CompanyOrders;
DROP TABLE IF EXISTS CompanyOrderInvoiceItems;
create table Zips
(
    state      text,
    city       text,
    county     text,
    zip_code integer PRIMARY KEY
);

create table Customer
(
    first_name text,
    last_name text,
    username text PRIMARY KEY,
    password text,
    address text,
    email text,
    zip_code_fk integer,
    FOREIGN KEY (zip_code_fk) REFERENCES Zips (zip_code)
);

create table Customer_Order(
    order_id integer PRIMARY KEY ,
    create_date         text,
    label_create_date   text,
    postal_service      text,
    service_pickup_date text,
    delivery_date       text,
    destination_address text,
    username_fk         text,
    zip_code_fk integer,
    FOREIGN KEY (username_fk) REFERENCES Customer (username),
    FOREIGN KEY (zip_code_fk) REFERENCES Zips (zip_code)
);

create table Customer_Order_Invoice_Items(
    quantity integer,
    price    text,
    isbn_fk integer,
    warehouse_id_fk integer,
    order_id_fk integer,
    FOREIGN KEY (isbn_fk) REFERENCES Books (isbn),
    FOREIGN KEY (warehouse_id_fk) REFERENCES Warehouse (id)
);


create table Warehouse(
    address text,
    id integer PRIMARY KEY,
    zip_code_fk integer,
    FOREIGN KEY (zip_code_fk) REFERENCES Zips (zip_code)
);

create table Warehouse_Inventory_Items(
    quantity integer,
    warehouse_id_fk integer,
    isbn_fk integer,
    FOREIGN KEY (warehouse_id_fk) REFERENCES Warehouse (id),
    FOREIGN KEY (isbn_fk) REFERENCES Books (isbn)
);

create table Books(
    isbn integer PRIMARY KEY,
    title text,
    year integer,
    price text,
    category text,
    publisher text,
    author text,
    publisher_id integer
);

CREATE TABLE Publishers(
    publisher_id integer PRIMARY KEY,
    name text,
    address text,
    zip_code_fk text,
    FOREIGN KEY (zip_code_fk) REFERENCES Zips (zip_code)
);

CREATE TABLE Admin(
    username text PRIMARY KEY,
    first_name text,
    last_name text,
    password text
);

CREATE TABLE CompanyOrders(
    company_purchase_id integer PRIMARY KEY,
    employee_purchaser text,
    created_date text,
    delivery_date text,
    FOREIGN KEY (employee_purchaser) REFERENCES Admin (username)
);

CREATE TABLE CompanyOrderInvoiceItems(
    company_purchase_id integer,
    supplier_id integer,
    isbn integer,
    quantity integer,
    price integer,
    PRIMARY KEY (company_purchase_id, supplier_id, isbn),
    FOREIGN KEY (company_purchase_id) REFERENCES CompanyOrders(company_purchase_id),
    FOREIGN KEY (supplier_id) REFERENCES Publishers(publisher_id),
    FOREIGN KEY (isbn) REFERENCES Books(isbn)
);
