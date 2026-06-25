# project_update

## Source system
The table likely originates from an Odoo or similar ERP/Project Management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a strong indicator of the Odoo framework's standard audit trail pattern.

## Functional process 
This table supports project tracking and status reporting. It captures periodic updates on project progress, task completion metrics, and descriptive status notes, facilitating project management workflows and stakeholder communication.

## Description
One row represents a single status update or progress report for a specific project at a point in time. As a staging table, it serves as a raw, landed copy of project update records, intended for subsequent transformation into analytical dimensions or fact tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `project_update_id_seq`. |
| progress | INTEGER | true | Percentage of project completion | Likely 0-100 scale. |
| user_id | INTEGER | false | ID of the user associated with the update | Foreign key to a user/employee table. |
| project_id | INTEGER | false | ID of the project being updated | Foreign key to a project master table. |
| task_count | INTEGER | true | Total number of tasks in the project | Snapshot at time of update. |
| closed_task_count | INTEGER | true | Number of completed tasks | Snapshot at time of update. |
| create_uid | INTEGER | true | ID of the user who created the record | Audit field. |
| write_uid | INTEGER | true | ID of the user who last modified the record | Audit field. |
| email_cc | VARCHAR | true | Email addresses copied on the update | May contain multiple comma-separated values. |
| name | VARCHAR | false | Title or subject of the update | |
| status | VARCHAR | false | Current status label | e.g., 'in_progress', 'blocked', 'completed'. |
| date | DATE | true | Business date of the update | |
| description | TEXT | true | Detailed narrative of the update | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Last modification timestamp | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (guess: standard Odoo user reference).
    - `project_id` → `project_project.id` (guess: standard Odoo project reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `email_cc` column may contain PII (email addresses) and should be handled according to data privacy policies.
- **Timestamps:** `create_date` and `write_date` are stored as `TIMESTAMP`. Assume these are in UTC unless otherwise specified by the source system configuration.
- **Data Quality:** `progress`, `task_count`, and `closed_task_count` are nullable; ensure your aggregations handle nulls appropriately (e.g., using `COALESCE`).
- **Soft Deletes:** There is no explicit `active` or `deleted` flag; assume this table contains the full history of updates as landed from the source.