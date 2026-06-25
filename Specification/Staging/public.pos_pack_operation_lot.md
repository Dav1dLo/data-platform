# pos_pack_operation_lot

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `pos_pack_operation_lot` (Point of Sale pack operation lot), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the Point of Sale (POS) inventory tracking process, specifically managing the association between sold items and their tracked lot or serial numbers. It records which specific lot or serial number was assigned to a particular line item within a POS order, facilitating traceability for serialized or batch-tracked products.

## Description
One row in this table represents a single assignment of a lot or serial number to a specific POS order line. It serves as a raw landing copy of the Odoo `pos.pack.operation.lot` model, capturing the link between inventory batches and customer transactions at the grain of one row per lot/serial number per order line.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_pack_operation_lot_id_seq`. |
| pos_order_line_id | INTEGER | true | Foreign key to the POS order line | Links to the specific item sold. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| lot_name | VARCHAR | true | Lot or serial number identifier | The human-readable batch or serial code. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `pos_order_line_id` → `pos_order_line.id` (Inferred from naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitivity:** While this table contains no direct PII, it tracks inventory movement which may be sensitive in specific audit contexts.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; however, Odoo tables typically represent the current state of the database, and historical records are generally preserved unless explicitly purged.
- **Data Integrity:** `pos_order_line_id` is nullable, which may indicate orphaned records or records associated with cancelled/draft operations.