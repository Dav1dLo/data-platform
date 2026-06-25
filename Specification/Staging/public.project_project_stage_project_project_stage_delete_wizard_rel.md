# project_project_stage_project_project_stage_delete_wizard_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `model_a_model_b_rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationship tables in the underlying PostgreSQL database.

## Functional process 
This table supports the project management module, specifically handling the deletion workflow for project stages. It acts as a join table to associate specific project stage records with a delete wizard session, likely tracking which stages are flagged for removal during a bulk deletion operation.

## Description
One row in this table represents a single association between a `project_project_stage` record and a `project_project_stage_delete_wizard` session. It serves as a raw landing copy of the many-to-many relationship link, enabling the application to maintain referential integrity during the deletion process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_project_stage_delete_wizard_id | INTEGER | false | Foreign key to the delete wizard session | Links to the wizard instance managing the deletion. |
| project_project_stage_id | INTEGER | false | Foreign key to the project stage | Identifies the specific stage being processed for deletion. |

## Keys

- **Primary key (inferred):** The combination of `(project_project_stage_delete_wizard_id, project_project_stage_id)`.
- **Foreign keys (inferred):** 
    - `project_project_stage_delete_wizard_id` → `project_project_stage_delete_wizard.id`: This column references the parent wizard session.
    - `project_project_stage_id` → `project_project_stage.id`: This column references the specific project stage entity.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship identifiers.
- There is no surrogate primary key column; queries should use the composite key for joins or deduplication.
- As a staging table for a wizard process, data here is likely transient and may be truncated or cleared by the application once the deletion operation is completed.