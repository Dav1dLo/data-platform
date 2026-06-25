# iap_account

## Source system
The table originates from an Odoo ERP environment, indicated by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys (`nextval` on `iap_account_id_seq`).

## Functional process 
This table supports the In-App Purchase (IAP) billing and service management process. It tracks account-level balances, authentication tokens for external service integration, and operational states for various services linked to the ERP instance.

## Description
One row represents a single IAP account configuration associated with a specific service. It serves as a raw landing staging entity, capturing the current state, balance, and security credentials required to interface with external IAP service providers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `iap_account_id_seq`. |
| service_id | INTEGER | false | Foreign key to the service definition | Identifies the specific IAP service. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user table. |
| name | VARCHAR | true | Account display name | Human-readable identifier for the account. |
| account_token | VARCHAR(43) | true | Authentication token | Sensitive credential for API access. |
| balance | VARCHAR | true | Current account balance | Stored as VARCHAR; likely requires casting for math. |
| state | VARCHAR | true | Operational state of the account | e.g., 'active', 'suspended'. |
| service_locked | BOOLEAN | true | Lock status flag | Indicates if the service is restricted. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |
| warning_threshold | DOUBLE PRECISION | true | Balance alert limit | Threshold for low-balance notifications. |
| sender_name | VARCHAR | true | Configured sender identity | Used for service-specific identification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `service_id` → `iap_service.id` (Guess: links to a master table defining available IAP services).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `account_token` column contains authentication credentials and should be masked or restricted in reporting environments.
- **Data Types:** The `balance` column is stored as a `VARCHAR`. Ensure it is cast to `NUMERIC` or `DECIMAL` before performing arithmetic operations.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are current unless otherwise specified by business logic.