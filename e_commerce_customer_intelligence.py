# -*- coding: utf-8 -*-
"""E-Commerce Customer Intelligence.ipynb"""

import pandas as pd
import numpy as np
import urllib.parse
from sqlalchemy import create_engine

# --- 1. Load Datasets ---
customers = pd.read_csv("customers.csv")
suppliers = pd.read_csv("suppliers.csv")
orders = pd.read_csv("orders.csv")
order_items = pd.read_csv("order_items.csv")
products = pd.read_csv("products.csv")
reviews = pd.read_csv("reviews.csv")
shipments = pd.read_csv("shipments.csv")
payments = pd.read_csv("payment.csv")

# --- 2. Initial Data Inspection & Info ---
print("Customers Info:")
customers.info()
print(customers.head())
print(customers.isnull().sum())
print("Duplicates:", customers.duplicated().sum())

print("\nSuppliers Info:")
suppliers.info()
print(suppliers.head())
print(suppliers.isnull().sum())
print("Duplicates:", suppliers.duplicated().sum())

print("\nOrders Info:")
orders.info()
print(orders.head())
print(orders.isnull().sum())
print("Duplicates:", orders.duplicated().sum())

print("\nOrder Items Info:")
order_items.info()
print(order_items.head())
print(order_items.isnull().sum())
print("Duplicates:", order_items.duplicated().sum())

print("\nProducts Info:")
products.info()
print(products.head())
print(products.isnull().sum())
print("Duplicates:", products.duplicated().sum())

print("\nReviews Info:")
reviews.info()
print(reviews.head())
print(reviews.isnull().sum())
print("Duplicates:", reviews.duplicated().sum())

print("\nShipments Info:")
shipments.info()
print(shipments.head())
print(shipments.isnull().sum())
print("Duplicates:", shipments.duplicated().sum())

print("\nPayments Info:")
payments.info()
print(payments.head())
print(payments.isnull().sum())
print("Duplicates:", payments.duplicated().sum())


# Convert Dates
orders["order_date"] = pd.to_datetime(orders["order_date"])
reviews["review_date"] = pd.to_datetime(reviews["review_date"])
shipments["shipment_date"] = pd.to_datetime(shipments["shipment_date"])
shipments["delivery_date"] = pd.to_datetime(shipments["delivery_date"])

# Clean Phone Numbers
suppliers["phone_number"] = suppliers["phone_number"].astype(str).str.replace("-", "", regex=False)
customers["phone_number"] = customers["phone_number"].astype(str).str.replace("-", "", regex=False)

# Check Primary Key Uniqueness
print("\nUnique Customers:", customers["customer_id"].nunique())
print("Total Customers Rows:", len(customers))



USER = 'root'
PASSWORD = urllib.parse.quote_plus('Haritha@678')
HOST = 'localhost'
PORT = '3306'
DATABASE = 'ecommerce_db'

engine = create_engine(f"mysql+pymysql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}")

tables_to_upload = {
    'customers': customers,
    'orders': orders,
    'order_items': order_items,
    'products': products,
    'reviews': reviews,
    'shipments': shipments,
    'suppliers': suppliers,
    'payments': payments
}

for table_name, table_df in tables_to_upload.items():
    print(f"Uploading {table_name}...")
    table_df.to_sql(
        name=table_name,
        con=engine,
        if_exists='replace',
        index=False,
        chunksize=2000
    )
    print(f"-> {table_name} successfully uploaded ({len(table_df)} rows).")

print("\nAll 8 tables uploaded to MySQL successfully!")