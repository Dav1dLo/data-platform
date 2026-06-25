# res_users_log

## Source system
This table originates from an Odoo ERP system. The naming convention `res_users_log` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) alongside a sequence-based primary key are characteristic of Odoo's internal resource management schema.

## Functional process 
This table supports the audit and tracking process for user-related activities or record modifications within the ERP. It functions as a metadata log, capturing the "who" and "when" of record creation and updates, likely linked to the broader user management module.

## Description
One row in this table represents a single audit entry or log record associated with a user-related event. It serves as a raw landed copy of the source system's audit trail, intended for tracking record lineage and modification history within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `res_users_log_id_seq` for auto-incrementing values. |
| create_uid | INTEGER | true | ID of the user who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the `res_users` table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely stored in UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely stored in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `public.res_users.id`: This column typically links to the user who performed the creation action.
    - `write_uid` → `public.res_users.id`: This column typically links to the user who performed the last update action.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The table contains audit metadata; ensure that user IDs are joined against the appropriate `res_users` dimension table to resolve human-readable names.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table acts as an append-only or update-log; check for multiple entries per entity if this table tracks historical state changes.
- No PII is explicitly present in these columns, but the `uid` columns allow for joining with tables that may contain sensitive user information.