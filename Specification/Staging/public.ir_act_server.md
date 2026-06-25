# ir_act_server

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP platform. The naming convention `ir_act_server` (Internal Registry - Action Server) is a standard Odoo pattern used to store server-side actions that can be triggered via the user interface or automated workflows.

## Functional process 
This table supports the Odoo automation and action framework. It defines server-side actions—such as executing Python code, creating records, sending emails, or triggering SMS notifications—that are bound to specific business models. It is central to the "Action-to-Execution" pipeline, where user-defined triggers are translated into backend operations.

## Description
One row in this table represents a single server-side action configuration, defining what logic or operation should be executed when triggered. This is a raw landed copy of the Odoo configuration table, capturing the metadata, execution logic (code/templates), and binding parameters for automated tasks within the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| binding_model_id | INTEGER | true | Foreign key to the model this action is bound to | Used for UI context menus. |
| create_uid | INTEGER | true | User ID who created the action | Reference to `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the action | Reference to `res.users`. |
| type | VARCHAR | false | Type of action | e.g., 'code', 'ir.actions.server'. |
| path | VARCHAR | true | URL path for the action | Used for web-based triggers. |
| binding_type | VARCHAR | false | Binding type | e.g., 'action', 'report'. |
| binding_view_types | VARCHAR | true | View types where the action is available | Comma-separated list. |
| name | JSONB | false | Display name of the action | Multilingual support via JSONB. |
| help | JSONB | true | Help text/description | Multilingual support via JSONB. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC. |
| sequence | INTEGER | true | Display order | Lower numbers appear first. |
| model_id | INTEGER | false | Target model ID | Reference to `ir.model`. |
| crud_model_id | INTEGER | true | Model ID for CRUD operations | Used if action creates/updates records. |
| link_field_id | INTEGER | true | Field ID for linking | Reference to `ir.model.fields`. |
| update_field_id | INTEGER | true | Field ID to update | Reference to `ir.model.fields`. |
| update_related_model_id | INTEGER | true | Related model ID for updates | Reference to `ir.model`. |
| selection_value | INTEGER | true | Selection field value | Used for specific field updates. |
| usage | VARCHAR | false | Usage context | e.g., 'ir_actions_server'. |
| state | VARCHAR | false | Execution state/method | e.g., 'code', 'object_