# Bits & Books Information Management System

This repository contains the source code and documentation for the Bits & Books Information Management System, a project developed as part of a class assignment. The system aims to support the inventory and sales operations of Bits & Books, a fictional book store.


## Getting Started

### Clone the Repository
To get started, clone this repository to your local machine:

```
git clone https://github.com/your-username/bits-and-books-information-management-system.git
```

### Setting up the virtual environment
In order to run the python test data generater scripts, a few python packages need to be installed.

1. Install Poetry if you have not already using the instructions at [https://python-poetry.org/docs/#installation](https://python-poetry.org/docs/#installation).

2. Navigate into the root directory:
```bash
cd bits-and-books-information-management-system/
```

3. Set up a new virtual environment and install dependencies:
```bash
poetry install
```
Please note, the poetry configuration parameter virtualenvs in-project is set to true for this project.

4. Activate the virtual environment:
```bash
poetry shell
```

Now, you are inside the virtual environment with all the necessary packages installed, and you can run the application.

If you prefer not to use Poetry, you can use pip, the Python package installer. A `requirements.txt` file is provided for this purpose.


## SQL Database
The SQL database and related files can be found in the `sql-database` folder. This folder contains:
- `data-loader-utils/`: A folder containing the data files to be loaded into the database.
- `sql_create.sql`: A text file containing all of the scripts needed to create the database schema on an empty database, including indexes and views.
- `example-sql/`: A folder containing example queries, indexes, insert/delete statements, transactions and views

To recreate the database from scratch, follow the instructions in the `data_files/README.txt` file.
