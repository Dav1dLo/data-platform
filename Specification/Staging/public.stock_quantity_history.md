# stock_quantity_history

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for the primary key, is characteristic of the Odoo ORM framework.

## Functional process 
This table supports inventory management and audit tracking. It records historical snapshots or changes in stock quantities, likely tracking who performed the update (`create_uid`, `write_uid`) and when the inventory state was captured (`inventory_datetime`).

## Description
One row in this table represents a single historical record or audit entry for a stock quantity adjustment. It serves as a raw landing copy of inventory history, capturing the state of stock levels at a specific point in time and the associated metadata for the record's lifecycle.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-incrementing values. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the system's internal user table. |
| inventory_datetime | TIMESTAMP | true | The effective date/time of the stock quantity | Represents the point in time the inventory state refers to. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely in UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `create_uid` and `write_uid` columns likely reference an external `res_users` table not present in this schema.
- Timestamps (`create_date`, `write_date`, `inventory_datetime`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table appears to be an audit or history log; check for duplicate `inventory_datetime` entries if multiple adjustments occur for the same item.
- No explicit soft-delete flag is present; assume records are immutable history logs.