import os
import time
import pandas as pd
from google.cloud import bigquery

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "service_account.json"
client = bigquery.Client()

query_sql = """
WITH
fact_table AS (
    SELECT
        fos.fk_product,
        fos.fk_customer,
        fos.fk_locales,
        fos.fk_sales_order,
        fos.order_date,
        fos.order_product_qty
    FROM `dbt-project-1-431420.adw_marts.fct_ordersales` fos
),

dim_product AS (
    SELECT
        sk_product,
        product_category_name,
        product_subcategory_name,
        product_name
    FROM `dbt-project-1-431420.adw_marts.dim_products`
),

dim_locales AS (
    SELECT
        sk_locales,
        state_province_name,
        country_region_name,
        territory_name
    FROM `dbt-project-1-431420.adw_marts.dim_locales`
),

dim_customer AS (
    SELECT
        sk_customer,
        store_id,
        store_name
    FROM `dbt-project-1-431420.adw_marts.dim_customer`
)

SELECT
    fos.fk_sales_order AS order_id,
    fos.order_date AS order_data,
    dc.store_name,
    dp.product_category_name,
    dp.product_subcategory_name,
    dp.product_name,
    fos.order_product_qty AS order_qty,
    dl.state_province_name,
    dl.country_region_name,
    dl.territory_name
FROM fact_table fos
LEFT JOIN dim_product dp
    ON fos.fk_product = dp.sk_product
LEFT JOIN dim_locales dl
    ON fos.fk_locales = dl.sk_locales
LEFT JOIN dim_customer dc
    ON fos.fk_customer = dc.sk_customer;
"""

query_job = client.query(query_sql)

while query_job.state != 'DONE':
    query_job.reload()
    time.sleep(3)

if query_job.state == 'DONE':
    df = query_job.to_dataframe()
    path = 'data_science/order_sales_data.csv'
    df.to_csv(path, index=False)
    print(f"Data saved to {path}")
else:
    print(query_job.result())
