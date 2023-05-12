import sqlite3
from typing import List, Tuple
import pandas as pd
import random
import datetime

DATABASE = 'bookstore.sqlite'
EXCEL_FILE = 'src/data/proj-data.xlsx'


def connect_to_database(database_path: str) -> Tuple[sqlite3.Connection, sqlite3.Cursor]:
    conn = sqlite3.connect(database_path)
    c = conn.cursor()
    c.execute('PRAGMA foreign_keys = ON')
    return conn, c

def load_excel_data_into_tables(conn: sqlite3.Connection, excel_file_path: str, table_order: List[str]) -> pd.DataFrame:
    sheets = pd.read_excel(excel_file_path, sheet_name=None, engine='openpyxl')
    for table in table_order:
        if table in sheets:
            data = sheets[table]
            if table == "Zips":
                data = data.drop_duplicates(subset=['zip_code'])  # Remove duplicates based on the 'zip_code' column
            data.to_sql(table, conn, if_exists='append', index=False)
            print(f"Inserted data into {table}.")
    return sheets

def populate_warehouse_inventory(c: sqlite3.Cursor, books: List[Tuple[str, float]]) -> None:
    # Get the number of warehouses
    c.execute('SELECT COUNT(*) FROM Warehouse')
    num_warehouses = c.fetchone()[0]

    # Insert random book quantities and prices for each warehouse
    for warehouse_id in range(1, num_warehouses + 1):
        # Generate a random number of books between 100 and 200 for the warehouse
        num_books = random.randint(100, 200)

        seen_tuples = set()
        # Select random books and assign random quantities
        for _ in range(num_books):
            # Select a random book and its price
            isbn, _ = random.choice(books)
            if (isbn, warehouse_id) in seen_tuples:
                continue
            else:
                seen_tuples.add((isbn, warehouse_id))
            # Generate a random quantity between 1 and 10
            quantity = random.randint(1, 10)

            # Insert the data into the Warehouse_Inventory_Items table
            c.execute('INSERT INTO Warehouse_Inventory_Items (quantity, warehouse_id_fk, isbn_fk) VALUES (?, ?, ?)',
                    (quantity, warehouse_id, isbn))

def populate_customer_orders(c: sqlite3.Cursor, addresses: List[str], num_orders: int, usernames: List[str], zip_codes: List[str]) -> None:
    # Generate customer orders
    for order_id in range(1, num_orders + 1):
        # Generate random dates within the specified range
        create_date = datetime.date(2023, 3, 1) + datetime.timedelta(days=random.randint(0, 30))
        label_create_date = create_date + datetime.timedelta(days=random.randint(0, 3))
        service_pickup_date = label_create_date + datetime.timedelta(days=random.randint(0, 3))
        delivery_date = service_pickup_date + datetime.timedelta(days=random.randint(1, 5))

        # Randomly select an address, username, and zip code
        destination_address = random.choice(addresses)
        username = random.choice(usernames)
        zip_code = random.choice(zip_codes)

        # Insert the data into the Customer_Order table
        c.execute("""
            INSERT INTO Customer_Order (order_id, create_date, label_create_date, service_pickup_date, delivery_date, destination_address, username_fk, zip_code_fk)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """, (order_id, create_date, label_create_date, service_pickup_date, delivery_date, destination_address, username, zip_code))

def populate_customer_order_invoices(c: sqlite3.Cursor, num_orders: int, books: List[Tuple[str, float]], warehouse_ids: List[int]) -> None:
    # Generate CustomerOrderInvoice records
    for order_id in range(1, num_orders + 1):
        # Randomly select the number of items for this order (between 1 and 3)
        num_items = random.randint(1, 3)
        seen_tuples = set()
        for _ in range(num_items):
            # Generate a random quantity between 1 and 2
            quantity = random.randint(1, 2)

            # Select a random book and its price
            isbn, price = random.choice(books)
            # Select a random warehouse id
            warehouse_id = random.choice(warehouse_ids)
            if (isbn, price, warehouse_id) in seen_tuples:
                continue
            else:
                seen_tuples.add((isbn, price, warehouse_id))

            # Insert the data into the Customer_Order_Invoice_Items table
            c.execute("""
                INSERT INTO Customer_Order_Invoice_Items (quantity, price, isbn_fk, warehouse_id_fk, order_id_fk)
                VALUES (?, ?, ?, ?, ?)
            """, (quantity, price, isbn, warehouse_id, order_id))

