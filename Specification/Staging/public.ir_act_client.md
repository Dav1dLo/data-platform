# ir_act_client

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_act_client` (Internal Resource Action Client) and the presence of columns like `res_model`, `create_uid`, and `write_uid` are characteristic of Odoo's metadata-driven architecture for managing client-side actions and menu bindings.

## Functional process 
This table supports the configuration of client-side actions within the Odoo application interface. It defines how specific actions (such as opening a view, executing a report, or triggering a client-side function) are bound to models or menu items, facilitating the dynamic rendering of the user interface based on the `binding_model_id` and `res_model`.

## Description
One row in this table represents a single client-side action definition, which dictates how the application should respond to user interactions. As a staging table, it serves as a raw, direct copy of the Odoo `ir_act_client` system table, capturing the configuration state of UI actions at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `ir_actions_id_seq` sequence. |
| binding_model_id | INTEGER | true | Foreign key to the target model | Links the action to a specific business object. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this action. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this action. |
| type | VARCHAR | false | Action type identifier | Defines the nature of the action (e.g., 'ir.actions.act_window'). |
| path | VARCHAR | true | URL or path reference | Optional path for web-based actions. |
| binding_type | VARCHAR | false | Binding category | Defines how the action is bound (e.g., 'action', 'report'). |
| binding_view_types | VARCHAR | true | Supported view types | Comma-separated list of views where this action appears. |
| name | JSONB | false | Action display name | Multi-language label stored as JSON. |
| help | JSONB | true | Help tooltip text | Multi-language description stored as JSON. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |
| tag | VARCHAR | false | Action tag | Used for grouping or filtering actions. |
| target | VARCHAR | true | Execution target | Defines where the action opens (e.g., 'current', 'new'). |
| res_model | VARCHAR | true | Resource model name | The technical name of the model this action applies to. |
| context | VARCHAR | false | Execution context | JSON-like string containing session/action parameters. |
| params_store | BYTEA | true | Serialized parameters | Binary storage for complex action parameters. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `binding_model_id` → `ir_model.id` (Guess: links to the Odoo model definition table).
    - `create_uid` → `res_users.id` (Guess: links to the Odoo user table).
    - `write_uid` → `res_users.id` (Guess: links to the Odoo user table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are typically stored in UTC by Odoo; verify against system settings if local time conversion is required.
- **JSONB content:** The `name` and `help` columns contain JSONB data; ensure your query logic handles extraction (e.g., `name->>'en_US'`) if specific language labels are needed.
- **Soft Deletes:** This table represents a raw dump; it does not explicitly implement soft-delete flags, but Odoo system tables are generally append-only or updated in-place.
- **Sensitive Data:** While not containing PII, `params_store` may contain serialized configuration data that should be handled with care.