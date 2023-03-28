create table Zips
(
    State      text,
    City       text,
    Zip_Code integer PRIMARY KEY
);

create table Customer
(
    First_Name text,
    Last_Name text,
    Username text PRIMARY KEY,
    Password text,
    Address text,
    Email text,
    Zip_Code_fk integer,
    FOREIGN KEY (Zip_Code_fk) REFERENCES Zips (Zip_Code)
);

create table Customer_Order(
    Order_ID integer PRIMARY KEY ,
    Create_Date         text,
    Label_Create_Date   text,
    Postal_Service      text,
    Service_Pickup_Date text,
    Delivery_Date       text,
    Destination_Address text,
    Username_fk         text,
    Zip_Code_fk integer,
    FOREIGN KEY (Username_fk) REFERENCES Customer (Username),
    FOREIGN KEY (Zip_Code_fk) REFERENCES Zips (Zip_Code)
);

create table Customer_Order_Invoice_Items(
    Quantity integer,
    Price    text,
    ISBN_fk integer,
    Warehouse_ID_fk integer,
    Order_ID_fk integer,
    FOREIGN KEY (ISBN_fk) REFERENCES Books (ISBN),
    FOREIGN KEY (Warehouse_ID_fk) REFERENCES Warehouse (ID)
);


create table Warehouse(
    Address text,
    ID integer PRIMARY KEY,
    Zip_Code_fk integer,
    FOREIGN KEY (Zip_Code_fk) REFERENCES Zips (Zip_Code)
);

create table Warehouse_Inventory_Items(
    Quantity integer,
    Warehouse_ID_fk integer,
    ISBN_fk integer,
    FOREIGN KEY (Warehouse_ID_fk) REFERENCES Warehouse (ID),
    FOREIGN KEY (ISBN_fk) REFERENCES Books (ISBN)
);

create table Books(
    ISBN integer PRIMARY KEY,
    Title text,
    Year integer,
    Price text,
    Category text,
    Publisher text,
    Author text,
    Publisher_ID integer
);

CREATE TABLE Publishers(
    Publisher_id integer PRIMARY KEY,
    Name text,
    Address text,
    Zip_Code_fk text,
    FOREIGN KEY (Zip_Code_fk) REFERENCES Zips (Zip_Code)
);

CREATE TABLE Admin(
    Username text PRIMARY KEY,
    First_Name text,
    Last_Name text,
    Password text
);

CREATE TABLE CompanyOrders(
    Company_Purchase_id integer PRIMARY KEY,
    Employee_Purchaser text,
    Created_Date text,
    Delivery_Date text,
    FOREIGN KEY (Employee_Purchaser) REFERENCES Admin (Username)
);

CREATE TABLE CompanyOrderInvoiceItems(
    Company_Purchase_id integer PRIMARY KEY,
    Supplier_id integer PRIMARY KEY,
    ISBN integer PRIMARY KEY,
    Quantity integer,
    Price integer,
    FOREIGN KEY (Company_Purchase_id) REFERENCES CompanyOrders(Company_Purchase_id),
    FOREIGN KEY (Supplier_id) REFERENCES Publishers(Publisher_id),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);
