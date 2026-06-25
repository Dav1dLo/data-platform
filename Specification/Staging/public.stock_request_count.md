# stock_request_count

## Source system
The table likely originates from an Odoo ERP system, as evidenced by the characteristic naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys.

## Functional process 
This table supports the inventory management and stock reconciliation process. It tracks specific stock count requests or inventory adjustments initiated by users, linking these adjustments to specific dates for both operational and accounting purposes.

## Description
One row represents a single stock request or inventory count event initiated within the system. This is a raw landing table in the staging layer, containing a direct copy of the source system's transactional data used for tracking inventory discrepancies or scheduled stock takes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.stock_request_count_id_seq`. |
| user_id | INTEGER | true | ID of the user associated with the request | Likely references a user/employee table. |
| create_uid | INTEGER | true | ID of the user who created the record | Audit column for record creation. |
| write_uid | INTEGER | true | ID of the user who last modified the record | Audit column for record updates. |
| set_count | VARCHAR | true | The recorded stock count value | Stored as string; may require casting for arithmetic. |
| inventory_date | DATE | false | The date the inventory count took place | Mandatory field for reporting. |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed based on standard Odoo patterns. |
| write_date | TIMESTAMP | true | Timestamp of last modification | UTC assumed based on standard Odoo patterns. |
| accounting_date | DATE | true | The date the count is posted to the ledger | Used for financial period reconciliation. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo user reference).
    - `create_uid` → `res_users.id` (Guess: standard Odoo creator reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo modifier reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Data Types:** `set_count` is stored as a `VARCHAR`; ensure explicit casting to numeric types before performing aggregations.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC.
- **Audit Columns:** `create_uid` and `write_uid` are standard Odoo audit fields and may be null if the record was created via system migration or legacy import.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted_at` flag; assume all records are current unless otherwise specified by business logic.