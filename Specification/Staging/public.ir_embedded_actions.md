# ir_embedded_actions

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_` (Internal Resource) combined with columns like `parent_res_model`, `create_uid`, and `write_uid` is characteristic of the Odoo framework's metadata and action management system.

## Functional process 
This table supports the UI and workflow configuration process, specifically managing "embedded actions" that appear within the Odoo interface. It links specific business actions (defined by `action_id`) to parent resources (`parent_res_model` and `parent_res_id`), allowing for context-aware UI behavior, such as filtering views or executing specific Python methods based on the user's current record context.

## Description
One row in this table represents a single configuration entry for an embedded action, which dictates how a specific UI component or action behaves within the Odoo application. As a staging table, it provides a raw, direct copy of the internal Odoo `ir.embedded.actions` model, capturing the state of UI action definitions at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_embedded_actions_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort actions in the UI. |
| parent_action_id | INTEGER | false | ID of the parent action | Links to the primary action definition. |
| parent_res_id | INTEGER | true | ID of the parent resource | Specific record ID if the action is record-bound. |
| action_id | INTEGER | true | ID of the embedded action | The specific action being embedded. |
| user_id | INTEGER | true | Owner user ID | The user associated with this action configuration. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| parent_res_model | VARCHAR | false | Parent model name | The Odoo model (e.g., 'sale.order') this action belongs to. |
| python_method | VARCHAR | true | Executable method name | The Python method to trigger when the action is invoked. |
| default_view_mode | VARCHAR | true | Default UI view mode | e.g., 'tree', 'form', 'kanban'. |
| domain | VARCHAR | true | Filter domain | JSON-like string defining record visibility filters. |
| context | VARCHAR | true | Execution context | JSON-like string containing session/UI context variables. |
| name | JSONB | true | Display name | Localized name of the action stored as a JSON object. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `action_id` → `ir_actions.id` (Guess: links to the base action definition).
    - `create_uid` → `res_users.id` (Guess: links to the user who created the record).
    - `write_uid` → `res_users.id` (Guess: links to the user who last modified the record).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` and `create_uid`/`write_uid` which identify internal system users.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo.
- **Data Format:** The `domain` and `context` columns contain serialized strings (often Python-style dictionaries or lists) that require parsing to be useful in SQL filters.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted` flag; assume all records are current unless otherwise specified by Odoo's internal logic.