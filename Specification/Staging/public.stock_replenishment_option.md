# stock_replenishment_option

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of PostgreSQL sequences for primary keys, is characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory replenishment process, specifically mapping replenishment strategies or options to specific products and supply routes. It acts as a link between product definitions and the logic governing how stock levels are maintained within the warehouse management system.

## Description
One row in this table represents a specific configuration or option for replenishing a product via a defined supply route. It serves as a raw landing copy of the replenishment configuration settings, capturing the audit trail of who created or modified the record and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `stock_replenishment_option_id_seq`. |
| route_id | INTEGER | true | Foreign key to the supply route | Defines the path the replenishment follows. |
| product_id | INTEGER | true | Foreign key to the product | The item being replenished. |
| replenishment_info_id | INTEGER | true | Foreign key to replenishment details | Links to specific replenishment parameters. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed based on Odoo standards. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `route_id` → `stock_location_route.id` (guess based on Odoo naming patterns).
    - `product_id` → `product_product.id` (guess based on Odoo naming patterns).
    - `replenishment_info_id` → `stock_replenishment_info.id` (guess based on Odoo naming patterns).
    - `create_uid` / `write_uid` → `res_users.id` (standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This is a staging table; it contains raw audit columns (`create_uid`, `write_uid`) that should be mapped to a user dimension in downstream layers.
- There is no explicit soft-delete flag (e.g., `active` column), which is common in Odoo; assume all records are currently active unless otherwise specified by business logic.
- The table structure is highly normalized; expect to join against multiple master data tables to resolve the IDs into human-readable names.