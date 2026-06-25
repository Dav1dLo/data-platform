# project_task_type_delete_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `*_delete_wizard`, combined with standard audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date`, is characteristic of Odoo's transient model architecture used for handling user-interactive wizard processes.

## Functional process 
This table supports the administrative process of deleting task types within the project management module. It acts as a temporary state container for the "wizard" interface that prompts users to confirm the deletion of a task type and potentially reassign or handle associated records.

## Description
One row in this table represents a single execution instance of a task type deletion wizard session. It is a transient staging record used to manage the lifecycle of a user-initiated deletion request within the application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique identifier for the wizard session | Primary key; uses a sequence generator. |
| create_uid | INTEGER | true | ID of the user who initiated the wizard | References the users table. |
| write_uid | INTEGER | true | ID of the user who last modified the wizard session | References the users table. |
| create_date | TIMESTAMP | true | Timestamp when the wizard session was created | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp when the wizard session was last updated | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record creation tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a "wizard" or "transient" model; records are typically short-lived and may be purged by the source system after the deletion process completes.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The table does not contain business data regarding the task types themselves, only the metadata for the deletion operation.