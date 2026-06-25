# mail_ice_server

## Source system
This table originates from an Odoo ERP system. The naming convention (`mail_ice_server`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of a sequence-based default for the `id` column are characteristic of Odoo's ORM-managed database schema.

## Functional process 
This table supports the configuration of STUN/TURN servers used for WebRTC signaling in Odoo's communication modules. It stores the connection details required for real-time voice and video features, allowing the application to negotiate network paths between clients.

## Description
One row represents a single ICE (Interactive Connectivity Establishment) server configuration available to the application. This is a raw landed copy of the Odoo configuration table, serving as the staging entity for communication infrastructure settings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mail_ice_server_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | Foreign key to `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | Foreign key to `res_users`. |
| server_type | VARCHAR | false | Protocol type of the ICE server | e.g., 'stun' or 'turn'. |
| uri | VARCHAR | false | The URI of the ICE server | The network address for the server. |
| username | VARCHAR | true | Authentication username | Used for TURN server authentication. |
| credential | VARCHAR | true | Authentication password/secret | Sensitive; likely stored in plain text. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `credential` column contains authentication secrets and should be masked or restricted in downstream reporting.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployment practices.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column), which is common in other Odoo tables; assume all rows are active unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, this may contain configuration artifacts that are no longer in use by the active application instance.