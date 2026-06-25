# ir_act_window_view

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_act_window_view` is characteristic of Odoo's internal registry tables, where `ir` stands for "Internal Registry" and the table manages the association between window actions and their corresponding view definitions.

## Functional process 
This table supports the UI configuration and navigation framework within the ERP. It defines which views (e.g., form, tree, kanban) are available for a specific window action, determining how data is presented to the user when they trigger a menu item or action button.

## Description
One row represents a single view configuration linked to a specific window action, defining the order and type of view to be rendered. As a staging table, it serves as a raw, direct copy of the Odoo internal metadata, capturing the relationship between `act_window_id` and `view_id`.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_act_window_view_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort views when multiple are available. |
| view_id | INTEGER | true | Foreign key to view definition | References the specific view layout. |
| act_window_id | INTEGER | true | Foreign key to window action | References the parent action definition. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| view_mode | VARCHAR | false | View type identifier | e.g., 'tree', 'form', 'kanban', 'graph'. |
| multi | BOOLEAN | true | Multi-record action flag | Indicates if the action applies to multiple records. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (Inferred from Odoo architecture).
    - `act_window_id` → `ir_act_window.id` (Inferred from Odoo architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the server's local time; verify the Odoo instance timezone configuration before performing time-series analysis.
- **Data Integrity:** As a staging table, this contains raw system metadata; expect potential orphans if the source system has undergone manual database cleanup.
- **Soft Deletes:** Odoo typically performs hard deletes on configuration tables; this table likely represents the current state of the system configuration.
- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to internal user IDs; ensure these are mapped to user names via the `res_users` table if reporting on administrative activity.