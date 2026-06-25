# auth_totp_wizard

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default for the primary key.

## Functional process 
This table supports the multi-factor authentication (MFA) setup process for users. It acts as a temporary state machine or wizard to store the TOTP (Time-based One-Time Password) secret, the generated QR code, and the verification code during the user's enrollment phase before the configuration is finalized.

## Description
One row in this table represents a single active TOTP configuration session for a specific user. It is a staging-layer table that holds sensitive authentication metadata, including the shared secret and binary QR code, used to facilitate the initial setup of a user's authenticator app.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `auth_totp_wizard_id_seq`. |
| user_id | INTEGER | false | Foreign key to the user | Identifies the user performing the setup. |
| create_uid | INTEGER | true | Creator user ID | Audit field for the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field for the user who last updated the record. |
| secret | VARCHAR | false | TOTP shared secret | The base32 encoded secret key. |
| url | VARCHAR | true | Provisioning URI | The otpauth:// URL used to generate the QR code. |
| code | VARCHAR(7) | true | Verification code | The temporary code used to validate the setup. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |
| qrcode | BYTEA | true | QR code image data | Binary representation of the QR code. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (guess: standard Odoo/ERP user reference).
    - `create_uid` → `res_users.id` (guess: standard Odoo/ERP user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo/ERP user reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains `secret` and `qrcode` data. These columns should be masked or restricted to authorized security/admin roles only.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard PostgreSQL practices for ERP systems.
- **Data Lifecycle:** This is a "wizard" table; rows are likely transient and should be purged or archived once the TOTP setup is completed or abandoned.
- **Soft Deletes:** There is no explicit `active` or `deleted_at` flag; assume records are hard-deleted or managed by the application logic.