# wizard_ir_model_menu_create

## Source system
This table originates from an Odoo ERP system. The naming convention `wizard_ir_model_menu_create` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal model registry and wizard-based UI components.

## Functional process 
This table supports the "Menu Creation Wizard" process within the ERP, which allows users to dynamically generate menu items for specific data models. It tracks the configuration state of these menu creation tasks, linking specific menu definitions to the users who initiated or modified the creation request.

## Description
One row in this table represents a single instance of a menu creation wizard execution or configuration record. It acts as a staging entity for the metadata required to register a new menu item in the system's navigation structure.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `wizard_ir_model_menu_create_id_seq`. |
| menu_id | INTEGER | false | Foreign key to the target menu | References the menu structure being created or modified. |
| create_uid | INTEGER | true | Creator user ID | References the `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | References the `res_users` table. |
| name | VARCHAR | false | Menu display name | The label that appears in the UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `menu_id` → `ir_ui_menu.id` (Guess: links to the system's menu definition table).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Lifecycle:** This is a staging table for a wizard; records may be transient or subject to frequent cleanup depending on the Odoo environment's maintenance policies.
- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which link to internal system users; ensure appropriate access controls are applied when joining with user-identifying tables.