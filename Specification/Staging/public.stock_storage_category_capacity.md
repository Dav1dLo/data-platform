# stock_storage_category_capacity

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for the `id` column, is highly characteristic of Odoo's ORM pattern.

## Functional process 
This table supports inventory management and warehouse operations, specifically tracking the capacity or stock levels allocated to specific storage categories. It links products and package types to storage categories to define how much inventory can be held or is currently stored within those defined categories.

## Description
One row in this table represents a specific capacity record or stock allocation for a storage category, optionally filtered by product or package type. As a staging table, it serves as a raw, direct landing of the operational database state, intended for subsequent transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| storage_category_id | INTEGER | false | Foreign key to storage category | Links to the definition of the storage area. |
| product_id | INTEGER | true | Foreign key to product | Optional; defines capacity for a specific product. |
| package_type_id | INTEGER | true | Foreign key to package type | Optional; defines capacity for a specific packaging. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |
| quantity | DOUBLE PRECISION | false | Stored quantity or capacity limit | Represents the numeric value of the capacity. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `storage_category_id` → `storage_category.id` (Inferred from naming convention).
    - `product_id` → `product_product.id` (Inferred from standard Odoo naming).
    - `package_type_id` → `stock_package_type.id` (Inferred from standard Odoo naming).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records present are currently active in the source system.
- **Nullability:** `product_id` and `package_type_id` are nullable, implying that some capacity records may be defined at the category level without being restricted to a specific product or package type.
- **Data Integrity:** As a staging table, this may contain duplicates or inconsistent states if the source system allows for overlapping configurations; perform de-duplication if necessary.