# Create a New SQLite Database
If you have not already, **Download SQLite** at [https://www.sqlite.org/download.html](https://www.sqlite.org/download.html). Make sure to add SQLite to your path for the next step.

Navigate to the project directory where the sql database will be created:

```
cd bits-and-books-information-management-system/sql-database
```

Next, open the SQLite shell at the location and run:

```
sqlite3 bookstore.db
```

then load the schema with:

```
.read schema/schema.sql
```

This will create a new SQLite database with empty tables from the schema in the `sql-database` directory called `bookstore.db`. If the database already exists, it will simply open it and apply the schema.

# Generate Test Data