# project_task_type_project_task_type_delete_wizard_rel

## Source system
This table originates from an Odoo ERP or similar modular business application. The naming convention `_rel` combined with the specific association between a "wizard" (a transient UI process) and a "project_task_type" strongly suggests an internal Odoo many-to-many relationship table used to manage state during a bulk deletion or cleanup operation.

## Functional process 
This table supports the project management module's administrative cleanup process. It facilitates the "Project Task Type Delete Wizard," which likely allows users to select multiple task types to be removed or merged, tracking the association between the wizard session and the specific task types targeted for deletion.

## Description
One row represents a single association between a specific deletion wizard instance and a project task type. It serves as a raw landing of a join table, capturing the link between a transient UI process and the underlying task type entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_task_type_delete_wizard_id | INTEGER | false | Foreign key to the wizard session | Represents the ID of the deletion process instance. |
| project_task_type_id | INTEGER | false | Foreign key to the project task type | Represents the ID of the task type being processed. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`project_task_type_delete_wizard_id`, `project_task_type_id`).
- **Foreign keys (inferred):** 
    - `project_task_type_delete_wizard_id` → `project_task_type_delete_wizard.id` (Guess: links to the parent wizard session).
    - `project_task_type_id` → `project_task_type.id` (Guess: links to the target task type definition).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a technical join table; it does not contain business-level attributes, only relational identifiers.
- As a staging table for a "wizard" process, data here is likely transient and may be truncated or cleared frequently by the source system once the deletion operation completes.
- There are no timestamps or audit columns, making it difficult to determine the age or relevance of the records without joining to the parent wizard table.