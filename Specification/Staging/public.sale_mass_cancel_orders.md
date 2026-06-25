# sale_mass_cancel_orders

## Source system
The table likely originates from an Odoo ERP system. The naming convention `sale_mass_cancel_orders` combined with the presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns is characteristic of Odoo's internal ORM audit fields and module-specific wizard or process tables.

## Functional process 
This table supports the sales order management process, specifically the bulk cancellation of sales orders. It likely tracks the execution of a "mass cancel" operation, recording who initiated the action and when, serving as an audit log for batch order processing.

## Description
One row in this table represents a single execution event of a mass cancellation process for sales orders. It acts as a raw staging record capturing the metadata of the cancellation request, including the user who performed the action and the associated timestamps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `sale_mass_cancel_orders_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table tracks the *process* of cancellation rather than the specific orders cancelled; downstream joins to order tables may require a secondary mapping table (often named `sale_mass_cancel_orders_sale_order_rel` in Odoo).
- The `_uid` columns are integers that should be joined against the `res_users` table to retrieve human-readable usernames.