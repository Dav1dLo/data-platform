# ir_act_url

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `ir_act_` (Internal Resource Action), the use of `JSONB` for localized fields like `name` and `help`, and the standard Odoo audit columns `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the configuration of URL-based actions within the Odoo application, which are used to define menu items or button triggers that redirect users to external web resources. It is part of the system's action management framework, linking specific UI triggers to target URLs.

## Description
One row in this table represents a single URL action definition within the Odoo platform. It serves as a raw landing copy of the configuration metadata, capturing the target URL, the binding context, and the localized display name for the action.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_actions_id_seq`. |
| binding_model_id | INTEGER | true | Foreign key to the model this action is bound to | Links to `ir_model`. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res_users`. |
| type | VARCHAR | false | Action type identifier | Usually set to 'ir.actions.act_url'. |
| path | VARCHAR | true | URL path segment | Optional routing path. |
| binding_type | VARCHAR | false | Type of binding | Defines how the action is attached to models. |
| binding_view_types | VARCHAR | true | Comma-separated list of view types | e.g., 'list,form'. |
| name | JSONB | false | Localized display name | Multi-language support via JSON. |
| help | JSONB | true | Localized help text | Multi-language support via JSON. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| target | VARCHAR | false | Window target | e.g., 'new' or 'self'. |
| url | TEXT | false | The destination URL | The actual web address. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `binding_model_id` → `ir_model.id`: Links the action to a specific business object.
    - `create_uid` → `res_users.id`: Identifies the creator of the action.
    - `write_uid` → `res_users.id`: Identifies the last user to modify the action.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Localization:** The `name` and `help` columns are `JSONB` objects; queries should use the `->>` operator to extract specific language keys (e.g., `name->>'en_US'`).
- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Data Integrity:** As a staging table, this may contain historical versions or orphaned records if the source system performs soft deletes or maintains audit logs.
- **Sensitive Data:** While this table contains configuration, ensure that `url` values are audited for internal paths or parameters that might expose sensitive environment information.