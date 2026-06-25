# project_project_stage_delete_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `project_project_stage_delete_wizard` is characteristic of Odoo's "wizard" models, which are transient objects used to manage temporary UI states or multi-step processes—in this case, the deletion of project stages.

## Functional process 
This table supports the project management module's administrative workflow. It facilitates the "Project Stage Deletion" process, likely acting as a temporary container for user input or state management when a user initiates the removal of a stage within a project pipeline.

## Description
One row in this table represents a single execution instance of the project stage deletion wizard. It is a transient staging record used to track the metadata of a deletion request, including who initiated the action and when it was performed.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creation).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modification).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Transient Data:** As a "wizard" table, this data may be highly ephemeral and intended for cleanup; do not rely on this table for long-term audit trails of project stages.
- **Timestamps:** All timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which link to internal system users; ensure appropriate access controls are applied if joining with user identity tables.
- **Soft Deletes:** This table does not appear to implement soft-delete logic; it represents the state of the wizard process itself.