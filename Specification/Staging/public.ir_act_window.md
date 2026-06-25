# ir_act_window

## Source system
This table originates from the Odoo ERP system. The naming convention `ir_act_window` (Internal Resource Action Window) is a standard core table in Odoo's metadata schema, used to define window actions that trigger views or data displays within the application interface.

## Functional process 
This table supports the UI and navigation configuration process. It defines how specific models are presented to users, including which views to load, default search domains, and the target context for window actions. It is central to the "Application Configuration" and "User Interface Management" modules of the ERP.

## Description
One row in this table represents a single window action configuration, which dictates how a specific data model is rendered in the user interface. This is a raw landed copy of the Odoo metadata table, serving as the staging layer for UI configuration and navigation logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_actions_id_seq`. |
| binding_model_id | INTEGER | true | Foreign key to the model this action is bound to | Used for context-menu actions. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users`. |
| type | VARCHAR | false | The type of action | Usually 'ir.actions.act_window'. |
| path | VARCHAR | true | URL path associated with the action | Often null for standard internal actions. |
| binding_type | VARCHAR | false | Type of binding | e.g., 'action', 'report'. |
| binding_view_types | VARCHAR | true | Comma-separated list of view types | Defines where the action appears. |
| name | JSONB | false | Display name of the action | Multilingual support via JSONB. |
| help | JSONB | true | Help text for the action | Multilingual support via JSONB. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| view_id | INTEGER | true | Default view ID | References `ir_ui_view`. |
| res_id | INTEGER | true | Resource ID | Specific record ID if applicable. |
| limit | INTEGER | true | Default record limit | Pagination setting. |
| search_view_id | INTEGER | true | Search view ID | References `ir_ui_view`. |
| domain | VARCHAR | true | Filter domain | Python-style domain expression. |
| context | VARCHAR | false | Context dictionary | JSON-like string for session context. |
| res_model | VARCHAR | false | Target model name | The technical name of the model. |
| target | VARCHAR | true | Target window type | e.g., 'current', 'new'. |
| view_mode | VARCHAR | false | Comma-separated view modes | e.g., 'tree,form'. |
| mobile_view_mode | VARCHAR | true | Mobile-specific view modes | Overrides for mobile devices. |
| usage | VARCHAR | true | Usage category | e.g., 'menu'. |
| filter | BOOLEAN | true | Filter flag | Indicates if the action is a filter. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `binding_model_id` → `ir_model.id` (Guess: links the action to a specific business model).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
    - `view_id` → `ir_ui_view.id` (Links to the UI view definition).
    - `search_view_id` → `ir_ui_view.id` (Links to the search filter definition).
- **Natural keys (inferred):** None. The table relies on the surrogate `id` for uniqueness.

## Caveats for downstream consumers

- **JSONB columns:** `name` and `help` contain JSONB data; ensure your SQL environment supports extraction (e.g., `name->>'en_US'`).
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft deletes:** This table does not appear to implement soft deletes; records are typically hard-deleted in Odoo.
- **Domain/Context:** The `domain` and `context` columns contain serialized strings (often Python syntax) that may require custom parsing logic if used for filtering in downstream SQL.