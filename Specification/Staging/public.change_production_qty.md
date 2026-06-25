# change_production_qty

## Source system
This table likely originates from an Odoo ERP system, as evidenced by the naming convention of `mo_id` (Manufacturing Order), the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of a sequence-based default for the `id` column.

## Functional process 
This table supports the manufacturing execution process, specifically tracking adjustments or updates to the planned production quantities for manufacturing orders. It captures the history or current state of quantity changes, likely linked to the `mo_id` which acts as the reference to the parent manufacturing order.

## Description
One row in this table represents a specific update or adjustment event to the production quantity of a manufacturing order. As a staging table, it serves as a raw, landed copy of the source system's production quantity change logs, maintaining the grain of individual modification events.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.change_production_qty_id_seq`. |
| mo_id | INTEGER | false | Manufacturing Order identifier | Foreign key reference to the parent production order. |
| create_uid | INTEGER | true | User ID who created the record | Reference to the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | Reference to the system user table. |
| product_qty | NUMERIC | false | The updated production quantity | The numeric value of the quantity change. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded by the ingestion job/source system. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the ingestion job/source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mo_id` → `mrp_production.id` (guess: standard Odoo schema naming for manufacturing orders).
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit metadata (`create_uid`, `write_uid`); these should be joined against the user dimension table to resolve human-readable names.
- There is no explicit "is_deleted" flag; assume this is an append-only log of changes or a direct mirror of the source table.
- `product_qty` is a `NUMERIC` type, which is appropriate for precision-sensitive manufacturing quantities.