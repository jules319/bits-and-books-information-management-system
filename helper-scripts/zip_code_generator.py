import sqlite3
import random

# Connect to the SQLite database
conn = sqlite3.connect('../3241_project/bookstore.sqlite')
cursor = conn.cursor()

# Query all zip codes from the 'zips' table
cursor.execute('SELECT zip_code FROM Zips')
zip_codes = cursor.fetchall()

# Close the database connection
conn.close()

# Check if there are enough zip codes
if len(zip_codes) < 40:
    print("There are not enough zip codes in the database.")
else:
    # Randomly select 40 zip codes
    random_zip_codes = random.sample(zip_codes, 40)

    # Print the 40 random zip codes
    for zip_code in random_zip_codes:
        print(zip_code[0])