# res_config

## Source system
This table originates from an Odoo ERP environment. The naming convention `res_config` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo "Resource" (res) module, which manages system-wide configuration settings.

## Functional process 
This table supports the application configuration and settings management process. It stores the state of various system parameters and configuration flags that dictate the behavior of the ERP instance, allowing administrators to persist environment-specific settings.

## Description
One row in this table represents a single configuration record or a set of system parameters within the Odoo framework. It serves as a raw landing copy of the configuration state, capturing the audit trail of who modified the settings and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator `res_config_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database practices.
- This table contains audit metadata; it does not contain PII, but it does track user activity via `create_uid` and `write_uid`.
- There is no explicit "active" or "deleted" flag; Odoo typically handles deletions via hard deletes or specific module-level logic.
- The table structure is highly generic; the actual configuration values are likely stored in related tables or via a key-value pattern not fully represented in this specific schema.