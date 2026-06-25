# change_password_own

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework, evidenced by the standard Odoo-style audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys.

## Functional process 
This table supports a self-service user security process, specifically the "Change Password" workflow. It captures the transient state of a user attempting to update their credentials by storing the proposed new password and its confirmation before the application logic validates and commits the change to the core user identity table.

## Description
One row represents a single password change request initiated by a user. It acts as a staging or audit log entry for the password update process, capturing the user's input and the associated metadata for the transaction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-increment. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the system user table. |
| new_password | VARCHAR | true | The proposed new password | Sensitive PII; should be masked. |
| confirm_password | VARCHAR | true | The confirmation of the new password | Should match `new_password`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo naming convention for user references).
    - `write_uid` → `res_users.id` (guess: standard Odoo naming convention for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains plain-text or hashed passwords (`new_password`, `confirm_password`). Access should be strictly restricted to authorized security or system audit roles.
- **Timestamps:** All date fields are assumed to be in UTC.
- **Data Retention:** As a staging table for a transactional process, rows may be purged or archived frequently; do not rely on this for long-term historical reporting.
- **Nullability:** Many fields are nullable, which may indicate incomplete requests or failed password change attempts.