# report_stock_quantity

## Source system
This table likely originates from an Odoo ERP system. The naming convention of `product_tmpl_id` (product template) and the structure of stock reporting tables are highly characteristic of Odoo's inventory management module.

## Functional process 
This table supports inventory valuation and stock level reporting. It tracks the quantity of products available across different warehouses and companies at specific points in time, facilitating supply chain analysis and financial stock reporting.

## Description
One row in this table represents a snapshot of the stock quantity for a specific product template at a given location or warehouse on a specific date. As a staging table, it serves as a raw, landed copy of the source system's stock report, intended for subsequent transformation into inventory fact tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely auto-incrementing ID from the source. |
| product_id | INTEGER | true | Product variant identifier | Links to the specific product variant. |
| product_tmpl_id | INTEGER | true | Product template identifier | Links to the base product definition. |
| state | TEXT | true | Stock state | Indicates the status of the stock (e.g., available, reserved, incoming). |
| date | DATE | true | Snapshot date | The date for which the stock quantity is recorded. |
| product_qty | NUMERIC | true | Quantity on hand | The numerical count of the product. |
| company_id | INTEGER | true | Company identifier | The organizational entity owning the stock. |
| warehouse_id | INTEGER | true | Warehouse identifier | The physical or logical location of the stock. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product.id` (Guess: links to product variant definition).
    - `product_tmpl_id` → `product_template.id` (Guess: links to product master data).
    - `warehouse_id` → `stock_warehouse.id` (Guess: links to warehouse location master data).
    - `company_id` → `res_company.id` (Guess: links to organizational entity).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `id` column is marked as nullable, which is unusual for a primary key; verify if this table contains duplicates or incomplete records.
- This table represents a snapshot; ensure queries filter by `date` to avoid aggregating historical duplicates.
- No explicit timezone information is provided for the `date` column; assume it represents the business date in the local timezone of the `company_id`.
- The `product_qty` column is `NUMERIC`, which may include fractional values depending on the unit of measure (e.g., weight vs. discrete units).