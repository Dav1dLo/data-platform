# stock_backorder_confirmation

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based default for the `id` column, is characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory management and order fulfillment process, specifically handling the logic for backordered stock transfers. It tracks the configuration or confirmation state of backorders, determining whether pending transfers should be displayed or processed during the fulfillment workflow.

## Description
One row in this table represents a specific instance of a backorder confirmation event or configuration record. It serves as a raw landed staging entity, capturing the metadata and user-defined settings associated with backorder processing within the inventory module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.stock_backorder_confirmation_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| show_transfers | BOOLEAN | true | Flag to display backordered transfers | Determines UI/process visibility for pending stock moves. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table contains audit fields (`create_uid`, `write_uid`) which are useful for tracking data lineage but may require joining against a user dimension table for human-readable names.
- There is no explicit soft-delete flag; assume records are either active or represent historical snapshots of configuration events.