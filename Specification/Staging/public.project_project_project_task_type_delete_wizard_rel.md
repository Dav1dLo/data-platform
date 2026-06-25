# project_project_project_task_type_delete_wizard_rel

## Source system
This table likely originates from an Odoo ERP or a similar Python-based framework (such as Django or Odoo's ORM) that utilizes automated naming conventions for many-to-many relationship tables. The naming pattern `[model_a]_[model_b]_rel` is characteristic of Odoo's database schema, where it manages associations between project task types and project entities during wizard-based deletion operations.

## Functional process 
This table supports the "Project Management" module, specifically handling the cleanup or configuration of task types associated with projects. It acts as a join table to track the relationship between a specific deletion wizard instance and the project entities affected by the removal of certain task types.

## Description
One row in this table represents a single association between a `project_task_type_delete_wizard` instance and a `project_project` entity. It serves as a raw landing copy of a many-to-many relationship table used by the application's backend logic to manage state during a deletion workflow.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_task_type_delete_wizard_id | INTEGER | false | Foreign key to the deletion wizard instance | Links to the wizard managing the task type removal. |
| project_project_id | INTEGER | false | Foreign key to the project entity | Identifies the project associated with the wizard action. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This table likely relies on a composite primary key consisting of both columns `(project_task_type_delete_wizard_id, project_project_id)`.
- **Foreign keys (inferred):** 
    - `project_task_type_delete_wizard_id` → `project_task_type_delete_wizard.id` (Guess: standard Odoo naming convention for foreign keys).
    - `project_project_id` → `project_project.id` (Guess: standard Odoo naming convention for foreign keys).
- **Natural keys (inferred):** The combination of `(project_task_type_delete_wizard_id, project_project_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns; it is strictly an association table.
- Ensure joins are performed on both columns to maintain referential integrity, as neither column is likely unique on its own.
- This table is likely transient, populated only while a deletion wizard is active in the source system.