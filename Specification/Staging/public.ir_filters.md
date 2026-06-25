# ir_filters

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns like `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo ORM, as well as the `ir_` prefix commonly used for Odoo's "ir" (Irregular/Internal) modules.

## Functional process 
This table supports the user interface configuration and data filtering process. It stores saved search filters or "favorite" views defined by users for specific data models within the application, allowing users to persist complex domain queries and context settings for later reuse.

## Description
One row in this table represents a single saved filter configuration associated with a specific data model. It acts as a raw landed copy of the system's internal filter registry, capturing the filter's name, the underlying domain logic, and the user-specific context required to apply the filter to a view.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_filters_id_seq`. |
| user_id | INTEGER | true | Owner of the filter | Null if the filter is global/shared. |
| action_id | INTEGER | true | Associated action ID | Links to the UI action triggering the filter. |
| embedded_action_id | INTEGER | true | Embedded action ID | Used for nested or embedded view contexts. |
| embedded_parent_res_id | INTEGER | true | Parent resource ID | Contextual link for embedded filter logic. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the filter. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the filter. |
| name | VARCHAR | false | Filter display name | The label shown to the user in the UI. |
| sort | VARCHAR | false | Sort order configuration | Defines the