# auth_totp_device

## Source system
The table likely originates from a Supabase or similar PostgreSQL-based authentication service (e.g., GoTrue), given the naming convention `auth_totp_device` and the use of standard PostgreSQL sequence-based primary keys.

## Functional process 
This table supports the Multi-Factor Authentication (MFA) management process. It tracks registered Time-based One-Time Password (TOTP) devices associated with user accounts, enabling secure login verification by storing the secret keys and metadata required to validate authentication codes.

## Description
One row represents a single registered TOTP device linked to a specific user account. This is a raw staging table containing the configuration and state of MFA devices, intended for use in authentication workflows and security auditing.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `auth_totp_device_id_seq`. |
| name | VARCHAR | false | Human-readable label for the device | Often set by the user (e.g., "Work Phone"). |
| user_id | INTEGER | false | Foreign key to the user account | Links the device to a specific identity. |
| scope | VARCHAR | true | Authentication scope | Defines the permissions or context for the device. |
| expiration_date | TIMESTAMP | true | Device expiration timestamp | Indicates when the device registration is no longer valid. |
| index | VARCHAR(8) | true | Short identifier or index | Used for quick device lookups. |
| key | VARCHAR | true | Encrypted or raw TOTP secret | Sensitive; used to generate/validate OTP codes. |
| create_date | TIMESTAMP | true | Record creation timestamp | Defaults to UTC `now()`. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `public.users.id` (Guess: standard naming convention for user-linked tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `key` column contains the TOTP secret and must be masked or restricted to authorized security services only.
- **Timezone:** `create_date` is explicitly set to UTC. Assume `expiration_date` is also in UTC.
- **Soft Deletes:** There is no explicit `is_deleted` or `deleted_at` column; assume this table represents the current state of active devices.
- **Data Integrity:** The `key` column is nullable, which may indicate devices in a "pending" or "incomplete" registration state.