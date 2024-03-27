"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv
import os

file = ['employees_data.csv', 'customers_data.csv', 'orders_data.csv']
sql_bd = ['employees', 'customers', 'orders']


def add_sql_bd(file, b):
    conn = psycopg2.connect(
        host='localhost',
        database='north',
        user='postgres',
        password=1810
    )
    cur = conn.cursor()
    for i in range(len(file)):
        with open(os.path.join('north_data', file[i]), 'r') as file_csv:
            heders = next(file_csv)
            filecsv = csv.reader(file_csv)
            print(heders)
            for rot in filecsv:
                values = '%s, ' * len(rot)
                cur.execute(f"INSERT INTO {b[i]} VALUES ({values[:-2]})", rot)
            conn.commit()
    cur.close()
    conn.close()


if __name__ == '__main__':
    add_sql_bd(file, sql_bd)
