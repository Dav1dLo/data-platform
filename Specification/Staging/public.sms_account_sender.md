# sms_account_sender

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. This is inferred from the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key, which are characteristic patterns of the Odoo framework.

## Functional process 
This table supports the configuration and management of SMS communication channels within the platform. It maps specific sender identities or "from" names to individual accounts, enabling the system to track which user or entity is authorized to send messages on behalf of a specific account.

## Description
One row in this table represents a single SMS sender configuration associated with a specific account. It serves as a raw landed staging entity, capturing the relationship between accounts and their defined sender identities, including audit metadata for tracking creation and modification events.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_account_sender_id_seq` sequence. |
| account_id | INTEGER | false | Foreign key to the parent account | Identifies the account owning this sender configuration. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user system. |
| write_uid | INTEGER | true | User ID who last modified the record | References the internal user system. |
| sender_name | VARCHAR | true | Display name of the SMS sender | The identifier used as the "from" field in SMS. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.id` (Guess: standard naming convention for account-linked entities).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `sender_name` may contain PII or brand-specific identifiers; ensure appropriate masking if used in non-production environments.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard PostgreSQL/Odoo deployments.
- **Audit Columns:** `create_uid` and `write_uid` are nullable; do not assume every record has an associated user if the record was created via system migration or automated process.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records if the upstream source system allows for transient states.