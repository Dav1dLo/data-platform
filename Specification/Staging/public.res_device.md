# res_device

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `res_device` (common in Odoo's `res` module) and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports user session and device management, tracking the hardware and network context from which users access the platform. It is used to monitor active sessions, enforce security via the `revoked` flag, and provide geographical or technical analytics regarding user access patterns.

## Description
One row in this table represents a unique device or session instance associated with a specific user account. It serves as a raw landing copy of device-level metadata, capturing technical fingerprints like browser, platform, and IP address, alongside activity timestamps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely auto-incrementing ID. |
| user_id | INTEGER | true | Foreign key to the user | Links to the system user account. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| session_identifier | VARCHAR | true | Unique session token | Identifier for the specific login session. |
| platform | VARCHAR | true | Operating system | e.g., Windows, iOS, Android. |
| browser | VARCHAR | true | Browser name | e.g., Chrome, Firefox, Safari. |
| ip_address | VARCHAR | true | Network IP address | The source IP of the device. |
| country | VARCHAR | true | Country code | Derived from IP geolocation. |
| city | VARCHAR | true | City name | Derived from IP geolocation. |
| device_type | VARCHAR | true | Hardware category | e.g., Mobile, Desktop, Tablet. |
| revoked | BOOLEAN | true | Revocation status | If true, the session/device is blocked. |
| first_activity | TIMESTAMP | true | Initial login timestamp | UTC assumed. |
| last_activity | TIMESTAMP | true | Most recent activity | UTC assumed. |
| create_date | TIMESTAMP | true | Record creation time | Audit timestamp. |
| write_date | TIMESTAMP | true | Record modification time | Audit timestamp. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo pattern for linking to the users table).
    - `create_uid` → `res_users.id` (Standard Odoo audit link).
    - `write_uid` → `res_users.id` (Standard Odoo audit link).
- **Natural keys (inferred):** 
    - `session_identifier` (Likely unique per active session).

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `ip_address` column is considered PII and should be masked or handled according to data privacy policies.
- **Timezones:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Quality:** The `id` column is marked as nullable in the schema, which is unusual for a primary key; verify for nulls before performing joins.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; however, the `revoked` boolean acts as a functional filter for active sessions.