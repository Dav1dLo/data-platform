# stock_replenishment_info

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based default for the `id` column, is characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory replenishment process, specifically tracking the metadata and audit trail for automated stock reordering rules. It links replenishment configurations (via `orderpoint_id`) to the users who created or modified these rules, facilitating inventory management and supply chain operations.

## Description
One row in this table represents a specific audit or administrative record associated with a stock order point (replenishment rule). It serves as a raw landing copy of the internal tracking metadata for replenishment configurations within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a standard PostgreSQL sequence. |
| orderpoint_id | INTEGER | true | Foreign key to the replenishment rule | Links to the parent stock order point definition. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| create_date | TIMESTAMP | true | Creation timestamp | Likely in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `orderpoint_id` → `stock_warehouse_orderpoint.id` (Inferred based on Odoo naming conventions for replenishment rules).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit metadata; it does not contain the actual replenishment logic or stock levels, which reside in the referenced `orderpoint` table.
- There is no explicit soft-delete flag; however, Odoo often uses `active` boolean columns in other tables to manage logical deletion, which is absent here.
- The `_uid` columns refer to internal system user IDs and will require a join to the `res_users` table to resolve to human-readable names.