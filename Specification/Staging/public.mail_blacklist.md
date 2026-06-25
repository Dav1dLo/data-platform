# mail_blacklist

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default for the primary key.

## Functional process 
This table supports the email communication management process, specifically the "Email Opt-Out" or "Blacklist" functionality. It tracks email addresses that have requested to be unsubscribed or blocked from receiving further automated communications from the platform.

## Description
One row represents a single email address that has been explicitly blacklisted within the system. This is a raw staging table containing the current state of the blacklist, used to filter recipients in marketing or transactional email workflows.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_blacklist_id_seq` sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the users table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the users table. |
| email | VARCHAR | false | The blacklisted email address | Natural key for this entity. |
| active | BOOLEAN | true | Soft-delete flag | If false, the email is no longer blacklisted. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `email`

## Caveats for downstream consumers

- **PII:** The `email` column contains personally identifiable information and should be handled according to data privacy policies.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` to see currently blacklisted addresses.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit:** `create_uid` and `write_uid` may be null if the record was created via a system process rather than a specific user action.