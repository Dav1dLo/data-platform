# res_device_log

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys, which are characteristic of the Odoo PostgreSQL schema.

## Functional process 
This table supports the session management and security auditing process. It tracks user device authentication, geolocation, and activity history, likely used for security monitoring, session revocation, and user access analytics.

## Description
One row in this table represents a unique user session or device registration event. It serves as a raw landed copy of device-specific metadata and activity timestamps, providing a granular audit trail of how and where a user has accessed the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `res_device_log_id_seq`. |
| user_id | INTEGER | true | Foreign key to the user | Links to the system user account. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| session_identifier | VARCHAR | false | Unique session token | The business identifier for the session. |
| platform | VARCHAR | true | Operating system | e.g., Windows, iOS, Android. |
| browser | VARCHAR | true | Web browser name | e.g., Chrome, Firefox. |
| ip_address | VARCHAR | true | Source IP address | Used for geolocation and security. |
| country | VARCHAR | true | ISO country code | Derived from IP address. |
| city | VARCHAR | true | City name | Derived from IP address. |
| device_type | VARCHAR | true | Hardware category | e.g., Mobile, Desktop, Tablet. |
| revoked | BOOLEAN | true | Revocation status | Indicates if the session is active. |
| first_activity | TIMESTAMP | true | Session start time | Timestamp of initial login/activity. |
| last_activity | TIMESTAMP | true | Session end/last time | Timestamp of most recent activity. |
| create_date | TIMESTAMP | true | Record creation time | Audit timestamp. |
| write_date | TIMESTAMP | true | Record modification time | Audit timestamp. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Likely link to the Odoo user table).
    - `create_uid` → `res_users.id` (Audit link to the creator).
    - `write_uid` → `res_users.id` (Audit link to the modifier).
- **Natural keys (inferred):** 
    - `session_identifier` (Unique identifier for the session instance).

## Caveats for downstream consumers

- **Sensitive Data:** Contains `ip_address`, which may be considered PII under GDPR/CCPA; ensure appropriate masking if exposing to non-privileged users.
- **Timezones:** Timestamps are typically stored in UTC in Odoo environments, but verify against application settings.
- **Soft Deletes:** This table does not appear to use a `deleted` flag; assume all records are active unless `revoked` is set to `TRUE`.
- **Data Quality:** `country` and `city` fields are likely derived from IP geolocation services and may be missing or inaccurate for VPN/proxy traffic.