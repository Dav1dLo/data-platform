# ir_model

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `ir_model` (Internal Resource Model), the use of `JSONB` for localized names, and specific columns like `create_uid`, `write_uid`, and the `is_mail_*` flags which are characteristic of the Odoo ORM metadata structure.

## Functional process 
This table supports the Odoo framework's internal metadata management, specifically the registry of all data models (objects) defined within the system. It tracks model definitions, their configuration for mail integration, and website form accessibility, acting as the central directory for the application's data schema.

## Description
One row in this table represents a single data model or entity registered within the Odoo application. It captures the model's technical identifier, its display name (stored as JSON for multi-language support), and various configuration flags that dictate how the model interacts with the mail system and website forms. This is a raw staging copy of the system's internal registry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `ir_model_id_seq` sequence. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users`. |
| model | VARCHAR | false | Technical name of the model | e.g., 'res.partner', 'sale.order'. |
| order | VARCHAR | false | Default sort order for the model | Used by the ORM for list views. |
| state | VARCHAR | true | Lifecycle state of the model | e.g., 'manual' vs 'base'. |
| name | JSONB | false | Human-readable name of the model | Likely contains language-specific keys. |
| info | TEXT | true | Descriptive metadata | Documentation or notes about the model. |
| transient | BOOLEAN | true | Flag for transient models | If true, records are automatically cleared. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| is_mail_thread | BOOLEAN | true | Mail thread integration flag | Enables chatter/messaging features. |
| is_mail_activity | BOOLEAN | true | Mail activity integration flag | Enables activity scheduling. |
| is_mail_blacklist | BOOLEAN | true | Mail blacklist integration flag | Enables email blacklisting features. |
| website_form_default_field_id | INTEGER | true | Default field ID for website forms | References `ir_model_fields`. |
| website_form_label | VARCHAR | true | Label for website form integration | Display label for the form. |
| website_form_key | VARCHAR | true | Unique key for website form access | Used for API/form routing. |
| website_form_access | BOOLEAN | true | Website form access flag | Enables public form submission. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `website_form_default_field_id` → `ir_model_fields.id` (Likely links to field definitions)
- **Natural keys (inferred):** 
    - `model` (The technical name is unique across the Odoo registry)

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **JSONB:** The `name` column contains JSON data; use PostgreSQL `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically managed by the Odoo ORM.
- **Sensitive Data:** No direct PII, but `create_uid` and `write_uid` link to user identity tables.