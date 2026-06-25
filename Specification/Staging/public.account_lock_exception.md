# account_lock_exception

## Source system
The table likely originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys, which are characteristic of Odoo's PostgreSQL backend.

## Functional process 
This table supports the financial period-closing process by managing exceptions to standard accounting lock dates. It allows specific users or companies to bypass global lock dates for specific fields or timeframes, ensuring that historical financial records can be adjusted when necessary while maintaining audit control.

## Description
One row in this table represents a single exception rule that overrides standard accounting lock dates for a specific company or user. It functions as a raw landed copy of the configuration state, used to track who authorized the exception, the reason for the override, and the duration or scope of the lock date modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_lock_exception_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the organization subject to the lock. |
| user_id | INTEGER | true | Foreign key to the user | The specific user granted the exception. |
| create_uid | INTEGER | true | Creator ID | User ID who created this exception record. |
| write_uid | INTEGER | true | Modifier ID | User ID who last updated this record. |
| reason | VARCHAR | true | Business justification | Textual explanation for the exception. |
| lock_date_field | VARCHAR | false | Target field name | The specific accounting field being unlocked. |
| lock_date | DATE | true | Lock date override | The specific date value for the lock override. |
| company_lock_date | DATE | true | Company-level lock date | The effective lock date for the company. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the exception is currently enabled. |
| end_datetime | TIMESTAMP | true | Expiration timestamp | When the exception rule ceases to be valid. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time in UTC. |
| write_date | TIMESTAMP | true | Modification timestamp | Last record update time in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo company reference).
    - `user_id` → `res_users.id` (Guess: standard Odoo user reference).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo audit user reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` and `reason` fields which may contain internal operational context; ensure appropriate access controls.
- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` to retrieve current configurations.
- **Data Integrity:** As a staging table, this may contain multiple versions of the same exception record if the source system performs updates; consider using `write_date` to select the latest state.