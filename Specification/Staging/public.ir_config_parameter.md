# ir_config_parameter

## Source system
This table originates from an Odoo ERP system, as evidenced by the `ir_` (Internal Resource) prefix and the specific pattern of `create_uid`, `write_uid`, and `id` sequence naming conventions typical of the Odoo framework's configuration management.

## Functional process 
This table supports the application configuration management process. It stores global system parameters and settings that dictate the behavior of the ERP instance, such as system URLs, feature flags, or integration endpoints, allowing the application to retrieve configuration values dynamically at runtime.

## Description
One row in this table represents a single configuration parameter key-value pair used by the application. It serves as a raw landed copy of the system's configuration settings, capturing the current value and the audit trail of who created or last modified the parameter.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_config_parameter_id_seq`. |
| create_uid | INTEGER | true | User ID who created the parameter | References the user table. |
| write_uid | INTEGER | true | User ID who last updated the parameter | References the user table. |
| key | VARCHAR | false | Unique configuration parameter name | The lookup key for the setting. |
| value | TEXT | false | Configuration value | The actual setting value stored as text. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `key`: The configuration parameter name is intended to be unique within the system.

## Caveats for downstream consumers

- The `value` column is stored as `TEXT` but may contain serialized data (JSON, booleans, or integers) depending on the specific parameter; cast accordingly.
- Timestamps (`create_date`, `write_date`) are typically stored in UTC by the Odoo framework.
- This table contains system-level configuration; changes here can alter application behavior globally.
- No soft-delete flag is present; records are typically hard-deleted or updated in place.