def populate_company_orders(c: sqlite3.Cursor, num_company_purchases: int, admin_usernames: List[str]) -> None:
    # Generate CompanyOrders records
    for company_purchase_id in range(1, num_company_purchases + 1):
        # Randomly select an admin username
        employee_purchaser = random.choice(admin_usernames)

        # Generate a random created_date between March 1st, 2023 and April 1st, 2023
        create_date = datetime.date(2023, 3, 1) + datetime.timedelta(days=random.randint(0, 30))

        # Generate a random delivery_date between 3 and 7 days after the created_date
        delivery_date = create_date + datetime.timedelta(days=random.randint(3, 7))

        # Insert the data into the CompanyOrders table
        c.execute("""
            INSERT INTO CompanyOrders (company_purchase_id, employee_purchaser, created_date, delivery_date)
            VALUES (?, ?, ?, ?)
        """, (company_purchase_id, employee_purchaser, create_date, delivery_date))

def populate_company_order_invoices(c: sqlite3.Cursor, books: List[Tuple[str, float]], num_company_purchases: int, publisher_ids: List[int]) -> None:
    # Generate CompanyOrderInvoiceItems records
    for company_purchase_id in range(1, num_company_purchases + 1):
        # Randomly select the number of invoice items for this company purchase (1 to 3)
        num_invoice_items = random.randint(1, 3)

        for _ in range(num_invoice_items):
            # Randomly select a publisher_id
            supplier_id = random.choice(publisher_ids)

            # Select a random book (isbn and price) from the Books table
            isbn, price = random.choice(books)

            # Generate a random quantity between 5 and 15
            quantity = random.randint(5, 15)

            # Insert the data into the CompanyOrderInvoiceItems table
            c.execute("""
                INSERT INTO CompanyOrderInvoiceItems (company_purchase_id, supplier_id, isbn, quantity, price)
                VALUES (?, ?, ?, ?, ?)
            """, (company_purchase_id, supplier_id, isbn, quantity, price))


def main():
    conn, c = connect_to_database(DATABASE)
    table_order = [
        'Zips',
        'Customer',
        'Admin',
        'Authors',
        'Publishers',
        'Books',
        'BookAuthors',
        'Warehouse'
    ]
    num_orders = 100

    sheets = load_excel_data_into_tables(conn, EXCEL_FILE, table_order)
    # Get the list of books
    c.execute('SELECT isbn, price FROM Books')
    books = c.fetchall()

    # Get the list of usernames
    c.execute('SELECT username FROM Customer')
    usernames = [row[0] for row in c.fetchall()]

    # Get the list of zip codes
    c.execute('SELECT zip_code FROM Zips')
    zip_codes = [row[0] for row in c.fetchall()]

    # Get the list of warehouse ids
    c.execute('SELECT id FROM Warehouse')
    warehouse_ids = [row[0] for row in c.fetchall()]

    # Get the list of admin usernames
    c.execute('SELECT work_id FROM Admin')
    admin_usernames = [row[0] for row in c.fetchall()]

    # Get the list of publisher ids
    c.execute('SELECT publisher_id FROM Publishers')
    publisher_ids = [row[0] for row in c.fetchall()]

    # Read the addresses from the Excel file
    addresses = sheets["Addresses"]["address"].tolist()

    populate_warehouse_inventory(c, books)
    populate_customer_orders(c, addresses, num_orders, usernames, zip_codes)
    populate_customer_order_invoices(c, num_orders, books, warehouse_ids)
    num_company_purchases = 100
    populate_company_orders(c, num_company_purchases, admin_usernames)
    populate_company_order_invoices(c, books, num_company_purchases, publisher_ids)

    conn.commit()
    conn.close()


if __name__ == '__main__':
    main()
