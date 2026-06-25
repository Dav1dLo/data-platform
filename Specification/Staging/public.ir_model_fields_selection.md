# ir_model_fields_selection

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_model_fields_selection` is a standard internal Odoo table structure used to store the selection options (dropdown values) for fields defined within the system's metadata layer.

## Functional process 
This table supports the dynamic configuration of the application's data model. It manages the valid selection options for fields that are configured as "selection" types, allowing the system to define the relationship between a stored database value and its human-readable label across different languages.

## Description
One row in this table represents a single selectable option for a specific field within the Odoo data model. It acts as a lookup table for UI components and validation logic, storing the internal machine-readable value and its corresponding localized display name. This is a raw landing copy of the Odoo metadata table, intended for use in understanding the schema definitions of the source application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| field_id | INTEGER | false | Foreign key to the field definition | References the parent field in `ir_model_fields`. |
| sequence | INTEGER | true | Display order | Determines the sort order in UI dropdowns. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this option. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this option. |
| value | VARCHAR | false | Machine-readable value | The actual value stored in the target data record. |
| name | JSONB | false | Localized display label | Stores the human-readable label, often as a JSON object for multi-language support. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `field_id` → `ir_model_fields.id`: This column links the selection option to the specific field definition it belongs to.
    - `create_uid` → `res_users.id`: Guessed; standard Odoo pattern for audit tracking.
    - `write_uid` → `res_users.id`: Guessed; standard Odoo pattern for audit tracking.
- **Natural keys (inferred):** 
    - `(field_id, value)`: The combination of the field reference and the specific option value uniquely identifies a selection choice within the system.

## Caveats for downstream consumers

- **Localization:** The `name` column is `JSONB` and likely contains translations (e.g., `{"en_US": "Active", "fr_FR": "Actif"}`). Ensure your queries extract the correct language key.
- **Timestamps:** Timestamps are stored in UTC as per standard Odoo configuration.
- **Data Integrity:** As this is a staging table, it may contain historical metadata or orphaned records if the source `ir_model_fields` table has been cleaned.
- **Sensitive Data:** No PII is expected in this table, as it contains system configuration metadata.