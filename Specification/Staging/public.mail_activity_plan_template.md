# mail_activity_plan_template

## Source system
This table originates from Odoo (OpenERP), as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, and the use of sequence-based primary keys (`nextval` on `mail_activity_plan_template_id_seq`).

## Functional process 
This table supports the "Marketing Automation" or "CRM Activity Planning" business process. It defines the structure of activity templates within a plan, allowing users to pre-configure a sequence of tasks (e.g., calls, emails, meetings) that should be triggered automatically as part of a marketing or sales workflow.

## Description
One row represents a single activity step within a predefined activity plan template. It defines the timing, responsible party, and content for that specific step. As a staging table, this represents a raw, direct copy of the Odoo database table, intended for downstream transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated |
| plan_id | INTEGER | false | Foreign key to the parent plan | Links to the plan definition |
| sequence | INTEGER | true | Display order of the activity | Used for sorting steps |
| activity_type_id | INTEGER | false | Type of activity (e.g., call, email) | Links to activity_type table |
| delay_count | INTEGER | true | Numerical value for the delay | Used with delay_unit |
| responsible_id | INTEGER | true | ID of the assigned user/role | Nullable if system-assigned |
| create_uid | INTEGER | true | User ID who created the record | Audit field |
| write_uid | INTEGER | true | User ID who last updated the record | Audit field |
| delay_unit | VARCHAR | false | Time unit for the delay | e.g., 'days', 'weeks' |
| delay_from | VARCHAR | false | Reference point for the delay | e.g., 'previous_activity' |
| summary | VARCHAR | true | Short description of the activity | Display label |
| responsible_type | VARCHAR | false | Logic for assigning responsibility | e.g., 'user', 'manager' |
| note | TEXT | true | Detailed instructions for the activity | Free-text field |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `plan_id` → `mail_activity_plan.id` (Likely parent container for the template)
    - `activity_type_id` → `mail_activity_type.id` (Defines the category of the activity)
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo user audit links)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` fields are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume rows are hard-deleted if removed from the source.
- **Data Integrity:** As a staging table, `responsible_id` and `sequence` may contain nulls depending on the specific configuration of the activity plan in the source system.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal Odoo user IDs and may not map to human-readable names without joining to the `res_users` table.