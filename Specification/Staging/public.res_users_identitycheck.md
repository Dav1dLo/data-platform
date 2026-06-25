# res_users_identitycheck

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `res_users_*` and the specific pattern of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and sequence-based primary keys (`nextval('"public".res_users_identitycheck_id_seq'::regclass)`).

## Functional process 
This table supports the user authentication and security verification process. It tracks identity check requests, likely used to log or validate secondary authentication attempts, password resets, or multi-factor authentication challenges associated with user accounts.

## Description
One row in this table represents a single identity verification event or security request initiated by a user. It serves as a raw landing copy of authentication-related metadata, capturing the method used and the associated request details.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a database sequence. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| request | VARCHAR | true | The specific identity request payload | May contain serialized data or request identifiers. |
| auth_method | VARCHAR | true | The authentication method used | e.g., 'password', 'totp', 'email_otp'. |
| password | VARCHAR | true | Encrypted or hashed password string | Highly sensitive; likely contains a hash. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `password` column contains sensitive authentication credentials and must be masked or excluded from non-privileged reporting.
- **Timestamps:** All date fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** This table acts as a raw staging log; it is unclear if it implements a soft-delete policy or if it is an append-only audit log.
- **Odoo Context:** As a staging table, this data may contain technical artifacts or internal Odoo system identifiers that require joining with `res_users` to be human-readable.