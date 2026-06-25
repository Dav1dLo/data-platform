# mrp_production_split_multi

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mrp_production_split_multi` (common in Odoo's Manufacturing Resource Planning module) and the standard Odoo audit columns `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the manufacturing execution process, specifically handling the splitting of production orders into multiple batches or sub-orders. It tracks the audit trail of who created or modified these split records within the production planning workflow.

## Description
Each row represents a specific instance or configuration of a production order split event within the manufacturing module. As a staging table, it serves as a raw, landed copy of the source system's transaction records, intended for subsequent transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique surrogate identifier for the record | Primary key; managed by a sequence |
| create_uid | INTEGER | true | ID of the user who created the record | References the users table |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the users table |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed based on Odoo standards |
| write_date | TIMESTAMP | true | Timestamp of last modification | UTC assumed based on Odoo standards |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking creator identity)
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking modifier identity)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit metadata; ensure joins to `res_users` are handled via `LEFT JOIN` as the `_uid` columns may be null in legacy or system-generated records.
- No soft-delete flag is present; assume records are either hard-deleted in the source or represent a complete history of split events.