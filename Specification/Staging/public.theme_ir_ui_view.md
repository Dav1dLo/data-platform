# theme_ir_ui_view

## Source system
This table originates from an Odoo ERP system, as evidenced by the `ir_ui_view` naming convention, which is the standard internal table name for user interface views in the Odoo framework. The presence of `create_uid`, `write_uid`, and `arch` (architecture) columns is characteristic of Odoo's metadata-driven UI management.

## Functional process 
This table supports the UI customization and theme management process within the application. It stores the definitions and structural architecture of interface views, allowing the system to dynamically render pages, forms, and themes based on the stored `arch` (JSONB) definitions and inheritance logic.

## Description
One row in this table represents a single UI view definition, such as a form, tree, or search view, used by the application's frontend. This is a raw landed copy from the source system, serving as the staging layer entity for UI configuration and theme-related metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique identifier for the view | Primary key, sequence-generated |
| priority | INTEGER | false | Rendering priority order | Lower numbers typically indicate higher priority |
| create_uid | INTEGER | true | ID of the user who created the view | References the system user table |
| write_uid | INTEGER | true | ID of the user who last updated the view | References the system user table |
| name | VARCHAR | false | Descriptive name of the view | Human-readable label |
| key | VARCHAR | true | Unique technical key for the view | Used for programmatic lookups |
| type | VARCHAR | true | Type of view (e.g., form, tree, qweb) | Defines how the `arch` should be parsed |
| mode | VARCHAR | true | View mode (e.g., primary, extension) | Determines if the view is a base or an override |
| arch_fs | VARCHAR | true | Filesystem path for the view architecture | Used when the view is defined in a file |
| inherit_id | VARCHAR | true | ID of the parent view being extended | Used for view inheritance |
| arch | JSONB | true | The XML/JSON structure of the view | Contains the actual UI layout definition |
| active | BOOLEAN | true | Soft-delete flag | If false, the view is ignored by the system |
| customize_show | BOOLEAN | true | Flag for UI customization visibility | Controls if the view is editable in the UI |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `inherit_id` → `theme_ir_ui_view.id` (Guess: self-referencing foreign key for view inheritance).
- **Natural keys (inferred):** 
    - `key` (The technical identifier is often used as the business key for view lookups).

## Caveats for downstream consumers

- **Sensitive Data:** The `arch` column may contain internal system paths or configuration details; ensure access is restricted if the UI definitions expose internal business logic.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` to retrieve only current, valid views.
- **Data Format:** The `arch` column is stored as `JSONB`, which may require specific PostgreSQL operators (e.g., `->>`, `@>`) to query nested UI elements effectively.