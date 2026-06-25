# mail_activity_schedule

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns like `res_model`, `create_uid`, `write_uid`, and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the automated scheduling of CRM or communication activities within the Odoo platform. It tracks planned activities linked to specific business objects (defined by `res_model` and `res_ids`), managing the lifecycle of tasks assigned to users via `activity_user_id` and `plan_on_demand_user_id`.

## Description
One row in this table represents a single scheduled activity or task template associated with a specific business record. It serves as a staging entity for tracking pending or planned communications, capturing the deadline, the assigned user, and the underlying business context.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated |
| res_model_id | INTEGER | false | ID of the related model | Foreign key to ir_model |
| plan_id | INTEGER | true | ID of the activity plan | Links to activity planning templates |
| plan_on_demand_user_id | INTEGER | true | User ID for on-demand planning | - |
| activity_type_id | INTEGER | true | Type of activity | e.g., Call, Email, Meeting |
| activity_user_id | INTEGER | true | Assigned user ID | The person responsible for the task |
| create_uid | INTEGER | true | Creator user ID | Audit trail |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail |
| res_model | VARCHAR | false | Model name | e.g., 'crm.lead', 'sale.order' |
| summary | VARCHAR | true | Activity summary | Short description of the task |
| plan_date | DATE | true | Planned date | - |
| date_deadline | DATE | true | Due date | - |
| res_ids | TEXT | true | Related record IDs | Often stored as a comma-separated string or JSON |
| note | TEXT | true | Detailed notes | - |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `res_model_id` → `ir_model.id`: Links the activity to the specific Odoo system model.
    - `activity_type_id` → `mail_activity_type.id`: Defines the category of the activity.
    - `activity_user_id` → `res_users.id`: Identifies the employee responsible for the activity.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Format:** The `res_ids` column contains a text representation of record IDs; parsing may be required depending on the Odoo version's storage format (often a stringified list).
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are current unless filtered by business logic.
- **Sensitive Data:** `note` and `summary` may contain PII or internal business communications; ensure appropriate access controls are applied.