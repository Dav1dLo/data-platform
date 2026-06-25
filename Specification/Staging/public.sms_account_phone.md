# sms_account_phone

## Source system
The table likely originates from an Odoo ERP or a similar modular business application, evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys.

## Functional process 
This table supports a communication or messaging module, specifically managing the association between internal account entities and their registered phone numbers. It likely facilitates SMS notification services or multi-factor authentication (MFA) workflows linked to specific user or business accounts.

## Description
One row represents a single phone number associated with a specific account. This is a raw landing table in the staging layer, containing the initial state of phone number records as they exist in the source system before any downstream transformation or deduplication.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.sms_account_phone_id_seq`. |
| account_id | INTEGER | false | Foreign key to the parent account | Links to the entity owning this phone number. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user system. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user system. |
| phone_number | VARCHAR | false | The registered phone number | Format is unverified; may include country codes. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.id` (Guess: standard naming convention for account-linked entities).
    - `create_uid` → `res_users.id` (Guess: common Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: common Odoo pattern for audit fields).
- **Natural keys (inferred):** 
    - `account_id` + `phone_number` (The combination of an account and a specific phone number is likely unique).

## Caveats for downstream consumers

- **Sensitive Data:** The `phone_number` column contains PII and should be masked or restricted according to data privacy policies.
- **Timestamps:** All date fields (`create_date`, `write_date`) are assumed to be in UTC; verify against source system configuration if precision is required.
- **Soft Deletes:** This table does not explicitly show a `deleted_at` or `active` flag; assume all records are currently active unless otherwise specified by the source system's business logic.
- **Data Quality:** As a staging table, `phone_number` may contain inconsistent formatting (e.g., with or without leading '+', spaces, or parentheses).