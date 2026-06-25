# change_password_wizard

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework that utilizes standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`). The naming convention `_wizard` is highly characteristic of Odoo's transient models used for temporary user-interface interactions.

## Functional process 
This table supports the "User Security and Authentication" process. It tracks the state of temporary wizard sessions used when a user initiates a password reset or change flow within the application.

## Description
One row in this table represents a single instance of a password change request session initiated by a user. As a staging table, it serves as a raw, transient record of these interactions before they are processed or cleared by the application's cleanup routines.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system's user table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo/ERP pattern for creator tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo/ERP pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The table appears to be a transient "wizard" model; expect high churn and potentially frequent deletions or truncations by the source system.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard PostgreSQL application defaults.
- `create_uid` and `write_uid` are likely internal system IDs; ensure joins are performed against the corresponding user dimension table in the target system.