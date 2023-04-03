import pandas as pd

# Replace 'your_excel_file.xlsx' with the name of your Excel file
excel_file = '../src/data/proj-data.xls'

# Load the Excel file
xls = pd.read_excel(excel_file, sheet_name=None, engine='xlrd')

# Export each sheet into a separate CSV file
for sheet_name, sheet_data in xls.items():
    print(f"Working on: {sheet_name}")
    sheet_data.to_csv(f'../src/data/{sheet_name}.csv', index=False)
