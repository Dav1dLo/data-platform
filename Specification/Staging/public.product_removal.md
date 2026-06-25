# product_removal

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `JSONB` for content fields and `nextval` sequences for primary keys, is highly characteristic of the Odoo framework's database schema.

## Functional process 
This table supports inventory management and warehouse operations, specifically tracking the removal of products from stock. The `method` column likely stores the strategy or logic used for product removal (e.g., FIFO, LIFO, or FEFO), while the `name` column likely contains the descriptive identifier or label for the removal strategy.

## Description
One row in this table represents a single product removal strategy or configuration record within the inventory system. It serves as a raw landed copy of the source system's configuration data, capturing the metadata and methods associated with how products are removed from inventory locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | ID of the user who created the record | References the users table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the users table. |
| name | JSONB | false | Name or label of the removal strategy | Likely contains multi-language strings. |
| method | JSONB | false | The removal method logic or configuration | Likely contains serialized strategy parameters. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern)
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` and `method` columns are `JSONB`; queries will require PostgreSQL JSON operators (e.g., `->>` or `#>`) to extract specific values.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This is a staging table; it may contain technical metadata or transient states that are not present in the final business-logic layer.
- No explicit soft-delete flag is present; assume records are hard-deleted if they disappear from the source.