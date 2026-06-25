# ir_default

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `ir_` prefix, `create_uid`, `write_uid`, `create_date`, `write_date`) is characteristic of the Odoo "Ir" (Irregular/Internal) module framework, which manages system-wide configurations and default values.

## Functional process 
This table supports the application's default value management system. It stores user-specific or company-specific default values for various fields across the platform, allowing the system to pre-populate forms or filter records based on stored JSON configurations.

## Description
One row in this table represents a single default value configuration for a specific field, potentially scoped to a user or a company. As a staging table, it acts as a raw landed copy of the Odoo `ir_default` table, capturing the state of system defaults before any transformation or business logic application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_default_id_seq`. |
| field_id | INTEGER | false | Reference to the field definition | Links to the system's field registry. |
| user_id | INTEGER | true | User scope for the default | Null if the default applies globally. |
| company_id | INTEGER | true | Company scope for the default | Null if the default applies across all companies. |
| create_uid | INTEGER | true | ID of the user who created the record | Audit trail for record creation. |
| write_uid | INTEGER | true | ID of the user who last updated the record | Audit trail for record modification. |
| condition | VARCHAR | true | Filter condition for the default | Likely a domain string or JSON filter. |
| json_value | VARCHAR | false | The default value stored as JSON | The actual value to be applied. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `field_id` → `ir_model_fields.id` (Guess: standard Odoo schema relationship).
    - `user_id` → `res_users.id` (Guess: standard Odoo schema relationship).
    - `company_id` → `res_company.id` (Guess: standard Odoo schema relationship).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` and potentially sensitive configuration values within `json_value`.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records present are active unless otherwise specified by the source system logic.
- **JSON Handling:** The `json_value` column contains serialized data; downstream consumers will need to use PostgreSQL JSON functions (e.g., `json_extract_path_text`) to parse the contents.