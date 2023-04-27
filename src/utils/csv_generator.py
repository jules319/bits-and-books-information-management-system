import pandas as pd

# Replace 'your_excel_file.xlsx' with the name of your Excel file
EXCEL_FILE = 'src/data/proj-data.xlsx'

# Load the Excel file
xlsx = pd.read_excel(EXCEL_FILE, sheet_name=None, engine='openpyxl')

# Export each sheet into a separate CSV file
for sheet_name, sheet_data in xlsx.items():
    print(f"Working on: {sheet_name}")
    sheet_data.to_csv(f'/src/data/{sheet_name}.csv', index=False)
