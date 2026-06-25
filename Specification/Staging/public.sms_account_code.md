# sms_account_code

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. This inference is based on the standard naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, which are characteristic of Odoo's ORM audit fields, combined with the use of PostgreSQL sequence-based defaults.

## Functional process 
This table supports the identity verification or multi-factor authentication (MFA) process. It stores temporary SMS-based verification codes linked to specific accounts, likely used during login, password resets, or sensitive transaction authorization workflows.

## Description
Each row represents a single SMS verification code generated for a specific account. This is a raw staging table containing the audit trail and the current state of verification requests, intended to be used for tracking authentication attempts or validating user identity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `sms_account_code_id_seq`. |
| account_id | INTEGER | false | Foreign key to the account | Links the code to a specific user or entity. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who triggered the code generation. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| verification_code | VARCHAR | false | The SMS code | The actual token sent to the user. |
| create_date | TIMESTAMP | true | Creation timestamp | When the code was generated. |
| write_date | TIMESTAMP | true | Last update timestamp | When the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.id` (Guess: links to a core account or user table).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `verification_code` column contains authentication tokens and should be masked or restricted in downstream reporting environments.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard PostgreSQL/Odoo deployments.
- **Audit Fields:** `create_date` and `write_date` should be used to filter for recent activity; records may persist after the code has expired or been used.
- **Data Integrity:** As a staging table, this may contain multiple entries per `account_id` if the user requested multiple codes; ensure queries filter for the most recent `create_date` if looking for the active code.