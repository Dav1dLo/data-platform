# mail_activity_type

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `res_model`, and the use of `JSONB` for translatable fields like `name` and `summary`.

## Functional process 
This table supports the CRM and communication activity management process. It defines the configuration for different types of activities (e.g., "Call", "Email", "Meeting") that users can schedule against records in the system, including automation rules for delays and follow-up triggers.

## Description
One row in this table represents a specific configuration template for a mail activity type. It defines the behavior, scheduling logic, and default values for activities created within the platform. This is a raw landing table in the staging layer, capturing the configuration state of activity types from the source Odoo instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique identifier for the activity type | Surrogate PK |
| sequence | INTEGER | true | Display order for UI selection | |
| create_uid | INTEGER | true | User ID who created this record | Foreign key to res_users |
| delay_count | INTEGER | true | Numeric value for the scheduling delay | |
| triggered_next_type_id | INTEGER | true | ID of the activity type to trigger next | Self-referencing FK |
| default_user_id | INTEGER | true | Default user assigned to this activity | Foreign key to res_users |
| write_uid | INTEGER | true | User ID who last updated this record | Foreign key to res_users |
| delay_unit | VARCHAR | false | Time unit for delay (days, weeks, etc.) | |
| delay_from | VARCHAR | false | Reference point for delay calculation | |
| icon | VARCHAR | true | CSS class or icon identifier | |
| decoration_type | VARCHAR | true | UI styling hint (e.g., alert, warning) | |
| res_model | VARCHAR | true | The Odoo model this activity applies to | |
| chaining_type | VARCHAR | false | Logic for activity chaining | |
| category | VARCHAR | true | Functional category of the activity | |
| name | JSONB | false | Translatable name of the activity type | |
| summary | JSONB | true | Translatable default summary | |
| default_note | JSONB | true | Translatable default note content | |
| active | BOOLEAN | true | Soft-delete flag | |
| keep_done | BOOLEAN | true | Whether to retain completed activities | |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `create_uid` → `res_users.id` (Standard Odoo audit field)
    - `write_uid` → `res_users.id` (Standard Odoo audit field)
    - `triggered_next_type_id` → `mail_activity_type.id` (Links to the next activity in a sequence)
    - `default_user_id` → `res_users.id` (Links to the default responsible user)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the internal `id` for configuration records.

## Caveats for downstream consumers

- **JSONB Fields:** The `name`, `summary`, and `default_note` columns contain JSONB data, likely storing multi-language strings. Use `->> 'en_US'` or similar syntax to extract specific language values.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical configuration analysis is required.
- **Timestamps:** `create_date` and `write_date` are stored in UTC, consistent with standard Odoo database practices.
- **Audit Fields:** `create_uid` and `write_uid` reference the `res_users` table, which may not be present in this staging schema.